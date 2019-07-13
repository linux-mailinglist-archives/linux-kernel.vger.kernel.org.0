Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCE67B5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGMRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:08:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:30255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfGMRId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:08:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="341981089"
Received: from hbriegel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.48])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2019 10:08:26 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v21 02/28] x86/cpufeatures: Add SGX sub-features (as Linux-defined bits)
Date:   Sat, 13 Jul 2019 20:07:38 +0300
Message-Id: <20190713170804.2340-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

CPUID_12_EAX is an Intel-defined feature bits leaf dedicated for SGX
that enumerates the SGX instruction sets that are supported by the
CPU, e.g. SGX1, SGX2, etc...  Because Linux currently only cares about
two bits (SGX1 and SGX2) and there are currently only four documented
bits in total, relocate the bits to Linux-defined word 8 to conserve
space.

But, keep the bit positions identical between the Intel-defined value
and the Linux-defined value, e.g. keep SGX1 at bit 0.  This allows KVM
to use its existing code for probing guest CPUID bits using Linux's
X86_FEATURE_* definitions.  To do so, shift around some existing bits
to effectively reserve bits 0-7 of word 8 for SGX sub-features.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h       | 22 ++++++++++++++++------
 arch/x86/include/asm/disabled-features.h |  6 +++++-
 arch/x86/kernel/cpu/scattered.c          |  2 ++
 tools/arch/x86/include/asm/cpufeatures.h | 21 +++++++++++++++------
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fcc192098df7..c5582e766121 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -222,12 +222,22 @@
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 
-/* Virtualization flags: Linux defined, word 8 */
-#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
-#define X86_FEATURE_VNMI		( 8*32+ 1) /* Intel Virtual NMI */
-#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 2) /* Intel FlexPriority */
-#define X86_FEATURE_EPT			( 8*32+ 3) /* Intel Extended Page Table */
-#define X86_FEATURE_VPID		( 8*32+ 4) /* Intel Virtual Processor ID */
+/*
+ * Scattered Intel features: Linux defined, word 8.
+ *
+ * Note that the bit location of the SGX features is meaningful as KVM expects
+ * the Linux defined bit to match the Intel defined bit, e.g. X86_FEATURE_SGX1
+ * must remain at bit 0, SGX2 at bit 1, etc...
+ */
+#define X86_FEATURE_SGX1		( 8*32+ 0) /* SGX1 leaf functions */
+#define X86_FEATURE_SGX2		( 8*32+ 1) /* SGX2 leaf functions */
+/* Bits [0:7] are reserved for SGX */
+
+#define X86_FEATURE_TPR_SHADOW		( 8*32+ 8) /* Intel TPR Shadow */
+#define X86_FEATURE_VNMI		( 8*32+ 9) /* Intel Virtual NMI */
+#define X86_FEATURE_FLEXPRIORITY	( 8*32+10) /* Intel FlexPriority */
+#define X86_FEATURE_EPT			( 8*32+11) /* Intel Extended Page Table */
+#define X86_FEATURE_VPID		( 8*32+12) /* Intel Virtual Processor ID */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 74de07d0f390..926f9dc4d75a 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -34,12 +34,16 @@
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
 # define DISABLE_PCID		0
+# define DISABLE_SGX1		0
+# define DISABLE_SGX2		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
 # define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
+# define DISABLE_SGX1		(1<<(X86_FEATURE_SGX1 & 31))
+# define DISABLE_SGX2		(1<<(X86_FEATURE_SGX2 & 31))
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -79,7 +83,7 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	0
+#define DISABLED_MASK8	(DISABLE_SGX1|DISABLE_SGX2)
 #define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP|DISABLE_SGX_CORE)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index adf9b71386ef..9aea45c0b494 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -35,6 +35,8 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
 	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
+	{ X86_FEATURE_SGX1,             CPUID_EAX,  0, 0x00000012, 0 },
+	{ X86_FEATURE_SGX2,             CPUID_EAX,  1, 0x00000012, 0 },
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..189c5cdbf68f 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -222,12 +222,21 @@
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 
-/* Virtualization flags: Linux defined, word 8 */
-#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
-#define X86_FEATURE_VNMI		( 8*32+ 1) /* Intel Virtual NMI */
-#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 2) /* Intel FlexPriority */
-#define X86_FEATURE_EPT			( 8*32+ 3) /* Intel Extended Page Table */
-#define X86_FEATURE_VPID		( 8*32+ 4) /* Intel Virtual Processor ID */
+/*
+ * Scattered Intel features: Linux defined, word 8.
+ *
+ * Note that the bit numbers of the SGX features are meaningful as KVM expects
+ * the Linux defined bit to match the Intel defined bit, e.g. X86_FEATURE_SGX1
+ * must remain at bit 0, SGX2 at bit 1, etc...
+ */
+#define X86_FEATURE_SGX1		( 8*32+ 0) /* SGX1 leaf functions */
+#define X86_FEATURE_SGX2		( 8*32+ 1) /* SGX2 leaf functions */
+
+#define X86_FEATURE_TPR_SHADOW		( 8*32+ 8) /* Intel TPR Shadow */
+#define X86_FEATURE_VNMI		( 8*32+ 9) /* Intel Virtual NMI */
+#define X86_FEATURE_FLEXPRIORITY	( 8*32+10) /* Intel FlexPriority */
+#define X86_FEATURE_EPT			( 8*32+11) /* Intel Extended Page Table */
+#define X86_FEATURE_VPID		( 8*32+12) /* Intel Virtual Processor ID */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
-- 
2.20.1

