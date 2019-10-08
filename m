Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0BCF332
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfJHHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 03:06:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:64439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbfJHHGW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:06:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 00:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="196522464"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2019 00:06:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 4/5] perf report: Support --percent-limit for total_cycles
Date:   Tue,  8 Oct 2019 15:05:01 +0800
Message-Id: <20191008070502.22551-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008070502.22551-1-yao.jin@linux.intel.com>
References: <20191008070502.22551-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already supported the 'total_cycles' option in previous
patch. It's also useful to show entries only above a threshold
percent.

This patch enables '--percent-limit' for not showing entries
under that percent.

For example,

 perf report -s total_cycles --stdio --percent-limit 1

 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 2M of event 'cycles'
 # Event count (approx.): 2753248
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
 # ...............  ..............  ...........  ..........  .................................................................  ....................
 #
            26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
            15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
             5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
             4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
             4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
             3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
             3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
             3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
             2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
             2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
             2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
             2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
             1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
             1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
             1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so

It only shows the entries which 'Sampled Cycles%' > 1%.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/ui/stdio/hist.c  |  7 ++++++-
 tools/perf/util/block.c     | 10 ++++++++++
 tools/perf/util/block.h     |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 189fd1b75ac8..96e4d68b3884 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -867,7 +867,7 @@ static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
 
 	get_block_hists(hists, bh, rep);
 	symbol_conf.report_individual_block = true;
-	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
+	hists__fprintf(&bh->block_hists, true, 0, 0, rep->min_percent,
 		       stdout, true);
 	hists__delete_entries(&bh->block_hists);
 	return 0;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 655ef7708cd0..d6991fc1d54e 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -15,6 +15,7 @@
 #include "../../util/srcline.h"
 #include "../../util/string2.h"
 #include "../../util/thread.h"
+#include "../../util/block.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
@@ -856,7 +857,11 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (h->filtered)
 			continue;
 
-		percent = hist_entry__get_percent_limit(h);
+		if (symbol_conf.report_individual_block)
+			percent = block_total_cycles_percent(h);
+		else
+			percent = hist_entry__get_percent_limit(h);
+
 		if (percent < min_pcnt)
 			continue;
 
diff --git a/tools/perf/util/block.c b/tools/perf/util/block.c
index e5e6f941f040..791a16da2102 100644
--- a/tools/perf/util/block.c
+++ b/tools/perf/util/block.c
@@ -61,3 +61,13 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 
 	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
 }
+
+float block_total_cycles_percent(struct hist_entry *he)
+{
+	struct block_info *bi = he->block_info;
+
+	if (bi->total_cycles)
+		return bi->cycles * 100.0 / bi->total_cycles;
+
+	return 0.0;
+}
diff --git a/tools/perf/util/block.h b/tools/perf/util/block.h
index 8031a8dd318a..c32919ca11cf 100644
--- a/tools/perf/util/block.h
+++ b/tools/perf/util/block.h
@@ -34,4 +34,6 @@ static inline void __block_info__zput(struct block_info **bi)
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right);
 
+float block_total_cycles_percent(struct hist_entry *he);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

