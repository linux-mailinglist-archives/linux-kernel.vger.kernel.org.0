Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7438EF41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 05:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfD3DsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 23:48:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:54863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfD3DsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:48:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 20:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="138598241"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2019 20:48:18 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH v6 1/4] x86/Kconfig: Add new config symbol to unify conditional definition of hv_irq_callback_count
Date:   Tue, 30 Apr 2019 11:45:23 +0800
Message-Id: <1556595926-17910-2-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a special Kconfig symbol X86_HV_CALLBACK_VECTOR so that the guests
using the hypervisor interrupt callback counter can select and thus
enable that counter. Select it when xen or hyperv support is enabled.
No functional changes.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v3->v4: Follow the comments to refine the commit log.
---
 arch/x86/Kconfig               | 3 +++
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 2 +-
 arch/x86/xen/Kconfig           | 1 +
 drivers/hv/Kconfig             | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fd..2fc9297 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -791,6 +791,9 @@ config QUEUED_LOCK_STAT
 	  behavior of paravirtualized queued spinlocks and report
 	  them on debugfs.
 
+config X86_HV_CALLBACK_VECTOR
+	def_bool n
+
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb..0753379 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -37,7 +37,7 @@ typedef struct {
 #ifdef CONFIG_X86_MCE_AMD
 	unsigned int irq_deferred_error_count;
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	unsigned int irq_hv_callback_count;
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2e..a147826 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -134,7 +134,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
 		seq_printf(p, "%*s: ", prec, "HYP");
 		for_each_online_cpu(j)
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index e07abef..ba5a418 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -7,6 +7,7 @@ config XEN
 	bool "Xen guest support"
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
+	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a251..cafcb97 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -6,6 +6,7 @@ config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.7.4

