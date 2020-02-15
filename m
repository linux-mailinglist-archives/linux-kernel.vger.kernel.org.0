Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8819D15FB83
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBOAha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBOAh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:29 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807422083B;
        Sat, 15 Feb 2020 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727048;
        bh=YIkqP6FqAwpSoZTAWqZjr5NvJrMRZ5os7JHCxlxeJN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDzvGViPj1Vp+CWWn/hygokQ0sJhyO68ENOn+/Ry5RjywnMqAKQcYGVOZ0OFSVDnB
         n05ATXWQAUnz4gCXUOI74L/a4PzA86X27VPVRrBXWD0J+gI88Uh3kA759XK+mjJq2u
         nVC9IdI0MXsON4W6ix4UHwT3nnpmnqc5UO9/N/BA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/18] torture: Forgive -EBUSY from boottime CPU-hotplug operations
Date:   Fri, 14 Feb 2020 16:36:57 -0800
Message-Id: <20200215003711.16463-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

During boot, CPU hotplug is often disabled, for example by PCI probing.
On large systems that take substantial time to boot, this can result
in spurious RCU_HOTPLUG errors.  This commit therefore forgives any
boottime -EBUSY CPU-hotplug failures by adjusting counters to pretend
that the corresponding attempt never happened.  A non-splat record
of the failed attempt is emitted to the console with the added string
"(-EBUSY forgiven during boot)".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f55..e377b5b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -84,6 +84,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 {
 	unsigned long delta;
 	int ret;
+	char *s;
 	unsigned long starttime;
 
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -99,10 +100,16 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 	(*n_offl_attempts)++;
 	ret = cpu_down(cpu);
 	if (ret) {
+		s = "";
+		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
+			// PCI probe frequently disables hotplug during boot.
+			(*n_offl_attempts)--;
+			s = " (-EBUSY forgiven during boot)";
+		}
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
-				 "torture_onoff task: offline %d failed: errno %d\n",
-				 torture_type, cpu, ret);
+				 "torture_onoff task: offline %d failed%s: errno %d\n",
+				 torture_type, cpu, s, ret);
 	} else {
 		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG
@@ -137,6 +144,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 {
 	unsigned long delta;
 	int ret;
+	char *s;
 	unsigned long starttime;
 
 	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -150,10 +158,16 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 	(*n_onl_attempts)++;
 	ret = cpu_up(cpu);
 	if (ret) {
+		s = "";
+		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
+			// PCI probe frequently disables hotplug during boot.
+			(*n_onl_attempts)--;
+			s = " (-EBUSY forgiven during boot)";
+		}
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
-				 "torture_onoff task: online %d failed: errno %d\n",
-				 torture_type, cpu, ret);
+				 "torture_onoff task: online %d failed%s: errno %d\n",
+				 torture_type, cpu, s, ret);
 	} else {
 		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG
-- 
2.9.5

