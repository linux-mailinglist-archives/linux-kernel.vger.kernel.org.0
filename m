Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC795E62B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGCOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:13:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:13:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ECiM23322173
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:12:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ECiM23322173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163165;
        bh=aMT/e5R01H3bvO3WVrG4hHVXOaRtBA28lRKegYW23Yg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=GXeGwJmhQykjrG5QYp3SPynDf8/a8Hl3kNZ4iB0WVx3kXpGX40yd9V7KcehjELgdd
         mTdjT4LJPGLVHJLXknBbiMvvq6KqFfAkqAv//HiTgS6gnWqSl143P9Wec9zgzG2Got
         fAxlEXaZzdVe1J/Bm4DEX3yU9hNrzsQnOpWOYnByOlOOFEQ5Pf+GseGpEhjE/kNS02
         ICppI42CQn5z+nft3NaTPE4wEIyaRx4Jhpn0hO3HhhAECi2oxFYIA7FgzhRiOD+b4v
         4aW1OVIZifQ2pqRzCfCp1ljdc9HoAtSZS2wY9pfQdlP1xxA0Uu5fjJCa28D7J5ogsC
         x2gMgQd4xEUyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EChUa3322170;
        Wed, 3 Jul 2019 07:12:43 -0700
Date:   Wed, 3 Jul 2019 07:12:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5mc1zg0jqdwgkn8c358kaba6@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kallsyms: Adopt hex2u64 from
 tools/perf/util/util.h
Git-Commit-ID: 155681fcd7f82882a730240c2dde7eee76a46314
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

Commit-ID:  155681fcd7f82882a730240c2dde7eee76a46314
Gitweb:     https://git.kernel.org/tip/155681fcd7f82882a730240c2dde7eee76a46314
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 18:13:17 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 18:13:17 -0300

perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h

Just removing more stuff from tools/perf/, this is mostly used in the
kallsyms parsing and in places in perf where kallsyms is involved, so we
get it for free there.

With this we reduce a bit more util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5mc1zg0jqdwgkn8c358kaba6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 13 +++++++++++++
 tools/lib/symbol/kallsyms.h |  2 ++
 tools/perf/util/util.c      | 13 -------------
 tools/perf/util/util.h      |  1 -
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 96d830545bbb..7501611abee4 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -16,6 +16,19 @@ bool kallsyms__is_function(char symbol_type)
 	return symbol_type == 'T' || symbol_type == 'W';
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 72ab9870454b..bd988f7b18d4 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,6 +18,8 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
+int hex2u64(const char *ptr, u64 *long_val);
+
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index d388f80d8703..a61535cf1bca 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -434,19 +434,6 @@ size_t hex_width(u64 v)
 	return n;
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
-{
-	char *p;
-
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
-}
-
 int perf_event_paranoid(void)
 {
 	int value;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 09c1b0f91f65..125e215dd3d8 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -43,7 +43,6 @@ ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
 size_t hex_width(u64 v);
-int hex2u64(const char *ptr, u64 *val);
 
 extern unsigned int page_size;
 int __pure cacheline_size(void);
