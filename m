Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656FF5E670
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGCOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:20:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGCOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:20:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EKdW63323631
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:20:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EKdW63323631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163640;
        bh=V88ArdaKmQiuciThqFPoi0Ca4EkeG5dyX7lv+vcl7s4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=eRN9MQfOk5Sjf8WMcTvK/DCNL+lUwtXYeYXf4sma/qU5yoH1f6bwjOGy8aJiwjR2O
         9OZ9HijIjwSaDlh4nAl4Iy1IfcHvAlUTIR5ZmQ8uD4ArXHqkl93euOkq9XQEQLr4Fx
         kMLQ+0CZtPV1mO9oze2pxv3TDhF7bsy9fL0cLVz+c9BcJdWovUWjhgtrsmlsVdm3Go
         LamIkwv7m9XUy2roEXjxW3NZtruoekTN4m/1eDHLuDrbzFqBJfekqkLYQ4HaBnt3cT
         Gd/PmocVz8WmUgZue/fyfUcnG81DjWu8zExf9MfFQnSRc5edusLrxozNdCa3al6Q8X
         rbxGTlg5K5wJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EKdJT3323627;
        Wed, 3 Jul 2019 07:20:39 -0700
Date:   Wed, 3 Jul 2019 07:20:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p9rtamq7lvre9zhti70azfwe@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, mhiramat@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
          mhiramat@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf strfilter: Use skip_spaces()
Git-Commit-ID: c1fc14cbdcc9455507e5f54109199bfea3af185f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c1fc14cbdcc9455507e5f54109199bfea3af185f
Gitweb:     https://git.kernel.org/tip/c1fc14cbdcc9455507e5f54109199bfea3af185f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 11:08:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:31:43 -0300

perf strfilter: Use skip_spaces()

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
