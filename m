Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F66F2EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGUL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1BF23082A6C;
        Sun, 21 Jul 2019 11:29:45 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04995D9D3;
        Sun, 21 Jul 2019 11:29:41 +0000 (UTC)
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
Subject: [PATCH 40/79] libperf: Add perf_evlist__remove function
Date:   Sun, 21 Jul 2019 13:24:27 +0200
Message-Id: <20190721112506.12306-41-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:29:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__remove function to remove perf_evsel
from perf_evlist struct.

Link: http://lkml.kernel.org/n/tip-7teqwbvjj0ju80vf62245kig@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 2 ++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e5f187fa4e57..023fe4b44131 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -14,3 +14,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
 {
 	list_add_tail(&evsel->node, &evlist->entries);
 }
+
+void perf_evlist__remove(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel)
+{
+	list_del_init(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 6992568b14a0..e0c87995c6ff 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -10,5 +10,7 @@ struct perf_evsel;
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
+LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 06ccf31eb24d..168339f89a2e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__init;
 		perf_evlist__init;
 		perf_evlist__add;
+		perf_evlist__remove;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ea25c7b49a4c..19b09e908e33 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -194,7 +194,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
-	list_del_init(&evsel->core.node);
+	perf_evlist__remove(&evlist->core, &evsel->core);
 	evlist->nr_entries -= 1;
 }
 
-- 
2.21.0

