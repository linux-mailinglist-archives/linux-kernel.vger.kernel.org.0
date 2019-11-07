Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98062F37DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfKGTE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:27 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BE4218AE;
        Thu,  7 Nov 2019 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153467;
        bh=ARgfAKIqGyaTgnszbwvPaWy1NAB17gCqB7YLPzkNJtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp1kt+VPBTjZ5k0m7l14JpwST8keI2K/Gfgy4R8zA1m3JbxmeJ311qSG69P+TgznS
         kocb+C4Y5CRy5mDyA7APtZ2Vhw6wWkldUDn3KN02FsHxI5M8ficMv9x76WoCnu20yO
         PNBLqbks/hFd6HZCMePTkwB6lFCvbg5W8ROSCJLc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 28/63] perf map: Check if the map still has some refcounts on exit
Date:   Thu,  7 Nov 2019 15:59:36 -0300
Message-Id: <20191107190011.23924-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were checking just if it was still on some rb tree, but that is not
the only way that this map can still have references, map->refcnt is
there exactly for this, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hany65tbeavsax7n3xvwl9pc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index eec9b282c047..c9ba49566981 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -288,7 +288,7 @@ bool map__has_symbols(const struct map *map)
 
 static void map__exit(struct map *map)
 {
-	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
+	BUG_ON(refcount_read(&map->refcnt) != 0);
 	dso__zput(map->dso);
 }
 
-- 
2.21.0

