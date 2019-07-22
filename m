Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCC70900
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfGVS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:57:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38187 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbfGVS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUn-0002Sk-2f; Mon, 22 Jul 2019 20:57:13 +0200
Message-Id: <20190722105220.951534451@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 23/25] x86/apic: Share common IPI helpers
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 64bit implementations need the same wrappers around
__default_send_IPI_shortcut() as 32bit.

Move them out of the 32bit section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/apic/ipi.c   |   30 +++++++++++++++---------------
 arch/x86/kernel/apic/local.h |    6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -226,6 +226,21 @@ void default_send_IPI_single(int cpu, in
 	apic->send_IPI_mask(cpumask_of(cpu), vector);
 }
 
+void default_send_IPI_allbutself(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+}
+
+void default_send_IPI_all(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
+void default_send_IPI_self(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+}
+
 #ifdef CONFIG_X86_32
 
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
@@ -285,21 +300,6 @@ void default_send_IPI_mask_logical(const
 	local_irq_restore(flags);
 }
 
-void default_send_IPI_allbutself(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-}
-
-void default_send_IPI_all(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-}
-
-void default_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -56,12 +56,12 @@ void default_send_IPI_single(int cpu, in
 void default_send_IPI_single_phys(int cpu, int vector);
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_allbutself(int vector);
+void default_send_IPI_all(int vector);
+void default_send_IPI_self(int vector);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
-void default_send_IPI_allbutself(int vector);
-void default_send_IPI_all(int vector);
-void default_send_IPI_self(int vector);
 #endif


