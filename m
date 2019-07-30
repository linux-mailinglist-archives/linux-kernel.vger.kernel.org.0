Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372B379F47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfG3DBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 23:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbfG3DBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46272171F;
        Tue, 30 Jul 2019 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455707;
        bh=8fCo+FsXAwJQ7MNMVB0NVYlqBesw+GzF0uRKBXW5SA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BGX6zukXZQd/eSSsvk6tOyMIoUqSUJln0K1mNvfzi+RjLWhLaWIAOseH9lnMfbkH
         4+CYpDjUoxht+jPrtU+MhSEjOrDaqQbviFLbt65c0wgBTqCe1zr42TIQSbCmKM6+vX
         ESh1QFLfPZz7zTyzQnj7d56hpy5bQFiSQ7vnaF+8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 096/107] libperf: Adopt perf_evlist__enable()/disable() functions from perf
Date:   Mon, 29 Jul 2019 23:55:59 -0300
Message-Id: <20190730025610.22603-97-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adopt the following functions from tools/perf:

  perf_evlist__enable()
  perf_evlist__disable()

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-70-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 16 ++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  2 ++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5dda96b1d4da..f4dc9a208332 100644
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

