Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7F5E680
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGCOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:23:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49583 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGCOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:23:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ENVD83324154
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:23:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ENVD83324154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163812;
        bh=/DoBYAtB59fvw2q1l/xyDhQsYaKOSm22BhJGjpud6U8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=KAPJqVsfuGUadjMrhcfqjdJnC32SHQlcrLZqBcwzllXxE9Qp/ysb+XFDAyej1ueeF
         8AUxxaK2e/yrrbXrWUXCRq+56BfjRMmGWhLlouGf6cGim/YEH2fbDm5J4UPRGBSvyI
         tj0Rha6pjV4YeDeHEq/Y2KvsZwCDy1RnP1BUwF2Jk+Rjgn5MFsZ9E2BVuuQER0xJLm
         WS1fH+Umb+2k+TsAXtDP6S+ohci8REANB979JhnOttDYyuUXqBRFR0czUblhSW45l0
         iPZV2JbxM0PEKnFzefYb4zVIkwRorPbF8vEaJoQMUty/uv56cZT8Fk5hJV5M+tXTcF
         PpO1Att1kE/MQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ENUCd3324150;
        Wed, 3 Jul 2019 07:23:30 -0700
Date:   Wed, 3 Jul 2019 07:23:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zqy1zdu2ok17qvi0ytk8z13c@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, andre.goddard@gmail.com, namhyung@kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, andre.goddard@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib: Adopt strim() from the kernel
Git-Commit-ID: 45bfd0ac7bd2afa83600df9c1286a1642bb15c55
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  45bfd0ac7bd2afa83600df9c1286a1642bb15c55
Gitweb:     https://git.kernel.org/tip/45bfd0ac7bd2afa83600df9c1286a1642bb15c55
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 11:50:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:50:16 -0300

tools lib: Adopt strim() from the kernel

Since we're working on moving stuff out of tools/perf/util/ to
tools/lib/, take the opportunity to adopt routines from the kernel that
are equivalent, so that tools/ code look more like the kernel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zqy1zdu2ok17qvi0ytk8z13c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index cee239350a6b..e436f8037c87 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -31,4 +31,6 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 extern char * __must_check skip_spaces(const char *);
 
+extern char *strim(char *);
+
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 50d400822bb3..80472e6b3829 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -120,3 +120,28 @@ char *skip_spaces(const char *str)
 		++str;
 	return (char *)str;
 }
+
+/**
+ * strim - Removes leading and trailing whitespace from @s.
+ * @s: The string to be stripped.
+ *
+ * Note that the first trailing whitespace is replaced with a %NUL-terminator
+ * in the given string @s. Returns a pointer to the first non-whitespace
+ * character in @s.
+ */
+char *strim(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end >= s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	return skip_spaces(s);
+}
