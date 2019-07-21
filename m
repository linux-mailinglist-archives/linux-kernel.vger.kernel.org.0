Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152076F30A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGULc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BDB53082B5F;
        Sun, 21 Jul 2019 11:32:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9975D9D3;
        Sun, 21 Jul 2019 11:32:22 +0000 (UTC)
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
Subject: [PATCH 69/79] libperf: Add perf_evlist__enable/disable functions
Date:   Sun, 21 Jul 2019 13:24:56 +0200
Message-Id: <20190721112506.12306-70-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:32:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving following functions:
  perf_evlist__enable
  perf_evlist__disable

Link: http://lkml.kernel.org/n/tip-9icfpf3v1etadp53io13b8ga@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 16 ++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  2 ++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 044f664e0733..18e30d96f832 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -141,3 +141,19 @@ void perf_evlist__close(struct perf_evlist *evlist)
 	perf_evlist__for_each_entry_reverse(evlist, evsel)
 		perf_evsel__close(evsel);
 }
+
+void perf_evlist__enable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__enable(evsel);
+}
+
+void perf_evlist__disable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__disable(evsel);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 6d3dda743541..38365f8f3fba 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -20,6 +20,8 @@ LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
 LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__enable(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
 
 #define perf_evlist__for_each_evsel(evlist, pos)	\
 	for ((pos) = perf_evlist__next((evlist), NULL);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 4f966ddd5e53..2068e3d52227 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -27,6 +27,8 @@ LIBPERF_0.0.1 {
 		perf_evlist__delete;
 		perf_evlist__open;
 		perf_evlist__close;
+		perf_evlist__enable;
+		perf_evlist__disable;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0

