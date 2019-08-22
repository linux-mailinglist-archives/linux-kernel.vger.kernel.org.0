Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36B1990C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfHVK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 06:27:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbfHVK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+KVo9b/gOk1LBU7244GFTBaPtvzylIhE/BDvTqRCOFQ=; b=Ni6e9A8DuFqRXJAnwUgPduWavv
        9UCVq8CwMI5TJ2XIq8Rzl91IwM3iXG07h7kYsp2ccTRQE0B6KgW/7qDQLfA38FTO8Tc+J4A32JMZs
        Bb8ryjHydobzaAAfB0ct/Ck6okp1gAcXG8ftxGP5jkgguzmAc9pl1g9Wdlk4O3bacIb8TOvgnbr4X
        398oKh2A2TpEYpN0Wd+EuLfbVY/CCLcF2RgXOQRaBFGkopYKp1SMM93mkL2V9RJr8/jbFTIxE+V06
        oIUZoKrphw9NwuPGoGf4LfqCiAc7GetHgXWpLRklNSjXNMxVBHdEQdkNRL9xQViHk7ttzYsE1C9tQ
        +HjIeJUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kIu-0008DL-NM; Thu, 22 Aug 2019 10:26:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6935A307691;
        Thu, 22 Aug 2019 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C4032029B082; Thu, 22 Aug 2019 12:26:50 +0200 (CEST)
Message-Id: <20190822102411.168563665@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 22 Aug 2019 12:23:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/5] x86/intel: Aggregate big core client naming
References: <20190822102306.109718810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the big core client models either have:

 - no OPTDIFF
 - _CORE
 - _DESKTOP

Make it uniformly: 'no OPTDIFF'.

for i in `git grep -l "INTEL_FAM6_.*_\(CORE\|DESKTOP\)"`
do
	sed -i -e 's/\(INTEL_FAM6_.*\)_\(CORE\|DESKTOP\)/\1/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c          | 26 +++++++++++++-------------
 arch/x86/events/intel/cstate.c        | 22 +++++++++++-----------
 arch/x86/events/intel/pt.c            |  2 +-
 arch/x86/events/intel/rapl.c          | 10 +++++-----
 arch/x86/events/intel/uncore.c        | 12 ++++++------
 arch/x86/events/msr.c                 |  8 ++++----
 arch/x86/include/asm/intel-family.h   | 10 +++++-----
 arch/x86/kernel/apic/apic.c           |  8 ++++----
 arch/x86/kernel/cpu/bugs.c            |  8 ++++----
 arch/x86/kernel/cpu/intel.c           | 10 +++++-----
 drivers/cpufreq/intel_pstate.c        | 12 ++++++------
 drivers/idle/intel_idle.c             |  2 +-
 tools/power/x86/turbostat/turbostat.c | 28 ++++++++++++++--------------
 13 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..76bff3a33725 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3964,12 +3964,12 @@ static __init void intel_clovertown_quirk(void)
 }
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_CORE,		 3, 0x0000001f),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
@@ -3979,16 +3979,16 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		13, 0x0000004e),
 	{}
 };
 
@@ -4857,7 +4857,7 @@ __init int intel_pmu_init(void)
 		break;
 
 
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
@@ -4890,7 +4890,7 @@ __init int intel_pmu_init(void)
 		name = "haswell";
 		break;
 
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
@@ -4956,9 +4956,9 @@ __init int intel_pmu_init(void)
 		pmem = true;
 		/* fall through */
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -5006,7 +5006,7 @@ __init int intel_pmu_init(void)
 		pmem = true;
 		/* fall through */
 	case INTEL_FAM6_ICELAKE_MOBILE:
-	case INTEL_FAM6_ICELAKE_DESKTOP:
+	case INTEL_FAM6_ICELAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b34564..3854400ad8ff 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,40 +593,40 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_CORE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,      snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_ULT, hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT, slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,     slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,      slm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_CORE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE,  snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_DESKTOP, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,        snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,        hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,        snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d3dc2274ddd4..8cb9626e6277 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -204,7 +204,7 @@ static int __init pt_pmu_hw_init(void)
 
 	/* model-specific quirks */
 	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 64ab51ffdf06..c1278e2764f4 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -720,27 +720,27 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,		model_snbep),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,		model_snb),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
 	{},
 };
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3694a5d0703d..d5e091586242 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1451,10 +1451,10 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EP,	  nhm_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,	  snb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE, bdw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
@@ -1465,14 +1465,14 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9431447541e9..08d320a39dff 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -59,12 +59,12 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE_X:
 
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
 
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
@@ -85,10 +85,10 @@ static bool test_intel(int idx, void *data)
 		break;
 
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 	case INTEL_FAM6_ICELAKE_MOBILE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index fe7c205233f1..800dd17e61c4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -49,27 +49,27 @@
 #define INTEL_FAM6_IVYBRIDGE		0x3A
 #define INTEL_FAM6_IVYBRIDGE_X		0x3E
 
-#define INTEL_FAM6_HASWELL_CORE		0x3C
+#define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
 #define INTEL_FAM6_HASWELL_ULT		0x45
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
-#define INTEL_FAM6_BROADWELL_CORE	0x3D
+#define INTEL_FAM6_BROADWELL		0x3D
 #define INTEL_FAM6_BROADWELL_GT3E	0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
 #define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
-#define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
+#define INTEL_FAM6_SKYLAKE		0x5E
 #define INTEL_FAM6_SKYLAKE_X		0x55
 #define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
-#define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
+#define INTEL_FAM6_KABYLAKE		0x9E
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
-#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
+#define INTEL_FAM6_ICELAKE		0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84104dfc4cf6..e0bc8a27a166 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -593,18 +593,18 @@ static const struct x86_cpu_id deadline_match[] = {
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_XEON_D,	bdx_deadline_rev),
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_CORE,	0x22),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_ULT,	0x20),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_CORE,	0x25),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_MOBILE,	0xb2),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_DESKTOP,	0xb2),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_MOBILE,	0x52),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_DESKTOP,	0x52),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
 
 	{},
 };
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 79d9d6da5d62..21d8f58bec31 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1184,15 +1184,15 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
 		break;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 66de4b84c369..92287fff158e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -142,21 +142,21 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
 	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
-	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cc27d4c59dca..17cb9af25328 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1867,12 +1867,12 @@ static const struct pstate_funcs knl_funcs = {
 			(unsigned long)&policy }
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_funcs),
+	ICPU(INTEL_FAM6_SANDYBRIDGE,		core_funcs),
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	silvermont_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_CORE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_ULT,		core_funcs),
@@ -1881,7 +1881,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
@@ -1900,13 +1900,13 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_funcs),
+	ICPU(INTEL_FAM6_KABYLAKE, core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE, core_funcs),
 	{}
 };
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa5ff77b8fe4..ac584872b638 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1311,7 +1311,7 @@ static void intel_idle_state_table_update(void)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 		sklh_idle_state_table_update();
 		break;
 	}
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..8083a354ae7f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3207,10 +3207,10 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = snb_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -3403,10 +3403,10 @@ int has_config_tdp(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -3840,9 +3840,9 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	switch (model) {
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		if (rapl_joules) {
@@ -4031,7 +4031,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 		return;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4249,10 +4249,10 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SANDYBRIDGE_X:
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -4284,8 +4284,8 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_HASWELL:
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
@@ -4569,16 +4569,16 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_XEON_PHI_KNL;
 
 	case INTEL_FAM6_HASWELL_ULT:
-		return INTEL_FAM6_HASWELL_CORE;
+		return INTEL_FAM6_HASWELL;
 
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:


