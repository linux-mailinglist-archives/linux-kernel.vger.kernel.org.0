Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6620263B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfGISdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGISdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:33:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C54520656;
        Tue,  9 Jul 2019 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697189;
        bh=KszjUYtgLQLtSW1cBi/FB/Vr+ozCmXKbJls+v8/d2Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8iQL7E15IMCw60dkBnTlvmxBoAUZtTsRcEuiS+ZwBJw3vfoOPCqXBzOWoMj3nxEN
         CkuFqdIoeSN9PJqvxi/3u5L+Zsj5RWauMq2A/P5L6Ayfh4F/jjnQMPH71ylZC/Zkju
         VU12QzNPW5IqWzjl/TjUVVrabDIAKCaL5FoxfEZs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/25] perf hists browser: Fix potential NULL pointer dereference found by the smatch tool
Date:   Tue,  9 Jul 2019 15:31:21 -0300
Message-Id: <20190709183126.30257-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/ui/browsers/hists.c:641
  hist_browser__run() error: we previously assumed 'hbt' could be
  null (see line 625)

  tools/perf/ui/browsers/hists.c:3088
  perf_evsel__hists_browse() error: we previously assumed
  'browser->he_selection' could be null (see line 2902)

  tools/perf/ui/browsers/hists.c:3272
  perf_evsel_menu__run() error: we previously assumed 'hbt' could be
  null (see line 3260)

This patch firstly validating the pointers before access them, so can
fix potential NULL pointer dereference.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190708143937.7722-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 85581cfb9112..a94eb0755e8b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -639,7 +639,11 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 		switch (key) {
 		case K_TIMER: {
 			u64 nr_entries;
-			hbt->timer(hbt->arg);
+
+			WARN_ON_ONCE(!hbt);
+
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (hist_browser__has_filter(browser) ||
 			    symbol_conf.report_hierarchy)
@@ -2821,7 +2825,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
-	struct branch_info *bi;
+	struct branch_info *bi = NULL;
 #define MAX_OPTIONS  16
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
@@ -3087,7 +3091,9 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 			goto skip_annotation;
 
 		if (sort__mode == SORT_MODE__BRANCH) {
-			bi = browser->he_selection->branch_info;
+
+			if (browser->he_selection)
+				bi = browser->he_selection->branch_info;
 
 			if (bi == NULL)
 				goto skip_annotation;
@@ -3271,7 +3277,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 
 		switch (key) {
 		case K_TIMER:
-			hbt->timer(hbt->arg);
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (!menu->lost_events_warned &&
 			    menu->lost_events &&
-- 
2.21.0

