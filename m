Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D619447611
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfFPRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 13:23:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:33650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfFPRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 3/3] x86/cpufeatures: Enumerate new AVX512 BFLOAT16 instructions
Date:   Sun, 16 Jun 2019 10:14:10 -0700
Message-Id: <1560705250-211820-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVX512 Vector Neural Network Instructions (VNNI) in Intel Deep Learning
Boost support BFLOAT16 format (BF16). BF16 is a short version of FP32 and
has several advantages over FP16. BF16 offers more than enough range for
deep learning training tasks and doesn't need to handle hardware exception
as this is a performance optimization. FP32 accumulation after the
multiply is essential to achieve sufficient numerical behavior on an
application level.

AVX512 BFLOAT16 instructions can be enumerated by:
	CPUID.7.1:EAX[bit 5] AVX512_BF16

Use word 12, which is empty now, to hold features in CPUID.7.1:EAX
including AVX512_BF16. Leaf CPUID_DUMMY is renamed as CPUID_7_1_EAX.

Detailed information of the CPUID bit and AVX512 BFLOAT16 instructions
can be found in the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeature.h  | 2 +-
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 3 +++
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 403f70c2e431..58acda503817 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -23,7 +23,7 @@ enum cpuid_leafs
 	CPUID_7_0_EBX,
 	CPUID_D_1_EAX,
 	CPUID_LNX_4,
-	CPUID_DUMMY,
+	CPUID_7_1_EAX,
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4f0a3d093794..625191ceb214 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -280,6 +280,9 @@
 #define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5b0e9d869ce5..6a4e948c7580 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -823,6 +823,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 		c->x86_capability[CPUID_7_ECX] = ecx;
 		c->x86_capability[CPUID_7_EDX] = edx;
+
+		cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
+		c->x86_capability[CPUID_7_1_EAX] = eax;
 	}
 
 	/* Extended state features: level 0x0000000d */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index fa07a224e7b9..a444028d8145 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -62,6 +62,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_AVX512_BF16,	X86_FEATURE_AVX512VL  },
 	{}
 };
 
-- 
2.19.1

