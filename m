Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81548BE9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbfIZAgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390054AbfIZAfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:52 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031F1222C6;
        Thu, 26 Sep 2019 00:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458151;
        bh=ygFQJVywddmoGkF8F1DyA4gksT9GLqYvHynj5nofYjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJZmTtnHWYb3oA7sFFd2YczNwvARkOXvmMpv9R55JRy/I/lTgzrtrfGYKDIpaWl2M
         nnC5xptXfmaQRWYbh/2+5w0CVXa4cOOhq8x9TmiYk5iSvz4J6jwz6ukVSLfhLhRKt7
         TgV/aJlpE+HqB3TKaHfUIeWjapaZDuWHLKUsRZSk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 48/66] libperf: Use sys/types.h to get ssize_t, not unistd.h
Date:   Wed, 25 Sep 2019 21:32:26 -0300
Message-Id: <20190926003244.13962-49-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The sys/types.h header looks more sensible, from its name we can gather
it should be there because of some needed typedef, and it is much
smaller than unistd.h, so use it and fix up the fallout in places where
it was being used for something else entirely but being obtained by
sheer luck, indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-49bn251httu22ymwgipeavmy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/lib.h | 2 +-
 tools/perf/util/mmap.c                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
index 9168b7d2a7e1..5175d491b2d4 100644
--- a/tools/perf/lib/include/internal/lib.h
+++ b/tools/perf/lib/include/internal/lib.h
@@ -2,7 +2,7 @@
 #ifndef __LIBPERF_INTERNAL_LIB_H
 #define __LIBPERF_INTERNAL_LIB_H
 
-#include <unistd.h>
+#include <sys/types.h>
 
 extern unsigned int page_size;
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 12671d089748..a35dc57d5995 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h> // sysconf()
 #ifdef HAVE_LIBNUMA_SUPPORT
 #include <numaif.h>
 #endif
-- 
2.21.0

