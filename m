Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD96184154
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 08:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCMHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 03:12:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:7824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCMHMW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:12:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 00:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; 
   d="scan'208";a="266642311"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 00:12:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 12/14] perf util: Filter out streams by name of changed functions
Date:   Fri, 13 Mar 2020 15:11:16 +0800
Message-Id: <20200313071118.11983-13-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313071118.11983-1-yao.jin@linux.intel.com>
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime some changes are not reflected in the source code,
e.g. changing the compiler option. So for this, we can't get
the changes by diffing the source code lines.

This idea is to let user provide a list of changed functions,
then perf-diff can know these functions are not matched between
old perf data and new perf data.

In this patch, the names of changed function names are stored
in strlist, and we will check if the symbol name is in strlist.
If yes, that means this function is changed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c   |  2 +-
 tools/perf/util/callchain.c | 30 ++++++++++++++++++++++++++----
 tools/perf/util/callchain.h |  4 +++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 566e811054b1..2f891e8a5122 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1017,7 +1017,7 @@ static int process_base_stream(struct data__file *data_base,
 		if (!es_pair)
 			return -1;
 
-		callchain_match_streams(es_base, es_pair, pdiff.src_list);
+		callchain_match_streams(es_base, es_pair, pdiff.src_list, NULL);
 		callchain_stream_report(es_base, es_pair);
 	}
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 84fe8e418532..3894514e116c 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1810,16 +1810,35 @@ static bool chain_srclist_match(struct srclist *src_list, const char *srcline_a,
 	return false;
 }
 
+static bool sym_name_changed(struct callchain_list *base_chain,
+			     struct callchain_list *pair_chain,
+			     struct strlist *func_list)
+{
+	if (!func_list || !base_chain->ms.sym || !pair_chain->ms.sym)
+		return false;
+
+	if (strlist__has_entry(func_list, base_chain->ms.sym->name))
+		return true;
+
+	return false;
+}
+
 static bool chain_match(struct callchain_list *base_chain,
 			struct callchain_list *pair_chain,
 			struct srclist *src_list,
+			struct strlist *func_list,
 			bool *src_changed)
 {
 	enum match_result match;
 	bool src_found = false;
+	bool func_changed;
 
 	*src_changed = false;
 
+	func_changed = sym_name_changed(base_chain, pair_chain, func_list);
+	if (func_changed)
+		return false;
+
 	/*
 	 * Check sourceline first. If not matched,
 	 * fallback to symbol match and address match.
@@ -1850,6 +1869,7 @@ static bool chain_match(struct callchain_list *base_chain,
 static bool callchain_node_matched(struct callchain_node *base_cnode,
 				   struct callchain_node *pair_cnode,
 				   struct srclist *src_list,
+				   struct strlist *func_list,
 				   int *nr_changed)
 {
 	struct callchain_list *base_chain, *pair_chain;
@@ -1871,7 +1891,7 @@ static bool callchain_node_matched(struct callchain_node *base_cnode,
 		}
 
 		match = chain_match(base_chain, pair_chain, src_list,
-				    &src_changed);
+				    func_list, &src_changed);
 
 		if (src_changed) {
 			pair_chain->src_changed = true;
@@ -1897,6 +1917,7 @@ static bool callchain_node_matched(struct callchain_node *base_cnode,
 static struct stream_node *stream_node_match(struct stream_node *base_node,
 					     struct callchain_streams *cs_pair,
 					     struct srclist *src_list,
+					     struct strlist *func_list,
 					     bool *src_changed)
 {
 	*src_changed = false;
@@ -1906,7 +1927,7 @@ static struct stream_node *stream_node_match(struct stream_node *base_node,
 		int nr_changed = 0;
 
 		if (callchain_node_matched(base_node->cnode, pair_node->cnode,
-					   src_list, &nr_changed)) {
+					   src_list, func_list, &nr_changed)) {
 			if (nr_changed)
 				*src_changed = true;
 
@@ -1928,7 +1949,8 @@ static void stream_nodes_link(struct stream_node *base_node,
 
 void callchain_match_streams(struct callchain_streams *cs_base,
 			     struct callchain_streams *cs_pair,
-			     struct srclist *src_list)
+			     struct srclist *src_list,
+			     struct strlist *func_list)
 {
 	for (int i = 0; i < cs_base->nr_streams; i++) {
 		struct stream_node *base_node = &cs_base->streams[i];
@@ -1936,7 +1958,7 @@ void callchain_match_streams(struct callchain_streams *cs_base,
 		bool src_changed;
 
 		pair_node = stream_node_match(base_node, cs_pair, src_list,
-					      &src_changed);
+					      func_list, &src_changed);
 		if (pair_node)
 			stream_nodes_link(base_node, pair_node, src_changed);
 		else
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 90826a280476..a6153af9f776 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -7,6 +7,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "srclist.h"
+#include "strlist.h"
 
 struct addr_location;
 struct evsel;
@@ -316,7 +317,8 @@ struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *
 
 void callchain_match_streams(struct callchain_streams *cs_base,
 			     struct callchain_streams *cs_pair,
-			     struct srclist *src_list);
+			     struct srclist *src_list,
+			     struct strlist *func_list);
 
 void callchain_stream_report(struct callchain_streams *cs_base,
 			     struct callchain_streams *cs_pair);
-- 
2.17.1

