Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B98B209A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbfIMNYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:24:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391124AbfIMNYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B18FE18C8934;
        Fri, 13 Sep 2019 13:24:14 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 172185C1D4;
        Fri, 13 Sep 2019 13:24:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 06/73] perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
Date:   Fri, 13 Sep 2019 15:22:48 +0200
Message-Id: <20190913132355.21634-7-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 13:24:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename (perf_evlist__alloc_mmap) to evlist__alloc_mmap(), so we don't
have a name clash when we add (perf_evlist__alloc_mmap) in libperf.

Link: http://lkml.kernel.org/n/tip-k2rpqpssgvvgyuhbjtgirbpi@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index cc11b1a22042..dc7117c33ab8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -693,8 +693,8 @@ void evlist__munmap(struct evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
-						 bool overwrite)
+static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
+				       bool overwrite)
 {
 	int i;
 	struct mmap *map;
@@ -752,7 +752,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			maps = evlist->overwrite_mmap;
 
 			if (!maps) {
-				maps = perf_evlist__alloc_mmap(evlist, true);
+				maps = evlist__alloc_mmap(evlist, true);
 				if (!maps)
 					return -1;
 				evlist->overwrite_mmap = maps;
@@ -1004,7 +1004,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 				  .comp_level = comp_level };
 
 	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
+		evlist->mmap = evlist__alloc_mmap(evlist, false);
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-- 
2.21.0

