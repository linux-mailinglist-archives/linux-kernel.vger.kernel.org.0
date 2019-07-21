Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EE6F2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfGUL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7D5F3082132;
        Sun, 21 Jul 2019 11:27:18 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE3F35D9D3;
        Sun, 21 Jul 2019 11:27:13 +0000 (UTC)
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
Subject: [PATCH 13/79] perf tools: Rename perf_evlist__remove to evlist__remove
Date:   Sun, 21 Jul 2019 13:24:00 +0200
Message-Id: <20190721112506.12306-14-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 21 Jul 2019 11:27:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__remove to evlist__remove, so we don't
have a name clash when we add perf_evlist__remove in libperf.

Link: http://lkml.kernel.org/n/tip-xgzjnysc47nshnxecize1u6o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/evlist.c    | 2 +-
 tools/perf/util/evlist.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 917c8fb4baa5..4e56e399bbc8 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -622,7 +622,7 @@ static void strip_fini(struct perf_inject *inject)
 		if (evsel->handler == drop_sample &&
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			perf_evlist__remove(evlist, evsel);
+			evlist__remove(evlist, evsel);
 			evsel__delete(evsel);
 		}
 	}
@@ -724,7 +724,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (evsel) {
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
-				perf_evlist__remove(session->evlist, evsel);
+				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
 			if (inject->strip)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7741e12bdcb0..47516db62424 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -190,7 +190,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel)
+void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d52b29a1d852..b3a44e2eed08 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,7 +74,7 @@ void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
+void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
 
-- 
2.21.0

