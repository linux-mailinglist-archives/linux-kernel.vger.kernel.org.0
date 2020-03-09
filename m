Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF317D7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 02:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCIBcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 21:32:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:58821 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCIBb7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:31:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 18:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="265092582"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2020 18:31:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in Kernel_Utilization metric
Date:   Mon,  9 Mar 2020 09:31:25 +0800
Message-Id: <20200309013125.7559-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel utilization metric does multiplexing currently and is somewhat
unreliable. The problem is that it uses two instances of the fixed counter,
and the kernel has to multipleplex which causes errors. So should use
CPU_CLK_UNHALTED.THREAD instead.

Before:

  # perf stat -M Kernel_Utilization -- sleep 1

  Performance counter stats for 'sleep 1':

          1,419,425      cpu_clk_unhalted.ref_tsc:k
      <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)

After:

  # perf stat -M Kernel_Utilization -- sleep 1

  Performance counter stats for 'sleep 1':

            746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
          1,088,348      cpu_clk_unhalted.thread

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 45a34ce4fe89..8cdc7c13dc2a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 961fe4395758..16fd8a7490fc 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -115,7 +115,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 746734ce09be..1eb0415fa11a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index f94653229dd4..a2c32db8f14e 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 5402cd3120f9..f57c5f3506c2 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 832f3cb40b34..311a005dc35b 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index d69b2a8fc0bc..28e25447d3ef 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 5f465fd81315..db23db2e98be 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 3e909b306003..dbb33e00b72a 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 50c053235752..fb2d7b8875f8 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index e7feb60f9fa9..e3afc3178958 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -303,7 +303,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 21d7a0c2c2e8..12d1efba79bb 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
-- 
2.17.1

