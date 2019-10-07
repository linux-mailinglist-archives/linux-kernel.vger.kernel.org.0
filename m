Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0857CE256
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfJGMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfJGMy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1B7230624D0;
        Mon,  7 Oct 2019 12:54:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C875D9CC;
        Mon,  7 Oct 2019 12:54:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 18/36] perf tools: Add perf_evlist__mmap_cb_idx function
Date:   Mon,  7 Oct 2019 14:53:26 +0200
Message-Id: <20191007125344.14268-19-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 07 Oct 2019 12:54:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__mmap_cb_idx function to call
auxtrace_mmap_params__set_idx on each new index
during perf_evlist__mmap_ops call.

Link: http://lkml.kernel.org/n/tip-26emdgzve9miryyzvcr77qgh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 09fe8fe9805d..71fdc6c92920 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -715,6 +715,17 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 	return 0;
 }
 
+static void
+perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
+			 struct perf_mmap_param *_mp,
+			 int idx, bool per_cpu)
+{
+	struct evlist *evlist = container_of(_evlist, struct evlist, core);
+	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -911,6 +922,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.flush		= flush,
 		.comp_level	= comp_level
 	};
+	struct perf_evlist_mmap_ops ops __maybe_unused = {
+		.idx = perf_evlist__mmap_cb_idx,
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
-- 
2.21.0

