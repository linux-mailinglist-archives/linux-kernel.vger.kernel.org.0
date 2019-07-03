Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFC5E271
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGCLEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 07:04:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfGCLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3d-0002dI-Pz; Wed, 03 Jul 2019 13:04:13 +0200
Message-Id: <20190703105917.044463061@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static key
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcast now depends on the fact that all present CPUs have been booted
once so handling broadcast IPIs is not doing any harm. In case that a CPU
is offline, it does not react to regular IPIs and the NMI handler returns
early.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/ipi.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -8,13 +8,7 @@
 DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_HOTPLUG_CPU
-#define DEFAULT_SEND_IPI	(1)
-#else
-#define DEFAULT_SEND_IPI	(0)
-#endif
-
-static int apic_ipi_shorthand_off __ro_after_init = DEFAULT_SEND_IPI;
+static int apic_ipi_shorthand_off __ro_after_init;
 
 static __init int apic_ipi_shorthand(char *str)
 {
@@ -250,7 +244,7 @@ void default_send_IPI_allbutself(int vec
 	if (num_online_cpus() < 2)
 		return;
 
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
@@ -259,7 +253,7 @@ void default_send_IPI_allbutself(int vec
 
 void default_send_IPI_all(int vector)
 {
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);


