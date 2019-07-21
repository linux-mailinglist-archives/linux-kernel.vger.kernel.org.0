Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E976F2C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfGUL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfGUL0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:26:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1129D30832C8;
        Sun, 21 Jul 2019 11:26:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 291235D9D3;
        Sun, 21 Jul 2019 11:26:33 +0000 (UTC)
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
Subject: [PATCH 06/79] perf tools: Rename perf_evsel__init to evsel__init
Date:   Sun, 21 Jul 2019 13:23:53 +0200
Message-Id: <20190721112506.12306-7-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 21 Jul 2019 11:26:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__init to evsel__init, so we don't
have a name clash when we add perf_evsel__init in libperf.

Link: http://lkml.kernel.org/n/tip-ek9h0ywy7egemq42g34l7pii@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 3 +--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f7f97ca6e96d..97bee83f0f98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -223,8 +223,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel,
+		 struct perf_event_attr *attr, int idx)
 {
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
@@ -255,7 +255,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 	if (!evsel)
 		return NULL;
-	perf_evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -350,7 +350,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		perf_evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx);
 	}
 
 	return evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3caabd8a4aa6..af230d92fbef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -238,8 +238,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
 void perf_evsel__delete(struct evsel *evsel);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ed57b6b5ed91..f6fe3c90828f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -782,7 +782,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	perf_evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx);
 	return 0;
 }
 
-- 
2.21.0

