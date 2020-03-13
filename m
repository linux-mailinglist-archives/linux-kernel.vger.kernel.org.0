Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA26C184153
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 08:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCMHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 03:12:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:7824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCMHMO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:12:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 00:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; 
   d="scan'208";a="266642289"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 00:12:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 09/14] perf util: Add new block info fmts for showing hot blocks comparison
Date:   Fri, 13 Mar 2020 15:11:13 +0800
Message-Id: <20200313071118.11983-10-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313071118.11983-1-yao.jin@linux.intel.com>
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support three new columns in output

New Stream Diff(cycles%,cycles):
  The diff of 'Sampled Cycles%' and 'Avg Cycles' between new stream
  and old stream for the same block.

  If block is not matched, it reports "[block not in new stream]" or
  "[block changed in new stream]".

New Stream Sampled Cycles%:
  The 'Sampled Cycles%' of the block in new stream. It's only reported
  when the block is changed in new stream.

New Stream Avg Cycles:
  The 'Average Cycles' of the block in new stream. It's only reported
  when the block is changed in new stream.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 117 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/block-info.h |   4 ++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 431cd97bae39..96b7b81cabd5 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -41,7 +41,19 @@ static struct block_header_column {
 	[PERF_HPP_REPORT__BLOCK_DSO] = {
 		.name = "Shared Object",
 		.width = 20,
-	}
+	},
+	[PERF_HPP__BLOCK_NEW_STREAM_DIFF] = {
+		.name = "New Stream Diff(cycles%,cycles)",
+		.width = 31,
+	},
+	[PERF_HPP__BLOCK_NEW_STREAM_TOTAL_CYCLES_PCT] = {
+		.name = "New Stream Sampled Cycles%",
+		.width = 26,
+	},
+	[PERF_HPP__BLOCK_NEW_STREAM_AVG_CYCLES] = {
+		.name = "New Stream Avg Cycles",
+		.width = 21,
+	},
 };
 
 struct block_info *block_info__get(struct block_info *bi)
@@ -342,6 +354,100 @@ static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			 "[unknown]");
 }
 
+static int block_new_stream_diff_entry(struct perf_hpp_fmt *fmt,
+				       struct perf_hpp *hpp,
+				       struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct hist_entry *pair = hist_entry__next_pair(he);
+	struct block_info *bi_h, *bi_p;
+	double ratio_h = 0.0, ratio_p = 0.0;
+	s64 cycles_diff;
+	char buf[32];
+
+	if (!pair) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "[block not in new stream]");
+	}
+
+	bi_h = he->block_info;
+	bi_p = pair->block_info;
+
+	if (bi_p->block_changed) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "[block changed in new stream]");
+	}
+
+	if (bi_h->total_cycles)
+		ratio_h = (double)bi_h->cycles / (double)bi_h->total_cycles;
+
+	if (bi_p->total_cycles)
+		ratio_p = (double)bi_p->cycles / (double)bi_p->total_cycles;
+
+	cycles_diff = (s64)(bi_p->cycles_aggr / bi_p->num_aggr) -
+		(s64)(bi_h->cycles_aggr / bi_h->num_aggr);
+
+	snprintf(buf, sizeof(buf), "%4.2f%%, %4ld",
+		 100.0 * (ratio_p - ratio_h), cycles_diff);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+}
+
+static int block_new_stream_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
+						   struct perf_hpp *hpp,
+						   struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct hist_entry *pair = hist_entry__next_pair(he);
+	struct block_info *bi_p;
+	double ratio = 0.0;
+
+	if (!pair) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "-");
+	}
+
+	bi_p = pair->block_info;
+
+	if (!bi_p->block_changed) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "-");
+	}
+
+	if (bi_p->total_cycles)
+		ratio = (double)bi_p->cycles / (double)bi_p->total_cycles;
+
+	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
+}
+
+static int block_new_stream_avg_cycles_entry(struct perf_hpp_fmt *fmt,
+					     struct perf_hpp *hpp,
+					     struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct hist_entry *pair = hist_entry__next_pair(he);
+	struct block_info *bi_p;
+	char cycles_buf[16];
+
+	if (!pair) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "-");
+	}
+
+	bi_p = pair->block_info;
+
+	if (!bi_p->block_changed) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 "-");
+	}
+
+	cycles_string(bi_p->cycles_aggr / bi_p->num_aggr, cycles_buf,
+		      sizeof(cycles_buf));
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+			 cycles_buf);
+}
+
 static void init_block_header(struct block_fmt *block_fmt)
 {
 	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
@@ -385,6 +491,15 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 	case PERF_HPP_REPORT__BLOCK_DSO:
 		fmt->entry = block_dso_entry;
 		break;
+	case PERF_HPP__BLOCK_NEW_STREAM_DIFF:
+		fmt->entry = block_new_stream_diff_entry;
+		break;
+	case PERF_HPP__BLOCK_NEW_STREAM_TOTAL_CYCLES_PCT:
+		fmt->entry = block_new_stream_total_cycles_pct_entry;
+		break;
+	case PERF_HPP__BLOCK_NEW_STREAM_AVG_CYCLES:
+		fmt->entry = block_new_stream_avg_cycles_entry;
+		break;
 	default:
 		return;
 	}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index 458bd998089d..4e22bce81731 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -22,6 +22,7 @@ struct block_info {
 	refcount_t		refcnt;
 	struct block_line	*line;
 	bool			srcline_matched;
+	bool			block_changed;
 };
 
 struct block_fmt {
@@ -40,6 +41,9 @@ enum {
 	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
 	PERF_HPP_REPORT__BLOCK_RANGE,
 	PERF_HPP_REPORT__BLOCK_DSO,
+	PERF_HPP__BLOCK_NEW_STREAM_DIFF,
+	PERF_HPP__BLOCK_NEW_STREAM_TOTAL_CYCLES_PCT,
+	PERF_HPP__BLOCK_NEW_STREAM_AVG_CYCLES,
 	PERF_HPP_REPORT__BLOCK_MAX_INDEX
 };
 
-- 
2.17.1

