Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF56B818
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfGQIVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 04:21:48 -0400
Received: from mail5.windriver.com ([192.103.53.11]:54000 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfGQIVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:21:48 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x6H8JWvY014382
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 17 Jul 2019 01:19:43 -0700
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.112) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.468.0; Wed, 17 Jul 2019 01:19:21 -0700
From:   Jiwei Sun <jiwei.sun@windriver.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <arnaldo.melo@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] perf record: Add support for limit perf output file size
Date:   Wed, 17 Jul 2019 16:19:18 +0800
Message-ID: <20190717081918.8235-1-jiwei.sun@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a new option to limit the output file size, then based
on it, we can create a wrapper of the perf command that uses the option
to avoid exhausting the disk space by the unconscious user.

In order to make the perf.data parsable, we just limit the sample data
size, since the perf.data consists of many headers and sample data and
other data, the actual size of the recorded file will bigger than the
setting value.

Testing it:

 # ./perf record -a -g --max-size=10M
Couldn't synthesize bpf events.
WARNING: The perf data has already reached the limit, stop recording!
[ perf record: Woken up 30 times to write data ]
[ perf record: Captured and wrote 10.233 MB perf.data (175650 samples) ]
Terminated

 # ls -lh perf.data
-rw------- 1 root root 11M Jul 17 14:01 perf.data

 # ./perf record -a -g --max-size=10K
WARNING: The perf data has already reached the limit, stop recording!
Couldn't synthesize bpf events.
[ perf record: Woken up 0 times to write data ]
[ perf record: Captured and wrote 1.824 MB perf.data (67 samples) ]
Terminated

 # ls -lh perf.data
-rw------- 1 root root 1.9M Jul 17 14:05 perf.data

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
v4 changes:
  - Just show one WARNING message after reached the limit.

v3 changes:
  - add a test result
  - add the new option to tools/perf/Documentation/perf-record.txt

v2 changes:
  - make patch based on latest Arnaldo's perf/core,
  - display warning message when reached the limit.
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              | 42 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 15e0fa87241b..918a0844cbcf 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -564,6 +564,10 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--max-size=<size>::
+Limit the sample data max size, <size> is expected to be a number with
+appended unit character - B/K/M/G
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8779cee58185..8c49dce3abd8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -86,6 +86,7 @@ struct record {
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	cpu_set_t		affinity_mask;
+	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -115,6 +116,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static bool record__output_max_size_exceeded(struct record *rec)
+{
+	return (rec->output_max_size &&
+	       rec->bytes_written >= rec->output_max_size);
+}
+
 static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
 			 void *bf, size_t size)
 {
@@ -127,6 +134,12 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 
 	rec->bytes_written += size;
 
+	if (record__output_max_size_exceeded(rec)) {
+		WARN_ONCE(1, "WARNING: The perf data has already reached "
+			     "the limit, stop recording!\n");
+		raise(SIGTERM);
+	}
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
@@ -1902,6 +1915,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int parse_output_max_size(const struct option *opt,
+				 const char *str, int unset)
+{
+	unsigned long *s = (unsigned long *)opt->value;
+	static struct parse_tag tags_size[] = {
+		{ .tag  = 'B', .mult = 1       },
+		{ .tag  = 'K', .mult = 1 << 10 },
+		{ .tag  = 'M', .mult = 1 << 20 },
+		{ .tag  = 'G', .mult = 1 << 30 },
+		{ .tag  = 0 },
+	};
+	unsigned long val;
+
+	if (unset) {
+		*s = 0;
+		return 0;
+	}
+
+	val = parse_tag_value(str, tags_size);
+	if (val != (unsigned long) -1) {
+		*s = val;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -2228,6 +2268,8 @@ static struct option __record_options[] = {
 			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
 			    record__parse_comp_level),
 #endif
+	OPT_CALLBACK(0, "max-size", &record.output_max_size,
+		     "size", "Limit the maximum size of the output file", parse_output_max_size),
 	OPT_END()
 };
 
-- 
2.20.1

