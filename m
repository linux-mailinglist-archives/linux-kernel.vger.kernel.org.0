Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A89CEB59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfJGSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:00:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:33637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbfJGSAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:00:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 11:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161346"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 11:00:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/10] perf script: Add option to enable the LBR stitching approach
Date:   Mon,  7 Oct 2019 10:59:08 -0700
Message-Id: <20191007175910.2805-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
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
 tools/perf/Documentation/perf-script.txt | 11 +++++++++++
 tools/perf/builtin-script.c              |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..472f20f1e479 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -426,6 +426,17 @@ include::itrace.txt[]
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 67be8d31afab..0fc4d07864d1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1641,6 +1641,7 @@ struct perf_script {
 	bool			show_bpf_events;
 	bool			allocated;
 	bool			per_event_dump;
+	bool			stitch_lbr;
 	struct evswitch		evswitch;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
@@ -1867,6 +1868,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
+		if (script->stitch_lbr)
+			al->thread->lbr_stitch_enable = true;
+
 		if (symbol_conf.use_callchain && sample->callchain &&
 		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
@@ -3556,6 +3560,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
+	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
-- 
2.17.1

