Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7548696974
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfHTT2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 15:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfHTT2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:52 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D41230F2;
        Tue, 20 Aug 2019 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329331;
        bh=bZnv71CTniUEAilGi3jmvS0sEzaXQkB8cxmprb8RNXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEmkRyLBRlu1GmAwvIhFXudcfWdwhz1c2dy0sZFJ8zmRyvwvwUwkqQRTHYHnVKlQ1
         5YycNzBe/MqkuUE9SyMxE/mvf9XQw3I2yEX8KGlKgwt2/pnxSrXWzNm/HHSEspg05z
         kQ/NCComgpALitwnXk0LGXdkMn3QSu+wmsa+anpQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/17] perf top: Show info message while collecting samples
Date:   Tue, 20 Aug 2019 16:27:31 -0300
Message-Id: <20190820192733.19180-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Give visual cue about what is happening while initially collecting the
minimal set of samples to collect/sort/display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xcui60p1v6ozijfam2o89ya8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b195b1ba625b..30547fdb0787 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2894,6 +2894,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	if (symbol_conf.col_width_list_str)
 		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
 
+	if (!is_report_browser(hbt))
+		browser->b.no_samples_msg = "Collecting samples...";
+
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
-- 
2.21.0

