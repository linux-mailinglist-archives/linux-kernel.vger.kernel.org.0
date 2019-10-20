Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE7DDE13
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJTKPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 06:15:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfJTKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:14:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM8Eh-0007VN-Fi; Sun, 20 Oct 2019 12:14:55 +0200
Date:   Sun, 20 Oct 2019 10:13:56 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.4-rc4
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
Message-ID: <157156643658.8795.9500007947486352048.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  ff229eee3d89: hrtimer: Annotate lockless access to timer->base

A single commit annotating the lockcless access to timer->base with
READ_ONCE() and adding the WRITE_ONCE() counterparts for completeness.

Thanks,

	tglx

------------------>
Eric Dumazet (1):
      hrtimer: Annotate lockless access to timer->base


 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0d4dc241c0fb..65605530ee34 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -164,7 +164,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 	struct hrtimer_clock_base *base;
 
 	for (;;) {
-		base = timer->base;
+		base = READ_ONCE(timer->base);
 		if (likely(base != &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base == timer->base))
@@ -244,7 +244,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			return base;
 
 		/* See the comment in lock_hrtimer_base() */
-		timer->base = &migration_base;
+		WRITE_ONCE(timer->base, &migration_base);
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
@@ -253,10 +253,10 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
-			timer->base = base;
+			WRITE_ONCE(timer->base, base);
 			goto again;
 		}
-		timer->base = new_base;
+		WRITE_ONCE(timer->base, new_base);
 	} else {
 		if (new_cpu_base != this_cpu_base &&
 		    hrtimer_check_target(timer, new_base)) {


