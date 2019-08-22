Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5862E9A19E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393489AbfHVVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfHVVCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:23 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B029623405;
        Thu, 22 Aug 2019 21:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507742;
        bh=E+2BgSKwZ23cH6WjngXRUllFEJ5++RR5H3ZwXan/cu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4njaB6owL22o3JH6zNyTCYGwNsM9sX5XbgCflcRnVBB05y/+GHEfe0IVLRAFzR4Y
         IFJJUlb9g/GdufFdLjPpavcbxf/qeiXk1lNvIUYMSTL5XxiiJluZ9DoV14cFxTzxF7
         fcwo9wNft4Go4L1znehN4SFyoOYZjyYMwdlEsA7k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/25] perf evsel: Remove needless counts.h header from util/evsel.h
Date:   Thu, 22 Aug 2019 18:00:52 -0300
Message-Id: <20190822210100.3461-18-acme@kernel.org>
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

We need only a struct forward declaration, so prune the header
dependency tree a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-oqvgf04w4ku8xasrz79zquim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 477c47c84971..7b4350681d64 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -26,6 +26,7 @@
 #include "asm/bug.h"
 #include "callchain.h"
 #include "cgroup.h"
+#include "counts.h"
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index da91d6f57f44..296390541030 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -11,7 +11,6 @@
 #include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
-#include "counts.h"
 
 struct evsel;
 
@@ -93,6 +92,7 @@ enum perf_tool_event {
 };
 
 struct bpf_object;
+struct perf_counts;
 struct xyarray;
 
 /** struct evsel - event selector
-- 
2.21.0

