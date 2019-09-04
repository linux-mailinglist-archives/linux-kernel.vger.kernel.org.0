Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1761A8909
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfIDOzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 10:55:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39502 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfIDOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:55:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5Wgx-0006VY-UK; Wed, 04 Sep 2019 16:55:27 +0200
Date:   Wed, 4 Sep 2019 16:55:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2] hrtimer: Add a missing bracket and hide `migration_base'
 on !SMP
Message-ID: <20190904145527.eah7z56ntwobqm6j@linutronix.de>
References: <20190821092409.13225-4-julien.grall@arm.com>
 <156652633520.11649.15892124550118329976.tip-bot2@tip-bot2>
 <20190904141540.xucehzbndjmgkrio@linutronix.de>
 <alpine.DEB.2.21.1909041633580.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.DEB.2.21.1909041633580.1902@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to avoid taking the expiry lock when a timer is
currently migrated missed to add a bracket at the end of the if
statement leading to compile errors.
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
v1…v2:
	- use is_migration_base() as a helper function
	- slightly reword the commit message

 kernel/time/hrtimer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f5a1a5e16216c..eaf31ac38efbb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -140,6 +140,11 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -264,6 +269,11 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
+static bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1221,7 +1231,7 @@ void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 	 * Just relax if the timer expires in hard interrupt context or if
 	 * it is currently on the migration base.
 	 */
-	if (!timer->is_soft || base == &migration_base)
+	if (!timer->is_soft || is_migration_base(base)) {
 		cpu_relax();
 		return;
 	}
-- 
2.23.0

