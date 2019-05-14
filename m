Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9611CA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfENOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 10:39:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:51571 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfENOjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:39:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:39:49 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 07:39:48 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf parse-regs: Split parse_regs
Date:   Tue, 14 May 2019 07:39:11 -0700
Message-Id: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The available registers for --int-regs and --user-regs may be different,
e.g. XMM registers.

Split parse_regs into two dedicated functions for --int-regs and
--user-regs respectively.

Modify the warning message. "--user-regs=?" should be applied to show
the available registers for --user-regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c          |  4 ++--
 tools/perf/util/parse-regs-options.c | 19 ++++++++++++++++---
 tools/perf/util/parse-regs-options.h |  3 ++-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 386e665..45172bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2029,10 +2029,10 @@ static struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 9cb187a..b21617f 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -5,8 +5,8 @@
 #include <subcmd/parse-options.h>
 #include "util/parse-regs-options.h"
 
-int
-parse_regs(const struct option *opt, const char *str, int unset)
+static int
+__parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r;
@@ -48,7 +48,8 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
+					    s, intr ? "-I" : "--user-regs=");
 				goto error;
 			}
 
@@ -69,3 +70,15 @@ parse_regs(const struct option *opt, const char *str, int unset)
 	free(os);
 	return ret;
 }
+
+int
+parse_user_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, false);
+}
+
+int
+parse_intr_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, true);
+}
diff --git a/tools/perf/util/parse-regs-options.h b/tools/perf/util/parse-regs-options.h
index cdefb1a..2b23d25 100644
--- a/tools/perf/util/parse-regs-options.h
+++ b/tools/perf/util/parse-regs-options.h
@@ -2,5 +2,6 @@
 #ifndef _PERF_PARSE_REGS_OPTIONS_H
 #define _PERF_PARSE_REGS_OPTIONS_H 1
 struct option;
-int parse_regs(const struct option *opt, const char *str, int unset);
+int parse_user_regs(const struct option *opt, const char *str, int unset);
+int parse_intr_regs(const struct option *opt, const char *str, int unset);
 #endif /* _PERF_PARSE_REGS_OPTIONS_H */
-- 
2.7.4

