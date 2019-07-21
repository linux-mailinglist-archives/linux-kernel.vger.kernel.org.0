Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A336F2D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGUL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2E8C3082E90;
        Sun, 21 Jul 2019 11:27:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD1245DD80;
        Sun, 21 Jul 2019 11:27:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 17/79] perf tools: Rename perf_evsel__apply_filter to evsel__apply_filter
Date:   Sun, 21 Jul 2019 13:24:04 +0200
Message-Id: <20190721112506.12306-18-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 11:27:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__apply_filter to evsel__apply_filter, so we don't
have a name clash when we add perf_evsel__apply_filter in libperf.

Link: http://lkml.kernel.org/n/tip-39471ej79lohwjen50um9qwv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 2 +-
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9461583c53d9..e71c3cc93924 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1158,7 +1158,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = perf_evsel__apply_filter(evsel, evsel->filter);
+		err = evsel__apply_filter(evsel, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 855d286298eb..5aeb7260c8e1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1187,7 +1187,7 @@ static int perf_evsel__run_ioctl(struct evsel *evsel,
 	return 0;
 }
 
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter)
+int evsel__apply_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c338ce14e8aa..35f7e7ff3c5e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -294,7 +294,7 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
+int evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
-- 
2.21.0

