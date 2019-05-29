Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB42D51C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 07:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2FiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 01:38:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:52060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfE2Fh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:37:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 22:37:58 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2019 22:37:57 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [PATCH v7 2/3] x86: Add the support of Linux guest on ACRN hypervisor
Date:   Wed, 29 May 2019 13:33:56 +0800
Message-Id: <1559108037-18813-3-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRN is an open-source hypervisor maintained by Linux Foundation.
It is built for embedded IOT with small footprint and real-time features.
Add the ACRN guest support so that it allows linux to be booted under the
ACRN hypervisor. Following this patch it will setup the upcall
notification vector, enable hypercall and provide the interface that is
used to manage the virtualized CPU/memory/device/interrupt for other
guest OS.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
understand.
        Remove the export of x86_hyper_acrn.

v2->v3: Remove the unnecessary dependency of PARAVIRT
v3->v4: Refine the commit log and add more meaningful description in Kconfig
v4->v5: No change
v5->v6: No change
v6->v7: No change
---
 arch/x86/Kconfig                  | 12 ++++++++++++
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 39 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
 5 files changed, 57 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/acrn.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c9ab090..3020bc7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -835,6 +835,18 @@ config JAILHOUSE_GUEST
 	  cell. You can leave this option disabled if you only want to start
 	  Jailhouse and run Linux afterwards in the root cell.
 
+config ACRN_GUEST
+	bool "ACRN Guest support"
+	depends on X86_64
+	help
+	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
+	  this will allow the kernel to boot in virtualized environment under
+	  the ACRN hypervisor.
+	  ACRN is a flexible, lightweight reference open-source hypervisor, built
+	  with real-time and safety-criticality in mind. It is built for embedded
+	  IOT with small footprint and real-time features. More details can be
+	  found in https://projectacrn.org/
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 8c5aaba..50a30f6 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -29,6 +29,7 @@ enum x86_hypervisor_type {
 	X86_HYPER_XEN_HVM,
 	X86_HYPER_KVM,
 	X86_HYPER_JAILHOUSE,
+	X86_HYPER_ACRN,
 };
 
 #ifdef CONFIG_HYPERVISOR_GUEST
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1796d2b..b9b3017 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
new file mode 100644
index 0000000..f556640
--- /dev/null
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN detection support
+ *
+ * Copyright (C) 2019 Intel Corporation. All rights reserved.
+ *
+ * Jason Chen CJ <jason.cj.chen@intel.com>
+ * Zhao Yakui <yakui.zhao@intel.com>
+ *
+ */
+
+#include <asm/hypervisor.h>
+
+static uint32_t __init acrn_detect(void)
+{
+	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
+}
+
+static void __init acrn_init_platform(void)
+{
+}
+
+static bool acrn_x2apic_available(void)
+{
+	/* x2apic is not supported now.
+	 * Later it needs to check the X86_FEATURE_X2APIC bit of cpu info
+	 * returned by CPUID to determine whether the x2apic is
+	 * supported in Linux guest.
+	 */
+	return false;
+}
+
+const __initconst struct hypervisor_x86 x86_hyper_acrn = {
+	.name                   = "ACRN",
+	.detect                 = acrn_detect,
+	.type			= X86_HYPER_ACRN,
+	.init.init_platform     = acrn_init_platform,
+	.init.x2apic_available  = acrn_x2apic_available,
+};
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 479ca47..87e39ad 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -32,6 +32,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
 extern const struct hypervisor_x86 x86_hyper_xen_hvm;
 extern const struct hypervisor_x86 x86_hyper_kvm;
 extern const struct hypervisor_x86 x86_hyper_jailhouse;
+extern const struct hypervisor_x86 x86_hyper_acrn;
 
 static const __initconst struct hypervisor_x86 * const hypervisors[] =
 {
@@ -49,6 +50,9 @@ static const __initconst struct hypervisor_x86 * const hypervisors[] =
 #ifdef CONFIG_JAILHOUSE_GUEST
 	&x86_hyper_jailhouse,
 #endif
+#ifdef CONFIG_ACRN_GUEST
+	&x86_hyper_acrn,
+#endif
 };
 
 enum x86_hypervisor_type x86_hyper_type;
-- 
2.7.4

