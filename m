Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95888171824
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 14:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgB0NCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 08:02:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:37394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgB0NCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:02:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CB9CB30E;
        Thu, 27 Feb 2020 13:02:28 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] lib/test_printf: Clean up invalid pointer value testing
Date:   Thu, 27 Feb 2020 14:01:23 +0100
Message-Id: <20200227130123.32442-4-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200227130123.32442-1-pmladek@suse.com>
References: <20200227130123.32442-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_INVALID is a confusing name. It might mean any pointer value
that is not accessible. But check_pointer() function is able to
detect only the obviously invalid pointers: NULL pointer,
IS_ERR() range, and the first page.

Check all these three categories by better named values.

Use PTR_STR prefix for all expected output, including
the string used when crng has not been initialized yet.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 1ee1bb703307..d640be78e3ae 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -206,13 +206,18 @@ test_string(void)
 }
 
 #define PLAIN_BUF_SIZE 64	/* leave some space so we don't oops */
+#define PTR_FIRST_PAGE ((void *)0x000000ab)
+#define PTR_STR_FIRST_PAGE "000000ab"
+#define PTR_ERROR ERR_PTR(-EFAULT)
+#define PTR_STR_ERROR "fffffff2"
 
 #if BITS_PER_LONG == 64
 
 #define PTR_WIDTH 16
 #define PTR ((void *)0xffff0123456789abUL)
 #define PTR_STR "ffff0123456789ab"
-#define PTR_VAL_NO_CRNG "(____ptrval____)"
+#define PTR_STR_NO_CRNG "(____ptrval____)"
+#define ONES "ffffffff"		/* hex 32 one bits */
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
 #else
@@ -220,7 +225,8 @@ test_string(void)
 #define PTR_WIDTH 8
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
-#define PTR_VAL_NO_CRNG "(ptrval)"
+#define PTR_STR_NO_CRNG "(ptrval)"
+#define ONES ""
 #define ZEROS ""
 
 #endif	/* BITS_PER_LONG == 64 */
@@ -248,7 +254,7 @@ test_hashed(const char *fmt, const void *p)
 		goto err;
 	}
 
-	if (strncmp(hash, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
+	if (strncmp(hash, PTR_STR_NO_CRNG, PTR_WIDTH) == 0) {
 		pr_warn_once("crng possibly not yet initialized. vsprinf(\"%s\", p) printed \"%s\"",
 			     fmt, hash);
 		total_tests--;
@@ -278,22 +284,22 @@ test_hashed(const char *fmt, const void *p)
 	failed_tests++;
 }
 
-#define PTR_INVALID ((void *)0x000000ab)
-
 static void __init
 plain_pointer(void)
 {
 	test_hashed("%p", PTR);
 	test_hashed("%p", NULL);
-	test_hashed("%p", PTR_INVALID);
+	test_hashed("%p", PTR_ERROR);
+	test_hashed("%p", PTR_FIRST_PAGE);
 }
 
 static void __init
 real_pointer(void)
 {
 	test(PTR_STR, "%px", PTR);
-	test(ZEROS "00000000", "%px", NULL);
-	test(ZEROS "000000ab", "%px", PTR_INVALID);
+	test(ZEROS ZEROS, "%px", NULL);
+	test(ONES PTR_STR_ERROR, "%px", PTR_ERROR);
+	test(ZEROS PTR_STR_FIRST_PAGE, "%px", PTR_FIRST_PAGE);
 }
 
 static void __init
@@ -321,7 +327,8 @@ static void __init
 escaped_str(void)
 {
 	test("(null)", "%pE", NULL);
-	test("(efault)", "%pE", PTR_INVALID);
+	test("(efault)", "%pE", PTR_ERROR);
+	test("(efault)", "%pE", PTR_FIRST_PAGE);
 }
 
 static void __init
@@ -408,9 +415,11 @@ dentry(void)
 	test("foo", "%pd2", &test_dentry[0]);
 
 	test("(null)", "%pd", NULL);
-	test("(efault)", "%pd", PTR_INVALID);
+	test("(efault)", "%pd", PTR_ERROR);
+	test("(efault)", "%pd", PTR_FIRST_PAGE);
 	test("(null)", "%pD", NULL);
-	test("(efault)", "%pD", PTR_INVALID);
+	test("(efault)", "%pD", PTR_ERROR);
+	test("(efault)", "%pD", PTR_FIRST_PAGE);
 
 	test("romeo", "%pd", &test_dentry[3]);
 	test("alfa/romeo", "%pd2", &test_dentry[3]);
-- 
2.16.4

