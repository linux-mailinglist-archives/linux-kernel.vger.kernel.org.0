Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9329F38D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfH0TwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:52:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbfH0TwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WMK0fXa4PAS18OoGE3aGmQbaj9QCItuyWMq4pjei1/Y=; b=pU3cNYbHKSJfFn7MtzZfzFoiGf
        VOx6HBPaqIISAdusQE33H8TbRmajGPUHIw+b2M5aLOII6k8+Q+2NP6WmVHr72hM3jU5zzhOLVLqzy
        o9Y56x16L67BT0YtNVhQQZ81PD5liNBqDrVVPp1pSDacVWaxf4Sht8gCs4U0Om5tJHkbG06UVDFAc
        ZrMxw4LzrK1aLuLjRP15/Ub5/3bZLa92i4s1ZwaNf0H0KGta9R/6bCVTobHUkM/v3DLsQ7r+Nz1Mj
        ZyO+/ZNz6b0s+p95giClC5YywPx2qxICHI1xsBuiXWpPBz/bkze+DUO9j0rylEKLGERjI1vU8kAgB
        U4YYh2QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2hVR-0005Sd-HF; Tue, 27 Aug 2019 19:51:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E488307765;
        Tue, 27 Aug 2019 21:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E5ADB201881DF; Tue, 27 Aug 2019 21:51:50 +0200 (CEST)
Message-Id: <20190827195122.568978530@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 21:48:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2 2/5] x86/intel: Aggregate big core mobile naming
References: <20190827194820.378516765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently big core mobile chips have either:

 - _L
 - _ULT
 - _MOBILE

Make it uniformly: _L.

for i in `git grep -l "\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*_\(MOBILE\|ULT\)"`
do
	sed -i -e 's/\(\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*\)_\(MOBILE\|ULT\)/\1_L/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c                 |   20 ++++++-------
 arch/x86/events/intel/cstate.c               |   18 ++++++------
 arch/x86/events/intel/rapl.c                 |   10 +++---
 arch/x86/events/intel/uncore.c               |    8 ++---
 arch/x86/events/msr.c                        |    8 ++---
 arch/x86/include/asm/intel-family.h          |   10 +++---
 arch/x86/kernel/apic/apic.c                  |    6 ++--
 arch/x86/kernel/cpu/bugs.c                   |    6 ++--
 arch/x86/kernel/cpu/intel.c                  |    6 ++--
 drivers/acpi/x86/utils.c                     |    4 +-
 drivers/cpufreq/intel_pstate.c               |    4 +-
 drivers/idle/intel_idle.c                    |    6 ++--
 drivers/platform/x86/intel_pmc_core.c        |    8 ++---
 drivers/platform/x86/intel_pmc_core_pltdrv.c |    8 ++---
 drivers/powercap/intel_rapl_common.c         |   10 +++---
 tools/power/x86/turbostat/turbostat.c        |   40 +++++++++++++--------------
 16 files changed, 86 insertions(+), 86 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3965,7 +3965,7 @@ static __init void intel_clovertown_quir
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
@@ -3978,13 +3978,13 @@ static const struct x86_cpu_desc isolati
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		12, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
@@ -4859,7 +4859,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
@@ -4955,9 +4955,9 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -5005,7 +5005,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_XEON_D:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -597,7 +597,7 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_ULT, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
@@ -608,14 +608,14 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,        snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,      snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,        hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
@@ -625,8 +625,8 @@ static const struct x86_cpu_id intel_cst
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,        snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -722,7 +722,7 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
@@ -730,16 +730,16 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
 	{},
 };
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1452,7 +1452,7 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,	  snb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
@@ -1466,11 +1466,11 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -61,7 +61,7 @@ static bool test_intel(int idx, void *da
 
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 
 	case INTEL_FAM6_BROADWELL:
@@ -84,12 +84,12 @@ static bool test_intel(int idx, void *da
 			return true;
 		break;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -51,7 +51,7 @@
 
 #define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
-#define INTEL_FAM6_HASWELL_ULT		0x45
+#define INTEL_FAM6_HASWELL_L		0x45
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
 #define INTEL_FAM6_BROADWELL		0x3D
@@ -59,18 +59,18 @@
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
-#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_L		0x4E
 #define INTEL_FAM6_SKYLAKE		0x5E
 #define INTEL_FAM6_SKYLAKE_X		0x55
-#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_L		0x8E
 #define INTEL_FAM6_KABYLAKE		0x9E
 
-#define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
+#define INTEL_FAM6_CANNONLAKE_L		0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
 #define INTEL_FAM6_ICELAKE		0x7D
-#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_L		0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -594,16 +594,16 @@ static const struct x86_cpu_id deadline_
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_ULT,	0x20),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_MOBILE,	0xb2),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_MOBILE,	0x52),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_L,	0x52),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
 
 	{},
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1185,13 +1185,13 @@ static void override_cache_bits(struct c
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_GT3E:
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -145,8 +145,8 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_L,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_L,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
@@ -154,7 +154,7 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
-	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
 	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
 	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -69,11 +69,11 @@ static const struct always_present_id al
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1875,11 +1875,11 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_ULT,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1074,16 +1074,16 @@ static const struct x86_cpu_id intel_idl
 	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
 	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_ULT,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
 	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		idle_cpu_skl),
