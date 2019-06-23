Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31C4FBD6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFWN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 09:28:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33525 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfFWN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X6-0001lR-UD; Sun, 23 Jun 2019 15:27:49 +0200
Message-Id: <20190623132436.002758910@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 21/29] x86/hpet: Add function to select a /dev/hpet channel
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HPET=y is enabled the x86 specific HPET code should reserve at
least one channel for the /dev/hpet character device, so that not all
channels are absorbed for per CPU clockevent devices.

Create a function to assign HPET_MODE_DEVICE so the rework of the
clockevents allocation code can utilize the mode information instead of
reducing the number of evaluated channels by #ifdef hackery.

The function is not yet used, but provided as a separate patch for ease of
review. It will be used when the rework of the clockevent selection takes
place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -228,8 +228,25 @@ static void __init hpet_reserve_platform
 	hpet_alloc(&hd);
 
 }
+
+static void __init hpet_select_device_channel(void)
+{
+	int i;
+
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+
+		/* Associate the first unused channel to /dev/hpet */
+		if (hc->mode == HPET_MODE_UNUSED) {
+			hc->mode = HPET_MODE_DEVICE;
+			return;
+		}
+	}
+}
+
 #else
 static inline void hpet_reserve_platform_timers(void) { }
+static inline void hpet_select_device_channel(void) {}
 #endif
 
 /* Common HPET functions */


