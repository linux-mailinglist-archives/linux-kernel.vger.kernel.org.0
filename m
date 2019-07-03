Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443445E286
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 13:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 07:04:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51594 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCLEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3V-0002b7-PQ; Wed, 03 Jul 2019 13:04:05 +0200
Message-Id: <20190703105915.585281835@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 01/18] x86/apic: Invoke perf_events_lapic_init() after
 enabling APIC
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the APIC is soft disabled then unmasking an LVT entry does not work and
the write is ignored. perf_events_lapic_init() tries to do so.

Move the invocation after the point where the APIC has been enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1517,7 +1517,6 @@ static void setup_local_APIC(void)
 	int logical_apicid, ldr_apicid;
 #endif
 
-
 	if (disable_apic) {
 		disable_ioapic_support();
 		return;
@@ -1532,8 +1531,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	perf_events_lapic_init();
-
 	/*
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
@@ -1614,6 +1611,8 @@ static void setup_local_APIC(void)
 	value |= SPURIOUS_APIC_VECTOR;
 	apic_write(APIC_SPIV, value);
 
+	perf_events_lapic_init();
+
 	/*
 	 * Set up LVT0, LVT1:
 	 *


