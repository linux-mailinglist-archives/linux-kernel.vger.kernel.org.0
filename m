Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B8A4922
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfIAMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfIAMYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579B42342E;
        Sun,  1 Sep 2019 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340639;
        bh=3ojWJkDiVmBLB6E6ua39FFAUfBtiVF8n/16tVWBch4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y481QuGp4PjIlnDs4Txv0q2RvoIRit9hxqPw7Ph+o5k7BZj5hGAx1gs4Zh6OEMAz/
         +xKy14SgUjIQYtLigyGPZvs/PfxFZGhZfpyiORAb0xqsryoiR4dkqPUTkX4JHdZiqU
         ZDCnx+JFMN+sVuXZVAlFQPfCvV4QUzi3c4JG7wmA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/47] perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
Date:   Sun,  1 Sep 2019 09:22:46 -0300
Message-Id: <20190901122326.5793-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

The function cpu__max_cpu() returns the possible number of CPUs as
defined in the sysfs and can be used as an alternative for MAX_NR_CPUS
in write_cache.

MAX_CACHES is replaced by cpu__max_cpu() * MAX_CACHE_LVL.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-7-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0a842d9eff22..dd2bb0861ab1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1122,16 +1122,17 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES (MAX_NR_CPUS * 4)
+#define MAX_CACHE_LVL 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	u32 max_caches = cpu__max_cpu() * MAX_CACHE_LVL;
+	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, max_caches, &cnt);
 	if (ret)
 		goto out;
 
-- 
2.21.0

