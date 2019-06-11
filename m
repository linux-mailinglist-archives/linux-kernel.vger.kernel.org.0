Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF54164B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436518AbfFKUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 16:45:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436506AbfFKUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:45:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BKixth367352
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 13:44:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BKixth367352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560285900;
        bh=y6qm4URORM0BZT+Va2oAPRBsgwlAPshwKCTtkQnav3c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=g3/JdsAlGZd4bNWofjrXgqH4trBROA8wyBSJX2dUOrGZf+skltxD0DtgJ9W2ORGQF
         8FfuqJ1F3Mq3xOEP6KMG9AZoNyG6wCDJB6LsZGBGGyGlUCMQm4GH1gZChebq0Ccndv
         awpTsL1J6VPjHAvh7RwrIOUv7b+YPVaUPTzQyt3RBWAlEUND8AaR8b0auiF78U5NsZ
         5ZRKlEHYtZ96USgfsf+UpiCt3qQ/5A7a0t8GqDt/g3DItPgRuQnX2+m+azbXTU87gq
         SsKSy4V5AfpzjaVrCsperCOsPEmU5iUkmKQr/Qr9KIO+Oh5miyWVU3FqR2O+7SV+UB
         csC1z75Ospp7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BKiw6Z367349;
        Tue, 11 Jun 2019 13:44:58 -0700
Date:   Tue, 11 Jun 2019 13:44:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhao Yakui <tipbot@zytor.com>
Message-ID: <tip-498ad39368865dfdbf15d3516c43694947074b88@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        yakui.zhao@intel.com, hpa@zytor.com, mingo@kernel.org,
        mingo@redhat.com, bp@suse.de, luto@kernel.org,
        jason.cj.chen@intel.com, x86@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          yakui.zhao@intel.com, mingo@redhat.com, mingo@kernel.org,
          bp@suse.de, x86@kernel.org, jason.cj.chen@intel.com,
          luto@kernel.org
In-Reply-To: <1559108037-18813-4-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-4-git-send-email-yakui.zhao@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
Git-Commit-ID: 498ad39368865dfdbf15d3516c43694947074b88
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  498ad39368865dfdbf15d3516c43694947074b88
Gitweb:     https://git.kernel.org/tip/498ad39368865dfdbf15d3516c43694947074b88
Author:     Zhao Yakui <yakui.zhao@intel.com>
AuthorDate: Tue, 30 Apr 2019 11:45:25 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 21:31:31 +0200

x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector

Use the HYPERVISOR_CALLBACK_VECTOR to notify an ACRN guest.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1559108037-18813-4-git-send-email-yakui.zhao@intel.com
---
 arch/x86/Kconfig            |  1 +
 arch/x86/entry/entry_64.S   |  5 +++++
 arch/x86/include/asm/acrn.h | 11 +++++++++++
 arch/x86/kernel/cpu/acrn.c  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8a95c50e5c12..0ddcce78f85c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -838,6 +838,7 @@ config JAILHOUSE_GUEST
 config ACRN_GUEST
 	bool "ACRN Guest support"
 	depends on X86_64
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  This option allows to run Linux as guest in the ACRN hypervisor. ACRN is
 	  a flexible, lightweight reference open-source hypervisor, built with
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 11aa3b2afa4d..2fe62893bbdf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1142,6 +1142,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_ACRN_GUEST)
+apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
+	acrn_hv_callback_vector acrn_hv_vector_handler
+#endif
+
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
 idtentry int3			do_int3			has_error_code=0	create_gap=1
 idtentry stack_segment		do_stack_segment	has_error_code=1
diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
new file mode 100644
index 000000000000..4adb13f08af7
--- /dev/null
+++ b/arch/x86/include/asm/acrn.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRN_H
+#define _ASM_X86_ACRN_H
+
+extern void acrn_hv_callback_vector(void);
+#ifdef CONFIG_TRACING
+#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
+#endif
+
+extern void acrn_hv_vector_handler(struct pt_regs *regs);
+#endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 6d365e97cce6..676022e71791 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -9,7 +9,12 @@
  *
  */
 
+#include <linux/interrupt.h>
+#include <asm/acrn.h>
+#include <asm/apic.h>
+#include <asm/desc.h>
 #include <asm/hypervisor.h>
+#include <asm/irq_regs.h>
 
 static uint32_t __init acrn_detect(void)
 {
@@ -18,6 +23,8 @@ static uint32_t __init acrn_detect(void)
 
 static void __init acrn_init_platform(void)
 {
+	/* Setup the IDT for ACRN hypervisor callback */
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, acrn_hv_callback_vector);
 }
 
 static bool acrn_x2apic_available(void)
@@ -30,6 +37,29 @@ static bool acrn_x2apic_available(void)
 	return false;
 }
 
+static void (*acrn_intr_handler)(void);
+
+__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/*
+	 * The hypervisor requires that the APIC EOI should be acked.
+	 * If the APIC EOI is not acked, the APIC ISR bit for the
+	 * HYPERVISOR_CALLBACK_VECTOR will not be cleared and then it
+	 * will block the interrupt whose vector is lower than
+	 * HYPERVISOR_CALLBACK_VECTOR.
+	 */
+	entering_ack_irq();
+	inc_irq_stat(irq_hv_callback_count);
+
+	if (acrn_intr_handler)
+		acrn_intr_handler();
+
+	exiting_irq();
+	set_irq_regs(old_regs);
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.name                   = "ACRN",
 	.detect                 = acrn_detect,
