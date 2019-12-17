Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25E122F32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 15:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfLQOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 09:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:08 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50F324679;
        Tue, 17 Dec 2019 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594148;
        bh=MnHeiTQZXGGqneZz3o+BjztcVbTxFHSDFVCsqptseO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Va3438/H+GBEiE4b1nwrz25vhbhgyq9VSG9jZmtb7gYKZCUEVfoqKuE9X/SuS+5sP
         lUzts6oBPPe8SjdVaBkDycnKWDCIjd+gtUB7J27jKSdytk65+F3IlzTIVdHXdu16il
         s6i/TwioT6t7PXjN8H9KtGS3HmnJk+5YuNgsYPNM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 05/12] perf hists browser: Generalize the do_zoom_dso() function
Date:   Tue, 17 Dec 2019 11:48:21 -0300
Message-Id: <20191217144828.2460-6-acme@kernel.org>
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

We'll use it to provide a top level hotkey to zoom into the kernel dso
directly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ae9cjel6v05wjnz9r6z77b6x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a4413d983216..8aba1aeea0eb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2530,11 +2530,8 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
-static int
-do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map)
 {
-	struct map *map = act->ms.map;
-
 	if (!hists__has(browser->hists, dso) || map == NULL)
 		return 0;
 
@@ -2556,6 +2553,12 @@ do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
+static int
+do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+{
+	return hists_browser__zoom_map(browser, act->ms.map);
+}
+
 static int
 add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	    char **optstr, struct map *map)
-- 
2.21.0

