Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0315714B485
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgA1M43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 07:56:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:39253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgA1M41 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:56:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 04:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="309073692"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2020 04:56:25 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/4] perf util: Move block_pair_cmp to block-info
Date:   Tue, 28 Jan 2020 20:55:53 +0800
Message-Id: <20200128125556.25498-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128125556.25498-1-yao.jin@linux.intel.com>
References: <20200128125556.25498-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block_pair_cmp() is a function which is used to compare
two blocks. Moving it from builtin-diff.c to block-info.c
to let it can be used by other builtins.

 v4/v5:
 ------
 No change.

 v3:
 ---
 Separate it from original patch for good tracking.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    | 17 -----------------
 tools/perf/util/block-info.c | 17 +++++++++++++++++
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..5ff1e21082cb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
 	bh->valid = true;
 }
 
-static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
-{
-	struct block_info *bi_a = a->block_info;
-	struct block_info *bi_b = b->block_info;
-	int cmp;
-
-	if (!bi_a->sym || !bi_b->sym)
-		return -1;
-
-	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
-
-	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
-		return 0;
-
-	return -1;
-}
-
 static struct hist_entry *get_block_pair(struct hist_entry *he,
 					 struct hists *hists_pair)
 {
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030bf6ec2..f0f38bdd496a 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -475,3 +475,20 @@ float block_info__total_cycles_percent(struct hist_entry *he)
 
 	return 0.0;
 }
+
+int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
+{
+	struct block_info *bi_a = a->block_info;
+	struct block_info *bi_b = b->block_info;
+	int cmp;
+
+	if (!bi_a->sym || !bi_b->sym)
+		return -1;
+
+	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+
+	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+		return 0;
+
+	return -1;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bef0d75e9819..4fa91eeae92e 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -76,4 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
+int block_pair_cmp(struct hist_entry *a, struct hist_entry *b);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

