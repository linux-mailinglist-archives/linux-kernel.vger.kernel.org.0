Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDB168A51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 00:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgBUXTt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Feb 2020 18:19:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgBUXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:19:48 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-1jQvQluMPwOkZT2ctSE-7A-1; Fri, 21 Feb 2020 18:19:45 -0500
X-MC-Unique: 1jQvQluMPwOkZT2ctSE-7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6E41084430;
        Fri, 21 Feb 2020 23:19:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3646160499;
        Fri, 21 Feb 2020 23:19:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/4] perf expr: Add expr.c object
Date:   Sat, 22 Feb 2020 00:19:32 +0100
Message-Id: <20200221231935.735145-2-jolsa@kernel.org>
In-Reply-To: <20200221231935.735145-1-jolsa@kernel.org>
References: <20200221231935.735145-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic expr code into new expr.c object.

The expr.c object will be mainly used in following
change that will get rid of the manual flex code,

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/Build  |  1 +
 tools/perf/util/expr.c | 20 ++++++++++++++++++++
 tools/perf/util/expr.y | 16 ----------------
 3 files changed, 21 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/util/expr.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 07da6c790b63..6fdf073093a6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,6 +122,7 @@ perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
 perf-y += expr-bison.o
+perf-y += expr.o
 perf-y += branch.o
 perf-y += mem2node.o
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
new file mode 100644
index 000000000000..4a82ff3bdbcc
--- /dev/null
+++ b/tools/perf/util/expr.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include "expr.h"
+
+/* Caller must make sure id is allocated */
+void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
+{
+	int idx;
+
+	assert(ctx->num_ids < MAX_PARSE_ID);
+	idx = ctx->num_ids++;
+	ctx->ids[idx].name = name;
+	ctx->ids[idx].val = val;
+}
+
+void expr__ctx_init(struct parse_ctx *ctx)
+{
+	ctx->num_ids = 0;
+}
+
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7d226241f1d7..7cea8b7c3a5c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -6,7 +6,6 @@
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
-#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -169,21 +168,6 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 	return tok;
 }
 
-/* Caller must make sure id is allocated */
-void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
-{
-	int idx;
-	assert(ctx->num_ids < MAX_PARSE_ID);
-	idx = ctx->num_ids++;
-	ctx->ids[idx].name = name;
-	ctx->ids[idx].val = val;
-}
-
-void expr__ctx_init(struct parse_ctx *ctx)
-{
-	ctx->num_ids = 0;
-}
-
 static bool already_seen(const char *val, const char *one, const char **other,
 			 int num_other)
 {
-- 
2.24.1

