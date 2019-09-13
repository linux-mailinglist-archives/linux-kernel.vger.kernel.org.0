Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE6B20C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbfIMNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391458AbfIMNZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27E2686679;
        Fri, 13 Sep 2019 13:25:53 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82EFA5C1D4;
        Fri, 13 Sep 2019 13:25:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 46/73] libperf: Add perf_mmap__new function
Date:   Fri, 13 Sep 2019 15:23:28 +0200
Message-Id: <20190913132355.21634-47-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 13 Sep 2019 13:25:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_mmap__new function to create and
initialize new 'struct perf_mmap' object to
internal header internal/mmap.h

Link: http://lkml.kernel.org/n/tip-e0zucg7w3h6j1hrq0cq2v8kc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index cc0a5995cd3c..31946e26368a 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -41,6 +41,8 @@ struct perf_mmap_param {
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
+struct perf_mmap *perf_mmap__new(bool overwrite,
+				 libperf_unmap_cb_t unmap_cb);
 void perf_mmap__init(struct perf_mmap *map, bool overwrite,
 		     libperf_unmap_cb_t unmap_cb);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index ea46f325fa98..720dda578ed9 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/mman.h>
+#include <linux/zalloc.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 
@@ -12,6 +13,16 @@ void perf_mmap__init(struct perf_mmap *map, bool overwrite,
 	refcount_set(&map->refcnt, 0);
 }
 
+struct perf_mmap *perf_mmap__new(bool overwrite, libperf_unmap_cb_t unmap_cb)
+{
+	struct perf_mmap *map = zalloc(sizeof(*map));
+
+	if (map)
+		perf_mmap__init(map, overwrite, unmap_cb);
+
+	return map;
+}
+
 size_t perf_mmap__mmap_len(struct perf_mmap *map)
 {
 	return map->mask + 1 + page_size;
-- 
2.21.0

