Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9466A12CDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfL3JFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 04:05:13 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:53206 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727175AbfL3JFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:05:12 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from haswell.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 19724165-1500050 
        for multiple; Mon, 30 Dec 2019 09:04:46 +0000
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched/vtime: Prevent unstable evaluation of WARN(vtime->state)
Date:   Mon, 30 Dec 2019 09:04:36 +0000
Message-Id: <20191230090436.3749235-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20191230010839.GA8740@lenoir>
References: <20191230010839.GA8740@lenoir>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the vtime is sampled under loose seqcount protection by kcpustat, the
vtime fields may change as the code flows. Where logic dictates a field
has a static value, use a READ_ONCE.

Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d43318a489f2..96bbd52f43ae 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -914,6 +914,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 
 static int vtime_state_check(struct vtime *vtime, int cpu)
 {
+	int state = READ_ONCE(vtime->state);
+
 	/*
 	 * We raced against a context switch, fetch the
 	 * kcpustat task again.
@@ -930,10 +932,10 @@ static int vtime_state_check(struct vtime *vtime, int cpu)
 	 *
 	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
 	 */
-	if (vtime->state == VTIME_INACTIVE)
+	if (state == VTIME_INACTIVE)
 		return -EAGAIN;
 
-	return 0;
+	return state;
 }
 
 static u64 kcpustat_user_vtime(struct vtime *vtime)
@@ -952,14 +954,15 @@ static int kcpustat_field_vtime(u64 *cpustat,
 {
 	struct vtime *vtime = &tsk->vtime;
 	unsigned int seq;
-	int err;
 
 	do {
+		int state;
+
 		seq = read_seqcount_begin(&vtime->seqcount);
 
-		err = vtime_state_check(vtime, cpu);
-		if (err < 0)
-			return err;
+		state = vtime_state_check(vtime, cpu);
+		if (state < 0)
+			return state;
 
 		*val = cpustat[usage];
 
@@ -972,7 +975,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 		 */
 		switch (usage) {
 		case CPUTIME_SYSTEM:
-			if (vtime->state == VTIME_SYS)
+			if (state == VTIME_SYS)
 				*val += vtime->stime + vtime_delta(vtime);
 			break;
 		case CPUTIME_USER:
@@ -984,11 +987,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				*val += kcpustat_user_vtime(vtime);
 			break;
 		case CPUTIME_GUEST:
-			if (vtime->state == VTIME_GUEST && task_nice(tsk) <= 0)
+			if (state == VTIME_GUEST && task_nice(tsk) <= 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		case CPUTIME_GUEST_NICE:
-			if (vtime->state == VTIME_GUEST && task_nice(tsk) > 0)
+			if (state == VTIME_GUEST && task_nice(tsk) > 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		default:
@@ -1039,23 +1042,23 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 {
 	struct vtime *vtime = &tsk->vtime;
 	unsigned int seq;
-	int err;
 
 	do {
 		u64 *cpustat;
 		u64 delta;
+		int state;
 
 		seq = read_seqcount_begin(&vtime->seqcount);
 
-		err = vtime_state_check(vtime, cpu);
-		if (err < 0)
-			return err;
+		state = vtime_state_check(vtime, cpu);
+		if (state < 0)
+			return state;
 
 		*dst = *src;
 		cpustat = dst->cpustat;
 
 		/* Task is sleeping, dead or idle, nothing to add */
-		if (vtime->state < VTIME_SYS)
+		if (state < VTIME_SYS)
 			continue;
 
 		delta = vtime_delta(vtime);
@@ -1064,15 +1067,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_SYS) {
+		if (state == VTIME_SYS) {
 			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
-		} else if (vtime->state == VTIME_USER) {
+		} else if (state == VTIME_USER) {
 			if (task_nice(tsk) > 0)
 				cpustat[CPUTIME_NICE] += vtime->utime + delta;
 			else
 				cpustat[CPUTIME_USER] += vtime->utime + delta;
 		} else {
-			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			WARN_ON_ONCE(state != VTIME_GUEST);
 			if (task_nice(tsk) > 0) {
 				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
 				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
@@ -1083,7 +1086,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
-	return err;
+	return 0;
 }
 
 void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
-- 
2.25.0.rc0

