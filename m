Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A658E9A194
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfHVVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389857AbfHVVBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:45 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB782341A;
        Thu, 22 Aug 2019 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507704;
        bh=Ye7PKYtmyZq38q8UNQzfDiVzkFBoqzbBSlIjeK4KAUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3wK9ANGivL3T5HOaxuPpDIkAKun6gLxV83C9rCSmoPsubKlLpxJuhJilDsweVGSX
         hqX6GtNjtFMaE6lzgDJsDUVyginF7fZ1hV3rYTe7HVfkA6XBevzobKJ+8ML2b/3NPD
         NDNFA6nNZGtz4RPPmBfmtB95uPXK4ksQyLaGQlNU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/25] perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce include dep tree
Date:   Thu, 22 Aug 2019 18:00:43 -0300
Message-Id: <20190822210100.3461-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All we need in util/evsel.h is the foward declaration of 'struct
xyarray', not the internal/xyarray.h, that can be moved to util/evsel.c
and then we reduce the header dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wwqce6ixwcyq6yzx3ljrdm80@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0a33f7322ecc..477c47c84971 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -39,6 +39,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util/parse-branch-options.h"
+#include <internal/xyarray.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index efe08065838f..2928eee78427 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,7 +8,6 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
-#include <internal/xyarray.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
@@ -93,6 +92,7 @@ enum perf_tool_event {
 };
 
 struct bpf_object;
+struct xyarray;
 
 /** struct evsel - event selector
  *
-- 
2.21.0

