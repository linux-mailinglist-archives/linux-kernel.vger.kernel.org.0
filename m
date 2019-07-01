Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9F2E650
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfE2Uhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:37:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40321 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfE2UhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:07 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so5779095itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HCuNhCByhezRwLcyNJ9yd0/1pOFBH2VgXCoBl4+qgT4=;
        b=HzQ+g5pEJVLTPaStxTNKprUNZKRbXKi4at0o9aKsJo0aibcBaEtIy+AihtasRKlx8v
         9Cz3yEWCEvHgGtMDVNdneNKL3zG/9+4W7910Td21z8Bx3pYudLSSSCcyhSvduIXdiX77
         PoPiyJ3MMAL+lJRaKVA29G1TR4RYqsJQA9G6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HCuNhCByhezRwLcyNJ9yd0/1pOFBH2VgXCoBl4+qgT4=;
        b=hgp5bPCNrDkx4/rZDAUcwYnebEqhQo37RfXlhfF5sA05xlqVfyH0G12whBRmLMmMAQ
         9r9xxtiHReRTWVxTiPHenj86YnlTAOCP29ZpQuMQoBfkaBdC8DeEuPB7dKaSA9O+pB9L
         ZuqH34Lx4M9zYhxyAJ7J4qHpSnLoTl0ulYQCoC5WgBmqVeeM/o5VpnGxUSMrdCNFxzKP
         Yg7uG50RAWJd6TAoIXyQx1y4xA1pKgBP41P3tyvK9dFfD14s7OUtLdcZZBCyjNBunPTQ
         QU3pTtD1w5YvIbR1VuFulHOFD0tctXtT7BufnpiR4ZwKy8tw4iqU00R5HmjkfHTxK4fu
         UovQ==
X-Gm-Message-State: APjAAAVcmkDv1fdioPFhiDY8iZjxLZhOgCs3qLFl4AVQycroafxUBrfI
        zGxKfJV7NN4n/ZrmeEFQ2BED8g==
X-Google-Smtp-Source: APXvYqxMASEBAnEcMFLVP85SvmjFOEwOJ18p3kSLG6ve4PMjswxVChd5sZxvRdsyLZ2TebrxPrjLbQ==
X-Received: by 2002:a24:4d87:: with SMTP id l129mr165859itb.80.1559162226063;
        Wed, 29 May 2019 13:37:06 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id q16sm163009ior.75.2019.05.29.13.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:05 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 09/16] sched: Introduce sched_class::pick_task()
Date:   Wed, 29 May 2019 20:36:45 +0000
Message-Id: <b480899e572857c3392d1176811a084084b4cf7f.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---

Chnages in v3
-------------
- Minor refactor to remove redundant NULL checks

Changes in v2
-------------
- Fixes a NULL pointer dereference crash
  - Subhra Mazumdar
  - Tim Chen

---
 kernel/sched/deadline.c  | 21 ++++++++++++++++-----
 kernel/sched/fair.c      | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      | 10 +++++++++-
 kernel/sched/rt.c        | 21 ++++++++++++++++-----
 kernel/sched/sched.h     |  2 ++
 kernel/sched/stop_task.c | 21 ++++++++++++++++-----
 6 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d3904168857a..64fc444f44f9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1722,15 +1722,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *
-pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct task_struct *p;
 	struct dl_rq *dl_rq;
 
-	WARN_ON_ONCE(prev || rf);
-
 	dl_rq = &rq->dl;
 
 	if (unlikely(!dl_rq->dl_nr_running))
@@ -1741,7 +1738,19 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = dl_task_of(dl_se);
 
-	set_next_task_dl(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -2388,6 +2397,8 @@ const struct sched_class dl_sched_class = {
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_dl,
+
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e65f2dfda77a..02e5dfb85e7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4136,7 +4136,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4154,13 +4154,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	/*
 	 * Prefer last buddy, try to return the CPU to a preempted task.
 	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
 		se = cfs_rq->last;
 
 	/*
 	 * Someone really wants this to run. If it's not unfair, run it.
 	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
 		se = cfs_rq->next;
 
 	clear_buddies(cfs_rq, se);
@@ -6966,6 +6966,34 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		set_last_buddy(se);
 }
 
+static struct task_struct *
+pick_task_fair(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct sched_entity *se;
+
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		se = pick_next_entity(cfs_rq, NULL);
+
+		if (curr) {
+			if (se && curr->on_rq)
+				update_curr(cfs_rq);
+
+			if (!se || entity_before(curr, se))
+				se = curr;
+		}
+
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+
 static struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -10677,6 +10705,8 @@ const struct sched_class fair_sched_class = {
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_fair,
+
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7ece8e820b5d..e7f38da60373 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
+static struct task_struct *
+pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
@@ -386,11 +392,12 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next = rq->idle;
+	struct task_struct *next;
 
 	if (prev)
 		put_prev_task(rq, prev);
 
+	next = pick_task_idle(rq);
 	set_next_task_idle(rq, next);
 
 	return next;
@@ -458,6 +465,7 @@ const struct sched_class idle_sched_class = {
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 79f2e60516ef..81557224548c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,20 +1548,29 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *
-pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!rt_rq->rt_queued)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task_rt(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_rt(rq);
+	if (p)
+		set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2364,6 +2373,8 @@ const struct sched_class rt_sched_class = {
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_rt,
+
 	.select_task_rq		= select_task_rq_rt,
 
 	.set_cpus_allowed       = set_cpus_allowed_common,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 460dd04e76af..a024dd80eeb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,6 +1682,8 @@ struct sched_class {
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 7e1cee4e65b2..fb6c436cba6c 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -29,20 +29,30 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
 }
 
 static struct task_struct *
-pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+pick_task_stop(struct rq *rq)
 {
 	struct task_struct *stop = rq->stop;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	set_next_task_stop(rq, stop);
-
 	return stop;
 }
 
+static struct task_struct *
+pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_stop(rq);
+	if (p)
+		set_next_task_stop(rq, p);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -129,6 +139,7 @@ const struct sched_class stop_sched_class = {
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
-- 
2.17.1

