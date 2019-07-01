Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2F4FBE2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfFWN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 09:29:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33420 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfFWN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wy-0001jX-2D; Sun, 23 Jun 2019 15:27:40 +0200
Message-Id: <20190623132434.645357869@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 07/29] x86/hpet: Mark init functions __init
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are only called from init code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -176,7 +176,7 @@ do {								\
 
 static void hpet_reserve_msi_timers(struct hpet_data *hd);
 
-static void hpet_reserve_platform_timers(unsigned int id)
+static void __init hpet_reserve_platform_timers(unsigned int id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
 	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
@@ -572,7 +572,7 @@ static void init_one_hpet_msi_clockevent
 #define RESERVE_TIMERS 0
 #endif
 
-static void hpet_msi_capability_lookup(unsigned int start_timer)
+static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 {
 	unsigned int id;
 	unsigned int num_timers;
@@ -631,7 +631,7 @@ static void hpet_msi_capability_lookup(u
 }
 
 #ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
+static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
 {
 	int i;
 


