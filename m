Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43217A1D39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfH2OkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfH2OkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C2123426;
        Thu, 29 Aug 2019 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089613;
        bh=AGfYEeKcgA3pLGn4fOxwgAAcIsBcJXV6d2EquToiWqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1c6cRMmhZC7a6SMv9kXjT77RHaSrm5QUilF3EyQOH1QPVIfYX/A7VlOY8jNC+/mS
         glAMNdYwuOWX7nomC6Eve9EfmLX4TS6PWD5We9LkH1o/jmyhcP//RL+m73JC+aUJcp
         FKHnm9/JNChVe/MEYPTawE+axKIxeglaPPvEO2sM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/37] perf top: Decay all events in the evlist
Date:   Thu, 29 Aug 2019 11:38:50 -0300
Message-Id: <20190829143917.29745-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Currently perf top only decays entries in a selected evsel.  I don't
know whether it's intended (maybe due to performance reason?) but anyway
it might show incorrect output when event group is used since users will
see leader event is decayed but others are not.

This patch moves the decay code into perf_top__resort_hists() so that
stdio and TUI code shared the logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190827231555.121411-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 42ba733c9045..104dbb1095c5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -265,13 +265,23 @@ static void perf_top__show_details(struct perf_top *top)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static void evlist__resort_hists(struct evlist *evlist)
+static void perf_top__resort_hists(struct perf_top *t)
 {
+	struct evlist *evlist = t->evlist;
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		if (evlist->enabled) {
+			if (t->zero) {
+				hists__delete_entries(hists);
+			} else {
+				hists__decay_entries(hists, t->hide_user_symbols,
+						     t->hide_kernel_symbols);
+			}
+		}
+
 		hists__collapse_resort(hists, NULL);
 
 		/* Non-group events are considered as leader */
@@ -320,16 +330,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 		return;
 	}
 
-	if (top->evlist->enabled) {
-		if (top->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, top->hide_user_symbols,
-					     top->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(top->evlist);
+	perf_top__resort_hists(top);
 
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
@@ -577,24 +578,11 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 static void perf_top__sort_new_samples(void *arg)
 {
 	struct perf_top *t = arg;
-	struct evsel *evsel = t->sym_evsel;
-	struct hists *hists;
 
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
-	hists = evsel__hists(evsel);
-
-	if (t->evlist->enabled) {
-		if (t->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, t->hide_user_symbols,
-					     t->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(t->evlist);
+	perf_top__resort_hists(t);
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-- 
2.21.0

