Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D569679D7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfGMLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 07:06:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfGMLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:06:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB5v8w3840872
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:05:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB5v8w3840872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015958;
        bh=oiJllkUEe3bvX1caGxx3UspuML9qGy2is/bPD1y+r14=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KFxofTuHICog3nGEJvXvBg1HXVdUaearvg+Q28sxvCV0vxCgooQa0SL1lsiMeeLM6
         lNq19fMb4YeLBRs+n2IgjpTTsbozAnnOFdm8T2TbyspUPhB+W0s/WWwxfZkxqsMzfZ
         0GluP8IU5VaVmQmY25jGwh+8g5ytzOIeUYcbiHTia1G0x0cwQoD8Cfx5OGGr1RRLCr
         S4Ly67fJIIFcEzTgjtyqu3Y5G/daq6djUsgC+X/b4qyc88FfETNU6FvSH7ntinTFFt
         E2jThcnAZDa00HIsFl2nEx7Q28SeCXfFPYhLd71bm5fJkQNwAgs7sfGpOZqlnxhFfv
         6Hh5CUz77FQ6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB5vsj3840869;
        Sat, 13 Jul 2019 04:05:57 -0700
Date:   Sat, 13 Jul 2019 04:05:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-ceb75476db1617a88cc29b09839acacb69aa076e@git.kernel.org>
Cc:     ak@linux.intel.com, adrian.hunter@intel.com, mingo@kernel.org,
        hpa@zytor.com, suzuki.poulose@arm.com, tglx@linutronix.de,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: tglx@linutronix.de, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
          mathieu.poirier@linaro.org, namhyung@kernel.org,
          jolsa@kernel.org, acme@redhat.com
In-Reply-To: <20190708143937.7722-2-leo.yan@linaro.org>
References: <20190708143937.7722-2-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: ceb75476db1617a88cc29b09839acacb69aa076e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ceb75476db1617a88cc29b09839acacb69aa076e
Gitweb:     https://git.kernel.org/tip/ceb75476db1617a88cc29b09839acacb69aa076e
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 8 Jul 2019 22:39:34 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf hists browser: Fix potential NULL pointer dereference found by the smatch tool

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
