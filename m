Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1347610
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfFPRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 13:23:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:33650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfFPRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:23:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 10:23:43 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2019 10:23:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new scattered features word 11
Date:   Sun, 16 Jun 2019 10:14:09 -0700
Message-Id: <1560705250-211820-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a waste for the four X86_FEATURE_CQM_* features to occupy two
pure feature bits words. To better utilize feature words, re-define
word 11 to host scattered features and move the four X86_FEATURE_CQM_*
features into Linux defined word 11. More scattered features can be added
in word 11 in the future.

Leaf 11 in cpuid_leafs is renamed as CPUID_LNX_4 to reflect it's a Linux
defined leaf.

Although word 12 doesn't have any feature now, leaf 12 in cpuid_leafs
still needs to be kept because cpuid_leafs must have NCAPINTS leafs.
Rename leaf 12 as CPUID_DUMMY which will be replaced by a meaningful name
in the next patch when CPUID.7.1:EAX occupies world 12.

KVM doesn't support resctrl now. So it's safe to move the
X86_FEATURE_CQM_* features to scattered features word 11 for KVM.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeature.h  |  4 ++--
 arch/x86/include/asm/cpufeatures.h | 17 ++++++++++-------
 arch/x86/kernel/cpu/common.c       | 14 --------------
 arch/x86/kernel/cpu/cpuid-deps.c   |  3 +++
 arch/x86/kernel/cpu/scattered.c    |  4 ++++
 arch/x86/kvm/cpuid.h               |  2 --
 6 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1d337c51f7e6..403f70c2e431 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -22,8 +22,8 @@ enum cpuid_leafs
 	CPUID_LNX_3,
 	CPUID_7_0_EBX,
 	CPUID_D_1_EAX,
-	CPUID_F_0_EDX,
-	CPUID_F_1_EDX,
+	CPUID_LNX_4,
+	CPUID_DUMMY,
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 75f27ee2c263..4f0a3d093794 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -269,13 +269,16 @@
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
-#define X86_FEATURE_CQM_LLC		(11*32+ 1) /* LLC QoS if 1 */
-
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:1 (EDX), word 12 */
-#define X86_FEATURE_CQM_OCCUP_LLC	(12*32+ 0) /* LLC occupancy monitoring */
-#define X86_FEATURE_CQM_MBM_TOTAL	(12*32+ 1) /* LLC Total MBM monitoring */
-#define X86_FEATURE_CQM_MBM_LOCAL	(12*32+ 2) /* LLC Local MBM monitoring */
+/*
+ * Extended auxiliary flags: Linux defined - For features scattered in various
+ * CPUID levels like 0xf, word 11.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* LLC QoS if 1 */
+#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
+#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
+#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 38e4b1a9005e..5b0e9d869ce5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -832,20 +832,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/* Additional Intel-defined flags: level 0x0000000F */
-	if (c->cpuid_level >= 0x0000000F) {
-
-		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
-		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
-		c->x86_capability[CPUID_F_0_EDX] = edx;
-
-		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
-			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
-			c->x86_capability[CPUID_F_1_EDX] = edx;
-		}
-	}
-
 	/* AMD-defined flags: level 0x80000001 */
 	eax = cpuid_eax(0x80000000);
 	c->extended_cpuid_level = eax;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..fa07a224e7b9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -59,6 +59,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 94aa1c72ca98..adf9b71386ef 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -26,6 +26,10 @@ struct cpuid_bit {
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	CPUID_EDX,  2, 0x0000000f, 1 },
 	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
 	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 9a327d5b6d1f..d78a61408243 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
 	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
 	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
-	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
-	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},
 	[CPUID_8000_0008_EBX] = {0x80000008, 0, CPUID_EBX},
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
-- 
2.19.1