+	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		idle_cpu_skl),
+	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
 	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -806,12 +806,12 @@ static inline void pmc_core_dbgfs_unregi
 #endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_L, spt_reg_map),
 	INTEL_CPU_FAM6(SKYLAKE, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_L, spt_reg_map),
 	INTEL_CPU_FAM6(KABYLAKE, spt_reg_map),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
+	INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
+	INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
 	{}
 };
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -30,12 +30,12 @@ static struct platform_device pmc_core_d
  * other list may grow, but this list should not.
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(SKYLAKE_L, pmc_core_device),
 	INTEL_CPU_FAM6(SKYLAKE, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE_L, pmc_core_device),
 	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -958,7 +958,7 @@ static const struct x86_cpu_id rapl_ids[
 	INTEL_CPU_FAM6(IVYBRIDGE_X, rapl_defaults_core),
 
 	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_ULT, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_GT3E, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
 
@@ -968,12 +968,12 @@ static const struct x86_cpu_id rapl_ids[
 	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
 
 	INTEL_CPU_FAM6(SKYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, rapl_defaults_core),
+	INTEL_CPU_FAM6(SKYLAKE_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(SKYLAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, rapl_defaults_core),
+	INTEL_CPU_FAM6(KABYLAKE_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(KABYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, rapl_defaults_core),
+	INTEL_CPU_FAM6(CANNONLAKE_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3213,8 +3213,8 @@ int probe_nhm_msrs(unsigned int family,
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
@@ -3409,8 +3409,8 @@ int has_config_tdp(unsigned int family,
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
@@ -3863,8 +3863,8 @@ void rapl_probe_intel(unsigned int famil
 		else
 			BIC_PRESENT(BIC_PkgWatt);
 		break;
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4255,8 +4255,8 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
@@ -4286,8 +4286,8 @@ int has_hsw_msrs(unsigned int family, un
 	switch (model) {
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		return 1;
@@ -4309,8 +4309,8 @@ int has_skl_msrs(unsigned int family, un
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		return 1;
 	}
 	return 0;
@@ -4345,7 +4345,7 @@ int is_cnl(unsigned int family, unsigned
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_CANNONLAKE_MOBILE: /* CNL */
+	case INTEL_FAM6_CANNONLAKE_L: /* CNL */
 		return 1;
 	}
 
@@ -4568,21 +4568,21 @@ unsigned int intel_model_duplicates(unsi
 	case INTEL_FAM6_XEON_PHI_KNM:
 		return INTEL_FAM6_XEON_PHI_KNL;
 
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 		return INTEL_FAM6_HASWELL;
 
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
-		return INTEL_FAM6_SKYLAKE_MOBILE;
+		return INTEL_FAM6_SKYLAKE_L;
 
-	case INTEL_FAM6_ICELAKE_MOBILE:
-		return INTEL_FAM6_CANNONLAKE_MOBILE;
+	case INTEL_FAM6_ICELAKE_L:
+		return INTEL_FAM6_CANNONLAKE_L;
 	}
 	return model;
 }
@@ -4731,7 +4731,7 @@ void process_cpuid()
 
 			if (crystal_hz == 0)
 				switch(model) {
-				case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
+				case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */


