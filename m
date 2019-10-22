Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C308E0A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfJVRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 13:12:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:35598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbfJVRML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:12:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 10:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; 
   d="scan'208";a="191538311"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2019 10:12:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 11/13] perf top: Add option to enable the LBR stitching approach
Date:   Tue, 22 Oct 2019 10:11:34 -0700
Message-Id: <20191022171136.4022-12-kan.liang@linux.intel.com>
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
The option must be used with --call-graph lbr.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt |  9 +++++++++
 tools/perf/builtin-top.c              | 11 +++++++++++
 tools/perf/util/top.h                 |  1 +
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..80b57f942a86 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -304,6 +304,15 @@ Default is to monitor all CPUS.
 	go straight to the histogram browser, just like 'perf top' with no events
 	explicitely specified does.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The option must be used with --call-graph lbr recording.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d96f24c8770d..93460abd27d5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -33,6 +33,7 @@
 #include "util/map.h"
 #include "util/mmap.h"
 #include "util/session.h"
+#include "util/thread.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/top.h"
@@ -765,6 +766,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	if (machine__resolve(machine, &al, sample) < 0)
 		return;
 
+	if (top->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (!machine->kptr_restrict_warned &&
 	    symbol_conf.kptr_restrict &&
 	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
@@ -1538,6 +1542,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "stitch-lbr", &top.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
@@ -1600,6 +1606,11 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
+		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
+		goto out_delete_evlist;
+	}
+
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index f117d4f4821e..45dc84ddff37 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -36,6 +36,7 @@ struct perf_top {
 	bool		   use_tui, use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
+	bool		   stitch_lbr;
 	struct hist_entry  *sym_filter_entry;
 	struct evsel 	   *sym_evsel;
 	struct perf_session *session;
-- 
2.17.1

