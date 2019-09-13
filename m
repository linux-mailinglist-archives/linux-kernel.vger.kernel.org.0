Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9EB20E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391268AbfIMN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34521 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391236AbfIMNYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 015C087521D;
        Fri, 13 Sep 2019 13:24:51 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9385C1D4;
        Fri, 13 Sep 2019 13:24:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 21/73] libperf: Move mmap_len from struct evlist to struct perf_evlist
Date:   Fri, 13 Sep 2019 15:23:03 +0200
Message-Id: <20190913132355.21634-22-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 13:24:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mmap_len from struct evlist to struct perf_evlist
it will be used in following patches.

Link: http://lkml.kernel.org/n/tip-0md597ojq254vdemewxrmukh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/util/evlist.c                 | 10 +++++-----
 tools/perf/util/evlist.h                 |  1 -
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6e9f5619f062..68091f3773a8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1407,7 +1407,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
-	session->header.env.comp_mmap_len = session->evlist->mmap_len;
+	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 035c1e1cc324..01b813616440 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -14,6 +14,7 @@ struct perf_evlist {
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
+	size_t			 mmap_len;
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 891052570e73..07f02afa3407 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1011,11 +1011,11 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->mmap_len = evlist__mmap_size(pages);
-	pr_debug("mmap size %zuB\n", evlist->mmap_len);
-	mp.mask = evlist->mmap_len - page_size - 1;
+	evlist->core.mmap_len = evlist__mmap_size(pages);
+	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
+	mp.mask = evlist->core.mmap_len - page_size - 1;
 
-	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->mmap_len,
+	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1599,7 +1599,7 @@ int perf_evlist__strerror_open(struct evlist *evlist,
 int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	int pages_attempted = evlist->mmap_len / 1024, pages_max_per_user, printed = 0;
+	int pages_attempted = evlist->core.mmap_len / 1024, pages_max_per_user, printed = 0;
 
 	switch (err) {
 	case EPERM:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4c465b4aced8..3767866e98c1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -28,7 +28,6 @@ struct evlist {
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
 	bool		 enabled;
-	size_t		 mmap_len;
 	int		 id_pos;
 	int		 is_pos;
 	u64		 combined_sample_type;
-- 
2.21.0

