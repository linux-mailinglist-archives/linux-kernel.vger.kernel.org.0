Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB501928A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCYMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:41:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393C92078D;
        Wed, 25 Mar 2020 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140116;
        bh=5kLIaV+wxBwtB50F88Hi4Gs9W65g7scPjW3BSWy2WhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whNZP2e65McW9Gxs58WIVFqZZO3+PxrHoy5at5sHFQqTAY//goq7bLwFqOMKcadnK
         bKHRuy9YScXUtRL8KtDaUS8PlJxxFsexyfhD40vRMjlAhun7KrUSsdcDO1dDAMmDyj
         EANbA4JrwoeWa2yHRgiSAceTJHpNL1XQ83uAeMrE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/24] perf report/top TUI: Support hotkey 'a' for annotation of unresolved addresses
Date:   Wed, 25 Mar 2020 09:41:05 -0300
Message-Id: <20200325124124.32648-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In previous patch, we have supported the annotation functionality even
without symbols.

For this patch, it supports the hotkey 'a' on address in report view.
Note that, for branch mode, we only support the annotation for "branch
to" address.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200227043939.4403-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 46 ++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d0f9745856fd..1103a019d83f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3061,21 +3061,45 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 				continue;
 			}
 
-			if (browser->selection == NULL ||
-			    browser->selection->sym == NULL ||
-			    browser->selection->map->dso->annotate_warned)
+			if (!browser->selection ||
+			    !browser->selection->map ||
+			    !browser->selection->map->dso ||
+			    browser->selection->map->dso->annotate_warned) {
 				continue;
+			}
 
-			if (symbol__annotation(browser->selection->sym)->src == NULL) {
-				ui_browser__warning(&browser->b, delay_secs * 2,
-						    "No samples for the \"%s\" symbol.\n\n"
-						    "Probably appeared just in a callchain",
-						    browser->selection->sym->name);
-				continue;
+			if (!browser->selection->sym) {
+				if (!browser->he_selection)
+					continue;
+
+				if (sort__mode == SORT_MODE__BRANCH) {
+					bi = browser->he_selection->branch_info;
+					if (!bi || !bi->to.ms.map)
+						continue;
+
+					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
+					actions->ms.map = bi->to.ms.map;
+				} else {
+					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
+										 browser->selection->map);
+					actions->ms.map = browser->selection->map;
+				}
+
+				if (!actions->ms.sym)
+					continue;
+			} else {
+				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+					ui_browser__warning(&browser->b, delay_secs * 2,
+						"No samples for the \"%s\" symbol.\n\n"
+						"Probably appeared just in a callchain",
+						browser->selection->sym->name);
+					continue;
+				}
+
+				actions->ms.map = browser->selection->map;
+				actions->ms.sym = browser->selection->sym;
 			}
 
-			actions->ms.map = browser->selection->map;
-			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
 			continue;
 		case 'P':
-- 
2.21.1

