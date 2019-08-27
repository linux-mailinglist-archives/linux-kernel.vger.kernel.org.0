Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE29F388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfH0TwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:52:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfH0TwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dAeakmQyX1bGCs1qJCrJgucsCr6LXXt6h72f8vb7iYE=; b=Pa+cFyXXu7qGtQBF4A2TKwfVyB
        8CFYxOewych6RrLN4uV1g78VLs8UULKHHvc2kqV3wdSmi9L8yMttAuPkAKHMzS6h77Lr+LuP0Sv9q
        DwjIEB2NHaI8KUBZfjHYe32cTyJrDuHgsykA3xpK+OMeTQbkVm76HB1bea3Lk6aN0tHIWi2nKUyh6
        /R7vsedSKJR3GtXA9iiSwAr/e0nFkWqdtFqfN6QqLRgX+kTZBVutrr+fMAmlj5k6UT9pe0OCNscc4
        aSyDPvpM5hhdjGgRRyoggrO8g3qsG3tWN3D5QKNm1+WgizGBkilFE7+NoSpJnftNk3eeCJr2AeA/R
        wjWcWCLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2hVR-0005Sc-Gm; Tue, 27 Aug 2019 19:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C2CA30775B;
        Tue, 27 Aug 2019 21:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC1AB203C0567; Tue, 27 Aug 2019 21:51:50 +0200 (CEST)
Message-Id: <20190827195122.622802314@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 21:48:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2 3/5] x86/intel: Aggregate big core graphics naming
References: <20190827194820.378516765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently big core clients with extra graphics on have:

 - _G
 - _GT3E

Make it uniformly: _G

for i in `git grep -l "\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*_GT3E"`
do
	sed -i -e 's/\(\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*\)_GT3E/\1_G/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c          |    8 ++++----
 arch/x86/events/intel/cstate.c        |    8 ++++----
 arch/x86/events/intel/pt.c            |    2 +-
 arch/x86/events/intel/rapl.c          |    4 ++--
 arch/x86/events/intel/uncore.c        |    4 ++--
 arch/x86/events/msr.c                 |    4 ++--
 arch/x86/include/asm/intel-family.h   |    4 ++--
 arch/x86/kernel/apic/apic.c           |    4 ++--
 arch/x86/kernel/cpu/bugs.c            |    4 ++--
 arch/x86/kernel/cpu/intel.c           |    4 ++--
 drivers/cpufreq/intel_pstate.c        |    4 ++--
 drivers/idle/intel_idle.c             |    4 ++--
 drivers/powercap/intel_rapl_common.c  |    4 ++--
 tools/power/x86/turbostat/turbostat.c |   18 +++++++++---------
 14 files changed, 38 insertions(+), 38 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3966,11 +3966,11 @@ static __init void intel_clovertown_quir
 static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_G,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
@@ -4860,7 +4860,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -4892,7 +4892,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,9 +593,9 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,      snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_G, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
@@ -605,7 +605,7 @@ static const struct x86_cpu_id intel_cst
 
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G,      snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -206,7 +206,7 @@ static int __init pt_pmu_hw_init(void)
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
 		pt_pmu.branch_en_always_on = true;
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -723,9 +723,9 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1453,9 +1453,9 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_G,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EX,	  nhmex_uncore_init),
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -62,11 +62,11 @@ static bool test_intel(int idx, void *da
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,10 +52,10 @@
 #define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
 #define INTEL_FAM6_HASWELL_L		0x45
-#define INTEL_FAM6_HASWELL_GT3E		0x46
+#define INTEL_FAM6_HASWELL_G		0x46
 
 #define INTEL_FAM6_BROADWELL		0x3D
-#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_G		0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -595,10 +595,10 @@ static const struct x86_cpu_id deadline_
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1186,9 +1186,9 @@ static void override_cache_bits(struct c
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -150,12 +150,12 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
-	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_G,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
-	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_G,		0x01,	0x18 },
 	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1876,8 +1876,8 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_G,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_G,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1075,10 +1075,10 @@ static const struct x86_cpu_id intel_idl
 	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
 	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
 	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -959,11 +959,11 @@ static const struct x86_cpu_id rapl_ids[
 
 	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_GT3E, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL_G, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
 
 	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_GT3E, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL_G, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
 
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3209,9 +3209,9 @@ int probe_nhm_msrs(unsigned int family,
 		break;
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
@@ -3405,9 +3405,9 @@ int has_config_tdp(unsigned int family,
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
@@ -3841,9 +3841,9 @@ void rapl_probe_intel(unsigned int famil
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4032,7 +4032,7 @@ void perf_limit_reasons_probe(unsigned i
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 		do_core_perf_limit_reasons = 1;
@@ -4251,9 +4251,9 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */


