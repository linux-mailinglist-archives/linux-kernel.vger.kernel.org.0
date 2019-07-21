Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38116F2F0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfGULa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A9273091783;
        Sun, 21 Jul 2019 11:30:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8E75D9D3;
        Sun, 21 Jul 2019 11:30:23 +0000 (UTC)
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
Subject: [PATCH 44/79] libperf: Move zalloc.o into libperf
Date:   Sun, 21 Jul 2019 13:24:31 +0200
Message-Id: <20190721112506.12306-45-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 21 Jul 2019 11:30:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need it in both perf and libperf, thus moving
it to libperf.

Link: http://lkml.kernel.org/n/tip-tx94jf7u0cu45tjzl1xt1znj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Build               | 5 +++++
 tools/perf/util/Build              | 5 -----
 tools/perf/util/python-ext-sources | 1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index b27c1543b046..faf64db13e37 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -3,3 +3,8 @@ libperf-y += cpumap.o
 libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
+libperf-y += zalloc.o
+
+$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 14f812bb07a7..08f670d21615 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,7 +26,6 @@ perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
-perf-y += zalloc.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -243,7 +242,3 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)util/zalloc.o: ../lib/zalloc.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index ceb8afdf9a89..2237bac9fadb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,7 +18,6 @@ util/namespaces.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
-../lib/zalloc.c
 util/thread_map.c
 util/util.c
 util/xyarray.c
-- 
2.21.0

