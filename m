Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959CC5C73F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfGBC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfGBC1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64322183F;
        Tue,  2 Jul 2019 02:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034473;
        bh=Z6iYXRsaK5H8nMO3t8V07RZiQG9VlhSFF3Jyaj8HY60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EC8HloqR+rjMwYvunPV0xyEsIHDcFuOaq1DWAiUga0ACxpNAMDGjVvFwAi5q9oP5z
         g2eHDoruMTV6AwG5iPWJsKNsNzO5VC8yFWVzmlnzR4EPdjwtxx8Oyq/3/rlxIo8zvm
         nV84d1tB0WlCXwSZaaK1d7DBnFI0due2GnXi5UJE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 28/43] perf strfilter: Use skip_spaces()
Date:   Mon,  1 Jul 2019 23:26:01 -0300
Message-Id: <20190702022616.1259-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p9rtamq7lvre9zhti70azfwe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strfilter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 2c3a2904ebcd..90ea2b209cbb 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 /* Operators */
 static const char *OP_and	= "&";	/* Logical AND */
@@ -37,8 +38,7 @@ static const char *get_token(const char *s, const char **e)
 {
 	const char *p;
 
-	while (isspace(*s))	/* Skip spaces */
-		s++;
+	s = skip_spaces(s);
 
 	if (*s == '\0') {
 		p = s;
-- 
2.20.1

