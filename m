Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032AEBBEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 01:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408340AbfIWXdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 19:33:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:40710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408241AbfIWXdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:33:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="179295887"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2019 16:33:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6E896301AF6; Mon, 23 Sep 2019 16:33:45 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf, expr: Remove assert usage
Date:   Mon, 23 Sep 2019 16:33:38 -0700
Message-Id: <20190923233339.25326-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923233339.25326-1-andi@firstfloor.org>
References: <20190923233339.25326-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

My "compile perf statically" setup doesn't like this assert
for unknown reasons. Replace it with a standard BUG_ON

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/expr.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f9a20a39b64a..5086a941295a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -6,7 +6,6 @@
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
-#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -172,7 +171,8 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
 {
 	int idx;
-	assert(ctx->num_ids < MAX_PARSE_ID);
+
+	BUG_ON(ctx->num_ids >= MAX_PARSE_ID);
 	idx = ctx->num_ids++;
 	ctx->ids[idx].name = name;
 	ctx->ids[idx].val = val;
-- 
2.21.0

