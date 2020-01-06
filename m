Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF23E1315B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFQIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbgAFQID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:08:03 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B105820848;
        Mon,  6 Jan 2020 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326882;
        bh=wJaWwyewDlZ17sKtB6mkXaV5q6ubeAcuxScs1Pa4WhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRTA1gEK9hcHQnrXT712S5fJJIPf3762gFZuhcgm+aLVlFXqFQmEFj5cqiWQLPgL2
         17nQ6D86eWipl+Km0AACvj/TbxYdh2RFAnnOSKDplwGGD1Zkbb2igwnuP/Ia5jMyNQ
         giws1rEMMxWuWZKVaTMLb1dG+5+6ax72s0kaGq+E=
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
Subject: [PATCH 13/20] perf hists browser: Generalize the do_zoom_dso() function
Date:   Mon,  6 Jan 2020 13:06:58 -0300
Message-Id: <20200106160705.10899-14-acme@kernel.org>
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

We'll use it to provide a top level hotkey to zoom into the kernel dso
directly.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
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
2.21.1

