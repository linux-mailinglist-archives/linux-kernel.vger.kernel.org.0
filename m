Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9CAB267F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfIMUMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 16:12:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35426 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfIMUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:12:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i8rw2-0003Ef-5N; Fri, 13 Sep 2019 22:12:50 +0200
Date:   Fri, 13 Sep 2019 22:12:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.14-rt7
Message-ID: <20190913201249.jyzvguhr6g3ayovo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.14-rt7 patch set. 

Changes since v5.2.14-rt6:

  - The recent hrtimer fix broke UP builds as reported by Alexander
    Dahl.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.2.14-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.14-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.14-rt7

The RT patch against v5.2.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.14-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.14-rt7.tar.xz

Sebastian

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5eb45a868de9a..b3adac366fd17 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -141,6 +141,11 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -265,6 +270,11 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -934,7 +944,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && base != &migration_base) {
+	if (timer->is_soft && is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
