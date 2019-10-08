Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943DDCFE23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfJHPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:52:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:21591 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfJHPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 08:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277135045"
Received: from otc-lr-04.jf.intel.com ([10.54.39.120])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 08:52:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 9/9] perf/x86/cstate: Add Tiger Lake CPU support
Date:   Tue,  8 Oct 2019 08:50:10 -0700
Message-Id: <1570549810-25049-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Tiger Lake is the followon to Ice Lake. From the perspective of Intel
cstate residency counters, there is nothing changed compared with
Ice Lake.

Share icl_cstates with Ice Lake.
Update the comments for Tiger Lake.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4d232ac..e1daf41 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -50,44 +50,44 @@
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL
+ *						ICL,TGL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL
+ *						KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL
+ *						GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL
+ *						KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *
  */
@@ -645,6 +645,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE_L, icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE, icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.7.4

