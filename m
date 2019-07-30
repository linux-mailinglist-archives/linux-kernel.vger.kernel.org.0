Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC87B2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfG3Swl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:52:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbfG3Swk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:52:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIqSaS3336112
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:52:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIqSaS3336112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512749;
        bh=1f5n/1Z+CnkWNcUDbr78PcD0NHTYrXWzmXjuj7ECgpc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zcSe1iPB1Vqp9SgPE7pUooM8OdQGwrzzwD0dKmiBWXqjN2WjvMFSa6t6rXwKtvkWr
         AwCMN4RTrYkxKf2lZAaAtZ3IiTJAfCJmLMOg4rH8ViiNIEfG5o47PmV0TmpTyzk+Eo
         XMvMmzQfMHELeBb1ZIzUASFwpEXNjyTLOD6uTjs83D2KHR//9XvUUGfWtTVXEK5qWN
         W8xVmmQEo2EntL9daJkR9AFzXoJuc221GSahOHlcpPGOmUxRhgAByiKw1WebZCkwJQ
         ypiaLbukv8/mJZLioj5hmM+wyWjVEsl9zMrqVRdOiv5jlZnDxH5jcReGxW+iCk93/u
         RyOFBVpk8qN0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIqSKo3336109;
        Tue, 30 Jul 2019 11:52:28 -0700
Date:   Tue, 30 Jul 2019 11:52:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c03538b1f1a7e0e996a8d6feb20cf001d4b14939@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, acme@redhat.com,
        alexey.budankov@linux.intel.com, peterz@infradead.org,
        mpetlan@redhat.com, ak@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: mpetlan@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          ak@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20190721112506.12306-61-jolsa@kernel.org>
References: <20190721112506.12306-61-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt the readn()/writen() functions from
 tools/perf
Git-Commit-ID: c03538b1f1a7e0e996a8d6feb20cf001d4b14939
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c03538b1f1a7e0e996a8d6feb20cf001d4b14939
Gitweb:     https://git.kernel.org/tip/c03538b1f1a7e0e996a8d6feb20cf001d4b14939
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:47 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt the readn()/writen() functions from tools/perf

Move the readn()/writen() functions into libperf.

Keep those non-namespaced names because they will be shared only between
perf and libperf.

Again, these are not exported functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-61-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                  |  1 +
 tools/perf/lib/include/internal/lib.h | 10 ++++++++
 tools/perf/lib/lib.c                  | 46 +++++++++++++++++++++++++++++++++++
 tools/perf/util/util.c                | 40 ------------------------------
 tools/perf/util/util.h                |  4 +--
 5 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 4f78ec0b4e10..c31f1c111f8f 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -5,6 +5,7 @@ libperf-y += evsel.o
 libperf-y += evlist.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
+libperf-y += lib.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
new file mode 100644
index 000000000000..0b56f1201dc9
--- /dev/null
+++ b/tools/perf/lib/include/internal/lib.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_LIB_H
+#define __LIBPERF_INTERNAL_LIB_H
+
+#include <unistd.h>
+
+ssize_t readn(int fd, void *buf, size_t n);
+ssize_t writen(int fd, const void *buf, size_t n);
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
new file mode 100644
index 000000000000..2a81819c3b8c
--- /dev/null
+++ b/tools/perf/lib/lib.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/kernel.h>
+#include <internal/lib.h>
+
+static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
+{
+	void *buf_start = buf;
+	size_t left = n;
+
+	while (left) {
+		/* buf must be treated as const if !is_read. */
+		ssize_t ret = is_read ? read(fd, buf, left) :
+					write(fd, buf, left);
+
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret;
+
+		left -= ret;
+		buf  += ret;
+	}
+
+	BUG_ON((size_t)(buf - buf_start) != n);
+	return n;
+}
+
+/*
+ * Read exactly 'n' bytes or return an error.
+ */
+ssize_t readn(int fd, void *buf, size_t n)
+{
+	return ion(true, fd, buf, n);
+}
+
+/*
+ * Write exactly 'n' bytes or return an error.
+ */
+ssize_t writen(int fd, const void *buf, size_t n)
+{
+	/* ion does not modify buf. */
+	return ion(false, fd, (void *)buf, n);
+}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index a61535cf1bca..9c3c97697387 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -384,46 +384,6 @@ int copyfile(const char *from, const char *to)
 	return copyfile_mode(from, to, 0755);
 }
 
-static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
-{
-	void *buf_start = buf;
-	size_t left = n;
-
-	while (left) {
-		/* buf must be treated as const if !is_read. */
-		ssize_t ret = is_read ? read(fd, buf, left) :
-					write(fd, buf, left);
-
-		if (ret < 0 && errno == EINTR)
-			continue;
-		if (ret <= 0)
-			return ret;
-
-		left -= ret;
-		buf  += ret;
-	}
-
-	BUG_ON((size_t)(buf - buf_start) != n);
-	return n;
-}
-
-/*
- * Read exactly 'n' bytes or return an error.
- */
-ssize_t readn(int fd, void *buf, size_t n)
-{
-	return ion(true, fd, buf, n);
-}
-
-/*
- * Write exactly 'n' bytes or return an error.
- */
-ssize_t writen(int fd, const void *buf, size_t n)
-{
-	/* ion does not modify buf. */
-	return ion(false, fd, (void *)buf, n);
-}
-
 size_t hex_width(u64 v)
 {
 	size_t n = 1;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc7a469921e9..0dab140c6517 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,7 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
+#include <internal/lib.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -30,9 +31,6 @@ int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
 int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
-ssize_t readn(int fd, void *buf, size_t n);
-ssize_t writen(int fd, const void *buf, size_t n);
-
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
