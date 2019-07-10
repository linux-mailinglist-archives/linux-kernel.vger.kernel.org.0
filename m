Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967FC63B11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfGISca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfGISca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3570217D4;
        Tue,  9 Jul 2019 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697148;
        bh=dxZWVgs9n6oX4BuH6iEjBVW2+cAQ9oiYK+/bO8q97v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKjD9ITQxsBeM+3cvY84A7VodueZfXF8NXkpCn7+uShqgRkg3itIetuAG8u4P3fTd
         KdR2hTV8cEIheRngoOSLlPZyLDpTUz59ztCiHFk6IayXjo9hJXPCS9JlxDuVk6VL9q
         +gPdFQxV0flkFZu7Pu046NV6+MaYpxH1l5uGD4OI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 09/25] perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel
Date:   Tue,  9 Jul 2019 15:31:10 -0300
Message-Id: <20190709183126.30257-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll return "unknown", no need to open code it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4okvjmm18arjrcyfhuahgfxm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/util/session.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aef59f318a67..93d4b12e248e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -298,7 +298,7 @@ static int process_read_event(struct perf_tool *tool,
 	struct report *rep = container_of(tool, struct report, tool);
 
 	if (rep->show_threads) {
-		const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
+		const char *name = perf_evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
 					   evsel->idx,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2e61dd6a3574..e3463df18493 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1246,7 +1246,7 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
 		return;
 
 	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
-	       evsel ? perf_evsel__name(evsel) : "FAIL",
+	       perf_evsel__name(evsel),
 	       event->read.value);
 
 	if (!evsel)
-- 
2.21.0

