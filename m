Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FEE14BFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgA1Sbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:31:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:52516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgA1Sbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:31:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 10:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="217704583"
Received: from otc-lr-04.jf.intel.com ([10.54.39.26])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2020 10:31:40 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf/x86/cstate: Add Tremont support
Date:   Tue, 28 Jan 2020 10:31:18 -0800
Message-Id: <1580236279-35492-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580236279-35492-1-git-send-email-kan.liang@linux.intel.com>
References: <1580236279-35492-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Tremont is Intel's successor to Goldmont Plus. From the perspective of
Intel cstate residency counters, there is nothing changed compared with
Goldmont Plus and Goldmont.

Share glm_cstates with Goldmont Plus and Goldmont.
Update the comments for Tremont.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e1daf41..4814c96 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,17 +40,18 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL
+ *			 Available model: SLM,AMT,GLM,CNL,TNT
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
- *						CNL,KBL,CML
+ *						CNL,KBL,CML,TNT
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -60,17 +61,18 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL
+ *						KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
- *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -87,7 +89,8 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *
  */
@@ -640,8 +643,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
-
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT_D, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
-- 
2.7.4

