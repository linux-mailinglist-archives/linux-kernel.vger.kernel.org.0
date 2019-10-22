Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682A9E0A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfJVRMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 13:12:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:35603 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733107AbfJVRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:12:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 10:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; 
   d="scan'208";a="191538316"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2019 10:12:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 12/13] perf c2c: Add option to enable the LBR stitching approach
Date:   Tue, 22 Oct 2019 10:11:35 -0700
Message-Id: <20191022171136.4022-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022171136.4022-1-kan.liang@linux.intel.com>
References: <20191022171136.4022-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the LBR stitching approach, the reconstructed LBR call stack
can break the HW limitation. However, it may reconstruct invalid call
stacks in some cases, e.g. exception handing such as setjmp/longjmp.
Also, it may impact the processing time especially when the number of
samples with stitched LBRs are huge.

Add an option to enable the approach.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-c2c.txt | 11 +++++++++++
 tools/perf/builtin-c2c.c              |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e6150f21267d..2133eb320cb0 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -111,6 +111,17 @@ REPORT OPTIONS
 --display::
 	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf c2c record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 C2C RECORD
 ----------
 The perf c2c record command setup options related to HITM cacheline analysis
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3542b6ab9813..c3658986c38a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -95,6 +95,7 @@ struct perf_c2c {
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
+	bool			 stitch_lbr;
 
 	/* HITM shared clines stats */
 	struct c2c_stats	hitm_stats;
@@ -273,6 +274,9 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
+	if (c2c.stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	ret = sample__resolve_callchain(sample, &callchain_cursor, NULL,
 					evsel, &al, sysctl_perf_event_max_stack);
 	if (ret)
@@ -2746,6 +2750,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_STRING('c', "coalesce", &coalesce, "coalesce fields",
 		   "coalesce fields: pid,tid,iaddr,dso"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
+	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
-- 
2.17.1

