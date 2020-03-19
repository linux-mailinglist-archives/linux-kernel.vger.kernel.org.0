Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456E618C15D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCSU3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:29:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:60498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCSU3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:29:01 -0400
IronPort-SDR: CmgGA6PanJlLLyh7bH53kMhywTRZqtd8QYSN30TZl7IeDf80LvcRPmMe+zNKaifKprXhyP57c1
 BVY/F2CCEEIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:29:00 -0700
IronPort-SDR: ChhXGqNlgZ7/U4to3pIZXJjrEeUfCeu+dr7yefqnHgJ0Cte+EACoBuhwPGuVb/OnFfObKb3fHN
 ASgWOmaCCqJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031266"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:29:00 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 13/17] perf report: Add option to enable the LBR stitching approach
Date:   Thu, 19 Mar 2020 13:25:13 -0700
Message-Id: <20200319202517.23423-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
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

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6492797701
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # .................................
  #
    99.99%    99.99%  tchain_edit      tchain_edit        [.] f43
            |
            ---main
               f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               |
                --99.65%--f32
                          f33
                          f34
                          f35
                          f36
                          f37
                          f38
                          f39
                          f40
                          f41
                          f42
                          f43

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 11 +++++++++++
 tools/perf/builtin-report.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index e56e3f1344a7..cfeab01054e4 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -487,6 +487,17 @@ include::itrace.txt[]
 	This option extends the perf report to show reference callgraphs,
 	which collected by reference event, in no callgraph event.
 
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
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ea673b7eb3f4..f44fc45c32dd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -84,6 +84,7 @@ struct report {
 	bool			header_only;
 	bool			nonany_branch_mode;
 	bool			group_set;
+	bool			stitch_lbr;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -267,6 +268,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (rep->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
@@ -407,6 +411,12 @@ static int report__setup_sample_type(struct report *rep)
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
 
+	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		rep->stitch_lbr = false;
+	}
+
 	/* ??? handle more cases than just ANY? */
 	if (!(perf_evlist__combined_branch_type(session->evlist) &
 				PERF_SAMPLE_BRANCH_ANY))
@@ -1256,6 +1266,8 @@ int cmd_report(int argc, const char **argv)
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
 		    "Show callgraph from reference event"),
+	OPT_BOOLEAN(0, "stitch-lbr", &report.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_INTEGER(0, "socket-filter", &report.socket_filter,
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
-- 
2.17.1

