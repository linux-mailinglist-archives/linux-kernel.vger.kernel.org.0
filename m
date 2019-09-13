Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2912B20D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391597AbfIMN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:26:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390732AbfIMN0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDFE6308402D;
        Fri, 13 Sep 2019 13:26:51 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56B925C1D4;
        Fri, 13 Sep 2019 13:26:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 73/73] libperf: Add pr_err macro
Date:   Fri, 13 Sep 2019 15:23:55 +0200
Message-Id: <20190913132355.21634-74-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 13 Sep 2019 13:26:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And missing include for "perf/core.h" header, which provides
LIBPERF_* debug levels and adding missing pr_err support.

Link: http://lkml.kernel.org/n/tip-sgq5yeyvitp655s2iq3e75ls@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/core.h | 1 +
 tools/perf/lib/internal.h          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index 2a80e4b6f819..a3f6d68edad7 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -9,6 +9,7 @@
 #endif
 
 enum libperf_print_level {
+	LIBPERF_ERR,
 	LIBPERF_WARN,
 	LIBPERF_INFO,
 	LIBPERF_DEBUG,
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
index 37db745e1502..2c27e158de6b 100644
--- a/tools/perf/lib/internal.h
+++ b/tools/perf/lib/internal.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_H
 #define __LIBPERF_INTERNAL_H
 
+#include <perf/core.h>
+
 void libperf_print(enum libperf_print_level level,
 		   const char *format, ...)
 	__attribute__((format(printf, 2, 3)));
@@ -11,6 +13,7 @@ do {                            \
 	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
 } while (0)
 
+#define pr_err(fmt, ...)        __pr(LIBPERF_ERR, fmt, ##__VA_ARGS__)
 #define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
-- 
2.21.0

