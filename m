Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222524FBE1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFWN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 09:29:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33424 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfFWN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wy-0001jc-Nz; Sun, 23 Jun 2019 15:27:40 +0200
Message-Id: <20190623132434.754768274@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 08/29] x86/hpet: Sanitize stub functions
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark them inline and remove the pointless 'return;' statement.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -692,16 +692,10 @@ static int hpet_cpuhp_dead(unsigned int
 }
 #else
 
-static void hpet_msi_capability_lookup(unsigned int start_timer)
-{
-	return;
-}
+static inline void hpet_msi_capability_lookup(unsigned int start_timer) { }
 
 #ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
-{
-	return;
-}
+static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
 #endif
 
 #define hpet_cpuhp_online	NULL
@@ -820,7 +814,7 @@ static struct clocksource clocksource_hp
 	.resume		= hpet_resume_counter,
 };
 
-static int hpet_clocksource_register(void)
+static int __init hpet_clocksource_register(void)
 {
 	u64 start, now;
 	u64 t1;


