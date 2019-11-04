Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5227ED667
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 00:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfKCXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 18:30:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:59008 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbfKCXaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 18:30:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 15:30:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,265,1569308400"; 
   d="scan'208";a="204445722"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.25])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2019 15:30:23 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 03/14] perf/x86/intel: Move BTS index to 47
Date:   Sun,  3 Nov 2019 15:29:09 -0800
Message-Id: <20191103232920.20309-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191103232920.20309-1-kan.liang@linux.intel.com>
References: <20191103232920.20309-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The bit 48 in the PERF_GLOBAL_STATUS is used to indicate the overflow
status of PERF_METRICS counters now.

Move BTS index to 47.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 arch/x86/include/asm/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 55a4d05ba6ec..7df1d5b78aa8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -185,11 +185,11 @@ struct x86_pmu_capability {
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
- * We choose a value in the middle of the fixed event range, since lower
+ * We choose value 47 for the fixed index of BTS, since lower
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)
 
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
-- 
2.17.1

