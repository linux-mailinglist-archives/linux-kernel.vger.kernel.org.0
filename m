Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81D1315BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAFQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgAFQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:08:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620672081E;
        Mon,  6 Jan 2020 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326900;
        bh=gGXyDP7QaDjAhsl8iv8BvtuyPLl8ZSQTRd6hLsNm5d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6UOAKHBY37bnoWm0UwIpgtEgeZ9Eku/dAeaEH3dpZ0bUwh6BsyujtqouiYWCuFDz
         IGPRI4OTXOBLY/S2W+oVKcpcOsfWCJjnTceaw/h4VEvgCwPQM24+M4mV8SbkZ+SH0k
         tkOHt8Hc3ORAtKkbxn49WPDk9AyXvHH0xHy6QqAY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 18/20] perf report/top: Do not offer annotation for symbols without samples
Date:   Mon,  6 Jan 2020 13:07:03 -0300
Message-Id: <20200106160705.10899-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This can happen in the --children mode, i.e. the default mode when
callchains are present, where one of the main entries may be a callchain
entry with no samples.

So far we were not providing any information about why an annotation
couldn't be provided even offering the Annotation option in the popup
menu.

Work is needed to allow for no-samples "annotation', i.e. to show the
disassembly anyway and allow for navigation, etc.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0hhzj2de15o88cguy7h66zre@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8776b1cb29b7..3bec8de89880 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,7 +2465,8 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
 		 struct map_symbol *ms)
 {
-	if (ms->sym == NULL || ms->map->dso->annotate_warned)
+	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
+	    symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3031,6 +3032,14 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			    browser->selection->map->dso->annotate_warned)
 				continue;
 
+			if (symbol__annotation(browser->selection->sym)->src == NULL) {
+				ui_browser__warning(&browser->b, delay_secs * 2,
+						    "No samples for the \"%s\" symbol.\n\n"
+						    "Probably appeared just in a callchain",
+						    browser->selection->sym->name);
+				continue;
+			}
+
 			actions->ms.map = browser->selection->map;
 			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
-- 
2.21.1

