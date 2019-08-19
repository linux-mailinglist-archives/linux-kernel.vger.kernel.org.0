Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40E2951C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfHSXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 19:41:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfHSXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:41:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so1318379plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnYZ9Q3Ni03lDY+Gxs06Jnj2bjWxdv8h8dY+YQg9wa8=;
        b=OLeyKdbpNpyYPM9XgjdRAnfM1bSv+5+iCu31H3+NiWlknEdtqHRCq0QvE55tojq6k6
         kcaGLIU/ljCeqdinyfIg01iman04q3p3hc/6hKNXg6vlDOaoTpzusAkYrVetkbdsHLAK
         dxsabGt3kImG4h/7oXRad4gS80TGmNKo+ew4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnYZ9Q3Ni03lDY+Gxs06Jnj2bjWxdv8h8dY+YQg9wa8=;
        b=NyfKoEZxDRGkWvuUuXB/1+LyUI1XOf3E8lQOSWSA960nDNM5xzD6R39lzKkDa8fIy6
         FAuYr8lg8IACLDhR/gEeNlP4pQjGGxg/YBGv28FgTVuU/uDZ6/P7SJjAonipZYIa2cyC
         UIEnGqC+M76msFRV8d36C7Ef4fpMMAbpwuV3cs0q55NjLzVzgpMl7MpKd5n27m4JpoY8
         mmWCAdpyPZhDUF/nXfqiALXzXavPpdIIZSdx0TBfGoYtZFo1satPUxivOv9E2v/i0b8t
         IbQKRAIG98hq/xk7oUPOcyfuRkJK30H1t9N1uf0BIiJO1SsGaqTYqznMPyS/KqZ55Sz8
         M8Jg==
X-Gm-Message-State: APjAAAUR7QL8fd9CjjY0q03nVuJ+KhNmKCvR2PNaxHycEP+3WI7iH6BD
        +YS+Iz4iJKwrzlR1m1/rKC5ukw==
X-Google-Smtp-Source: APXvYqzibdVDCRWGdmB6uAvlJwHae1zxguoC1fNttlOxomsizUsBxLKEnrgWQDuAiL0Gbk7j5a9VWw==
X-Received: by 2002:a17:902:e68f:: with SMTP id cn15mr5738213plb.212.1566258082196;
        Mon, 19 Aug 2019 16:41:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6sm16830888pfi.12.2019.08.19.16.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Drew Davenport <ddavenport@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] bug: Clean up helper macros to remove __WARN_TAINT()
Date:   Mon, 19 Aug 2019 16:41:09 -0700
Message-Id: <20190819234111.9019-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for cleaning up "cut here" even more, this removes the
__WARN_*TAINT() helpers, as they limit the ability to add new BUGFLAG_*
flags to call sites. They are removed by expanding them into full
__WARN_FLAGS() calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index f76efbcbe3b5..6ea8d258cb96 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -62,13 +62,11 @@ struct bug_entry {
 #endif
 
 #ifdef __WARN_FLAGS
-#define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
-#define __WARN_ONCE_TAINT(taint)	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_TAINT(taint))
-
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_ONCE_TAINT(TAINT_WARN);			\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
 #endif
@@ -89,7 +87,7 @@ struct bug_entry {
  *
  * Use the versions with printk format strings to provide better diagnostics.
  */
-#ifndef __WARN_TAINT
+#ifndef __WARN_FLAGS
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
@@ -99,11 +97,14 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN() do { \
-	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
-} while (0)
-#define __WARN_printf(taint, arg...)					\
-	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
+#define __WARN() do {							\
+		printk(KERN_WARNING CUT_HERE);				\
+		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN));		\
+	} while (0)
+#define __WARN_printf(taint, arg...) do {				\
+		__warn_printk(arg);					\
+		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
+	} while (0)
 #endif
 
 /* used internally by panic.c */
-- 
2.17.1

