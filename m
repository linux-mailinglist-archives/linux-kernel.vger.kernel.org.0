Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B808322B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfETFiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 01:38:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:24172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbfETFiE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:03 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:38:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/9] perf util: Add block_info in hist_entry
Date:   Mon, 20 May 2019 21:27:49 +0800
Message-Id: <1558358876-32211-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block_info contains the program basic block information, i.e,
contains the start address and the end address of this basic block and
how much cycles it takes. We need to compare, sort and even print out
the basic block by some orders, i.e. sort by cycles.

For this purpose, we add block_info field to hist_entry. In order not to
impact current interface, we creates a new function hists__add_entry_block.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/hist.c | 22 ++++++++++++++++++++--
 tools/perf/util/hist.h |  6 ++++++
 tools/perf/util/sort.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ace7a10..3810460 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -574,6 +574,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 */
 			mem_info__zput(entry->mem_info);
 
+			block_info__zput(entry->block_info);
+
 			/* If the map of an existing hist_entry has
 			 * become out-of-date due to an exec() or
 			 * similar, update it.  Otherwise we will
@@ -645,6 +647,7 @@ __hists__add_entry(struct hists *hists,
 		   struct symbol *sym_parent,
 		   struct branch_info *bi,
 		   struct mem_info *mi,
+		   struct block_info *block_info,
 		   struct perf_sample *sample,
 		   bool sample_self,
 		   struct hist_entry_ops *ops)
@@ -677,6 +680,7 @@ __hists__add_entry(struct hists *hists,
 		.hists	= hists,
 		.branch_info = bi,
 		.mem_info = mi,
+		.block_info = block_info,
 		.transaction = sample->transaction,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
@@ -699,7 +703,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct perf_sample *sample,
 				    bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, NULL);
 }
 
@@ -712,10 +716,24 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, ops);
 }
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct hist_entry_ops *ops,
+					  struct addr_location *al,
+					  struct block_info *block_info)
+{
+	struct hist_entry entry = {
+		.ops = ops,
+		.block_info = block_info,
+		.hists = hists,
+	}, *he = hists__findnew_entry(hists, &entry, al, false);
+
+	return he;
+}
+
 static int
 iter_next_nop_entry(struct hist_entry_iter *iter __maybe_unused,
 		    struct addr_location *al __maybe_unused)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 76ff6c6..c8f7d66 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -16,6 +16,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct block_info;
 struct symbol;
 
 enum hist_filter {
@@ -149,6 +150,11 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self);
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct hist_entry_ops *ops,
+					  struct addr_location *al,
+					  struct block_info *bi);
+
 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 			 int max_stack_depth, void *arg);
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ce376a7..43623fa 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -144,6 +144,7 @@ struct hist_entry {
 	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
+	struct block_info	*block_info;
 	void			*raw_data;
 	u32			raw_size;
 	int			num_res;
-- 
2.7.4

