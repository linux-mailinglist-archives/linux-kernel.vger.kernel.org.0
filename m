Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11411A8897
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfIDOPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:15:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfIDOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:15:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5W4S-0005HG-EP; Wed, 04 Sep 2019 16:15:40 +0200
Date:   Wed, 4 Sep 2019 16:15:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH] hrtimer: Add a missing bracket and hide `migration_base' on
 !SMP
Message-ID: <20190904141540.xucehzbndjmgkrio@linutronix.de>
References: <20190821092409.13225-4-julien.grall@arm.com>
 <156652633520.11649.15892124550118329976.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156652633520.11649.15892124550118329976.tip-bot2@tip-bot2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
   68b2c8c1e4210 ("hrtimer: Don't take expiry_lock when timer is currently migrated")

missed to add a bracket at the end of the if statement leading to
compile errors.
Since that commit the variable `migration_base' is always used but only
available on SMP configuration thus leading to another compile error.
The changelog says
  "The timer base and base->cpu_base cannot be NULL in the code path"

so it is safe to limit this check to SMP configurations only.

Add the missing bracket to the if statement and hide `migration_base'
behind CONFIG_SMP bars.

Fixes: 68b2c8c1e4210 ("hrtimer: Don't take expiry_lock when timer is currently migrated")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f5a1a5e16216c..bc84c74ae5b96 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1216,12 +1216,16 @@ void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 {
 	/* Lockless read. Prevent the compiler from reloading it below */
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
+	bool is_migration_base = false;
 
 	/*
 	 * Just relax if the timer expires in hard interrupt context or if
 	 * it is currently on the migration base.
 	 */
-	if (!timer->is_soft || base == &migration_base)
+#ifdef CONFIG_SMP
+	is_migration_base = base == &migration_base;
+#endif
+	if (timer->is_soft || is_migration_base) {
 		cpu_relax();
 		return;
 	}
-- 
2.23.0
