Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44F3FDE23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 13:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKOMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 07:43:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfKOMnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749673"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:30 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] perf record: Add support for AUX area sampling
Date:   Fri, 15 Nov 2019 14:42:16 +0200
Message-Id: <20191115124225.5247-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'perf record' option '--aux-sample' to request AUX area sampling. AUX
area sampling uses an overwriting buffer much like snapshot mode, so adjust
the AUX buffer mmapping accordingly. To make it easy to queue samples for
decoding, synthesize an ID index.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt |  6 ++++++
 tools/perf/builtin-record.c              | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ebcba1f95513..e216d7b529c9 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -433,6 +433,12 @@ can be specified in a string that follows this option:
 In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
 and on exit if the above 'e' option is given.
 
+--aux-sample[=OPTIONS]::
+Select AUX area sampling. At least one of the events selected by the -e option
+must be an AUX area event. Samples on other events will be created containing
+data from the AUX area. Optionally sample size may be specified, otherwise it
+defaults to 4KiB.
+
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b95c000c1ed9..d6383a557274 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -680,6 +680,11 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
+	err = auxtrace_parse_sample_options(rec->itr, rec->evlist, &rec->opts,
+					    rec->opts.auxtrace_sample_opts);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
@@ -752,6 +757,8 @@ static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
 	struct record_opts *opts = &rec->opts;
+	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
+				  opts->auxtrace_sample_mode;
 	char msg[512];
 
 	if (opts->affinity != PERF_AFFINITY_SYS)
@@ -759,7 +766,7 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode,
+				 auxtrace_overwrite,
 				 opts->nr_cblocks, opts->affinity,
 				 opts->mmap_flush, opts->comp_level) < 0) {
 		if (errno == EPERM) {
@@ -1046,6 +1053,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
+		    !rec->opts.auxtrace_sample_mode &&
 		    record__auxtrace_mmap_read(rec, map) != 0) {
 			rc = -1;
 			goto out;
@@ -1321,6 +1329,15 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err)
 		goto out;
 
+	/* Synthesize id_index before auxtrace_info */
+	if (rec->opts.auxtrace_sample_mode) {
+		err = perf_event__synthesize_id_index(tool,
+						      process_synthesized_event,
+						      session->evlist, machine);
+		if (err)
+			goto out;
+	}
+
 	if (rec->opts.full_auxtrace) {
 		err = perf_event__synthesize_auxtrace_info(rec->itr, tool,
 					session, process_synthesized_event);
@@ -2304,6 +2321,8 @@ static struct option __record_options[] = {
 	parse_clockid),
 	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
 			  "opts", "AUX area tracing Snapshot Mode", ""),
+	OPT_STRING_OPTARG(0, "aux-sample", &record.opts.auxtrace_sample_opts,
+			  "opts", "sample AUX area", ""),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
-- 
2.17.1

