Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712AE4FBD9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFWN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 09:28:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33448 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfFWN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X0-0001kB-Cm; Sun, 23 Jun 2019 15:27:42 +0200
Message-Id: <20190623132435.058540608@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 11/29] x86/hpet: Separate counter check out of clocksource
 register code
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init code checks whether the HPET counter works late in the init
function when the clocksource is registered. That should happen right with
the other sanity checks.

Split it into a separate validation function and move it to the other
sanity checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   65 +++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -809,38 +809,6 @@ static struct clocksource clocksource_hp
 	.resume		= hpet_resume_counter,
 };
 
-static int __init hpet_clocksource_register(void)
-{
-	u64 start, now;
-	u64 t1;
-
-	/* Start the counter */
-	hpet_restart_counter();
-
-	/* Verify whether hpet counter works */
-	t1 = hpet_readl(HPET_COUNTER);
-	start = rdtsc();
-
-	/*
-	 * We don't know the TSC frequency yet, but waiting for
-	 * 200000 TSC cycles is safe:
-	 * 4 GHz == 50us
-	 * 1 GHz == 200us
-	 */
-	do {
-		rep_nop();
-		now = rdtsc();
-	} while ((now - start) < 200000UL);
-
-	if (t1 == hpet_readl(HPET_COUNTER)) {
-		pr_warn("Counter not counting. HPET disabled\n");
-		return -ENODEV;
-	}
-
-	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
-	return 0;
-}
-
 /*
  * AMD SB700 based systems with spread spectrum enabled use a SMM based
  * HPET emulation to provide proper frequency setting.
@@ -869,6 +837,32 @@ static bool __init hpet_cfg_working(void
 	return false;
 }
 
+static bool __init hpet_counting(void)
+{
+	u64 start, now, t1;
+
+	hpet_restart_counter();
+
+	t1 = hpet_readl(HPET_COUNTER);
+	start = rdtsc();
+
+	/*
+	 * We don't know the TSC frequency yet, but waiting for
+	 * 200000 TSC cycles is safe:
+	 * 4 GHz == 50us
+	 * 1 GHz == 200us
+	 */
+	do {
+		rep_nop();
+		now = rdtsc();
+	} while ((now - start) < 200000UL);
+
+	if (t1 == hpet_readl(HPET_COUNTER)) {
+		pr_warn("Counter not counting. HPET disabled\n");
+		return false;
+	}
+	return true;
+}
 
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
@@ -890,6 +884,10 @@ int __init hpet_enable(void)
 	if (!hpet_cfg_working())
 		goto out_nohpet;
 
+	/* Validate that the counter is counting */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	/*
 	 * Read the period and check for a sane value:
 	 */
@@ -948,8 +946,7 @@ int __init hpet_enable(void)
 	}
 	hpet_print_config();
 
-	if (hpet_clocksource_register())
-		goto out_nohpet;
+	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
 		hpet_legacy_clockevent_register();


