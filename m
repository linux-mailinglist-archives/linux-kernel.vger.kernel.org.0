Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A364A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfGJQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 12:18:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48159 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGJQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:18:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hlFIB-0006g7-J8; Wed, 10 Jul 2019 18:18:03 +0200
Date:   Wed, 10 Jul 2019 18:18:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.21-rt16
Message-ID: <20190710161803.zawkhyhvbc34skw6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.21-rt16 patch set. 

Changes since v5.0.21-rt15:

  - Do not invoke softirq if ksoftirqd has been scheduled. This change
    aligns softirq handling closer with mainline. A busy network driver
    will now handover further processing to ksoftirqd. This wasn't the
    case since the recent softirq rework.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.21-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.21-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.21-rt16

The RT patch against v5.0.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.21-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.21-rt16.tar.xz

Sebastian

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4fae96f23c54..dc31f1b4ee217 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -78,7 +78,6 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
  * right now. Let ksoftirqd handle this at its own rate, to get fairness,
@@ -93,7 +92,6 @@ static bool ksoftirqd_running(unsigned long pending)
 		return false;
 	return tsk && (tsk->state == TASK_RUNNING);
 }
-#endif
 
 /*
  * preempt_count and SOFTIRQ_OFFSET usage:
@@ -173,7 +171,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 
 	if (unlikely(count == 1)) {
 		pending = local_softirq_pending();
-		if (pending) {
+		if (pending && !ksoftirqd_running(pending)) {
 			if (!in_atomic())
 				__do_softirq();
 			else
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d4..1199ebade17b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
