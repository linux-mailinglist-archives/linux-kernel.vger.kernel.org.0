Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA297122F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfLQOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 09:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:48:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E1024655;
        Tue, 17 Dec 2019 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594137;
        bh=NFKnt6gXz+nYGmbT4x1wciBl+3LU8xpNNu9xNlIPmto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXsoUHFh03zcn33oXAyZb668QPlNTtNu2U+Exz+vJSCP21HKnVV+qezymPad52Piu
         7dgP1s47E8SaZ3ijB7hTwRpoVRO3eSrte0GzRMye8s5T89pfy6eOE9XmtxQQvEQbjb
         9hfOcpRnRkDcglJP/sK0xXB6pGbOKd36TG81waUU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 02/12] perf report/top: Make ENTER consistently bring up menu
Date:   Tue, 17 Dec 2019 11:48:18 -0300
Message-Id: <20191217144828.2460-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When callchains are present the ENTER key switches from bringing up the
menu that offers Annotation, Zoom by DSO, etc to expanding/collapsing
one callchain level, causing confusion, fix it by making it consistently
bring up the menu and use '+' to expand/collapse one callchain level.

Next patch will also add an entry to the menu to allow
expanding/collapsing, so that people used to ENTER expanding one
callchain level can quickly find it and use it instead.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cfc6172ecab7..fefa505d4fa8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -706,7 +706,7 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			browser->show_headers = !browser->show_headers;
 			hist_browser__update_rows(browser);
 			break;
-		case K_ENTER:
+		case '+':
 			if (hist_browser__toggle_fold(browser))
 				break;
 			/* fall thru */
@@ -2858,6 +2858,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"For symbolic views (--sort has sym):\n\n"			\
 	"ENTER         Zoom into DSO/Threads & Annotate current symbol\n" \
 	"ESC           Zoom out\n"					\
+	"+             Expand/Collapse one callchain level\n"		\
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
-- 
2.21.0

