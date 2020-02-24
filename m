Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2B16B378
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 23:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBXWAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 17:00:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:22327 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgBXWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:00:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284477384"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 14:00:41 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/5] perf vendor events: Add NO_NMI_WATCHDOG metric constraint
Date:   Mon, 24 Feb 2020 13:59:24 -0800
Message-Id: <1582581564-184429-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add NO_NMI_WATCHDOG metric constraint to Page_Walks_Utilization for
Sky Lake and Cascade Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 3 ++-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json      | 3 ++-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json     | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index f946532..a728c6e 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index e7feb60..f97e831 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 21d7a0c..35f5db1 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -215,7 +215,8 @@
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
-        "MetricName": "Page_Walks_Utilization"
+        "MetricName": "Page_Walks_Utilization",
+        "MetricConstraint": "NO_NMI_WATCHDOG"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-- 
2.7.4

