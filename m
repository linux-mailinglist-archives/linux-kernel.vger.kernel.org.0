Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF34F418
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 02:50:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFVGuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:50:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6o5Rd2010105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:50:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6o5Rd2010105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186205;
        bh=12WzQpl+3yaZDsqnbr9SxmxBtqCvsJrX+KM02H/P8CM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HZF+CWkZc2mN7ndTo1uL8WzraIz3LANewjsMXed6iBiLHtfgCBtoxM7EdvTupDpgc
         QnowWmAi7M3FEayGDyWJ2aJcFVT5n67oNVn6kLmkJXCCqOVgQvZpIcI48CJsaHiaHh
         2Sl6opA/owTPH4hjM0tEN/6W9LQ7auRdLMSgpYkfzsaJhac1hb6rQO+l37zNkOk+BX
         y+FELbu0rpWndt2ua9yLzIr4OJivF9HeOOInQEfNHKevaV6cDt50XpzL221L/QvVge
         /aAJrNxDg2tot56rujyqhhrDo25+QYbWEPjYWUHOPZQavM/qCD3fhmxr2iqRCPo9Yb
         hgiqtWDL2aVjg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6o5fH2010099;
        Fri, 21 Jun 2019 23:50:05 -0700
Date:   Fri, 21 Jun 2019 23:50:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2sy7hbwkx68jr6n97qxgg0c6@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, f.fainelli@gmail.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
          mingo@kernel.org, f.fainelli@gmail.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build: Add test to check if slang.h is in
 /usr/include/slang/
Git-Commit-ID: cbefd24f0aee3a5d787a013f207f6fd31d3c76d2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cbefd24f0aee3a5d787a013f207f6fd31d3c76d2
Gitweb:     https://git.kernel.org/tip/cbefd24f0aee3a5d787a013f207f6fd31d3c76d2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Jun 2019 17:43:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Jun 2019 17:43:35 -0300

tools build: Add test to check if slang.h is in /usr/include/slang/

A few odd old distros (rhel5, 6, yeah, lots of those out in use, in many
cases we want to use upstream perf on it) have the slang header files in
/usr/include/slang/, so add a test that will be performed only when
test-all.c (the one with the most common sane settings) fails, either
because we're in one of these odd distros with slang/slang.h or because
something else failed (say libelf is not present).

So for the common case nothing changes, no additional test is performed.

Next step is to check in perf the result of these tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Link: https://lkml.kernel.org/n/tip-2sy7hbwkx68jr6n97qxgg0c6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                                          | 2 +-
 tools/build/feature/Makefile                                          | 4 ++++
 .../build/feature/{test-libslang.c => test-libslang-include-subdir.c} | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 50377cc2f5f9..86b793dffbc4 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libpython-version               \
         libslang                        \
+        libslang-include-subdir         \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
@@ -114,7 +115,6 @@ FEATURE_DISPLAY ?=              \
          numa_num_possible_cpus \
          libperl                \
          libpython              \
-         libslang               \
          libcrypto              \
          libunwind              \
          libdw-dwarf-unwind     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ef7cf04a292..0658b8cd0e53 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -31,6 +31,7 @@ FILES=                                          \
          test-libpython.bin                     \
          test-libpython-version.bin             \
          test-libslang.bin                      \
+         test-libslang-include-subdir.bin       \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -184,6 +185,9 @@ $(OUTPUT)test-libaudit.bin:
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
+$(OUTPUT)test-libslang-include-subdir.bin:
+	$(BUILD) -lslang
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/build/feature/test-libslang.c b/tools/build/feature/test-libslang-include-subdir.c
similarity index 76%
copy from tools/build/feature/test-libslang.c
copy to tools/build/feature/test-libslang-include-subdir.c
index 9cbff8d1df53..3ea47ec7590e 100644
--- a/tools/build/feature/test-libslang.c
+++ b/tools/build/feature/test-libslang-include-subdir.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <slang.h>
+#include <slang/slang.h>
 
 int main(void)
 {
