Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5BEF41C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 04:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfKEDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 22:37:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:50516 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbfKEDhU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:37:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 19:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,269,1569308400"; 
   d="scan'208";a="200239860"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 04 Nov 2019 19:37:17 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 1/7] perf diff: Don't use hack to skip column length calculation
Date:   Tue,  5 Nov 2019 11:36:05 +0800
Message-Id: <20191105033611.25493-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105033611.25493-1-yao.jin@linux.intel.com>
References: <20191105033611.25493-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we use a nasty hack to skip the hists__calc_col_len for
block since this function is not very suitable for block column
length calculation.

This patch removes the hack code and add a check at the entry of
hists__calc_col_len to skip for block case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 11 ++---------
 tools/perf/util/hist.c    |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5281629c27b1..faf99a81ad3e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -765,13 +765,6 @@ static void block_hists_match(struct hists *hists_base,
 	}
 }
 
-static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
-{
-	/* Skip the calculation of column length in output_resort */
-	he->filtered = true;
-	return 0;
-}
-
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -820,8 +813,8 @@ static void hists__precompute(struct hists *hists)
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
 							  &pair_bh->block_hists);
-					hists__output_resort_cb(&pair_bh->block_hists,
-								NULL, filter_cb);
+					hists__output_resort(&pair_bh->block_hists,
+							     NULL);
 				}
 				break;
 			default:
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..daa6eef4fde0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -80,6 +80,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	int symlen;
 	u16 len;
 
+	if (h->block_info)
+		return;
 	/*
 	 * +4 accounts for '[x] ' priv level info
 	 * +2 accounts for 0x prefix on raw addresses
-- 
2.17.1

