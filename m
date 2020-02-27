Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D2171822
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgB0NC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 08:02:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:37336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgB0NC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:02:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AF68B310;
        Thu, 27 Feb 2020 13:02:25 +0000 (UTC)
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
Subject: [PATCH 1/3] lib/test_printf: Clean up test of hashed pointers
Date:   Thu, 27 Feb 2020 14:01:21 +0100
Message-Id: <20200227130123.32442-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200227130123.32442-1-pmladek@suse.com>
References: <20200227130123.32442-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ad67b74d2469d9b82a ("printk: hash addresses printed with %p")
helps to prevent leaking kernel addresses.

The testing of this functionality is a bit problematic because the output
depends on a random key that is generated during boot. Though, it is
still possible to check some aspects:

  + output string length
  + hash differs from the original pointer value
  + top half bits are zeroed on 64-bit systems

This is currently done by a maze of functions:

  + It is hard to follow.
  + Some code is duplicated, e.g. the check for initialized crng.
  + The zeroed top half bits are tested only with one hardcoded PTR.
  + plain() increments "failed_tests" but not "total_tests".
  + The generic test_hashed() does not touch number of tests at all.

Move all the checks into test_hashed() so that they are done for
any given pointer that should get hashed. Also handle test counters
and internal errors the same way as the existing test() function.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 130 ++++++++++++++++++------------------------------------
 1 file changed, 42 insertions(+), 88 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..6fa6fb606554 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -215,29 +215,6 @@ test_string(void)
 #define PTR_VAL_NO_CRNG "(____ptrval____)"
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
-static int __init
-plain_format(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int nchars;
-
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
-
-	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
-			PTR_VAL_NO_CRNG);
-		return 0;
-	}
-
-	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
-		return -1;
-
-	return 0;
-}
-
 #else
 
 #define PTR_WIDTH 8
@@ -246,88 +223,65 @@ plain_format(void)
 #define PTR_VAL_NO_CRNG "(ptrval)"
 #define ZEROS ""
 
-static int __init
-plain_format(void)
-{
-	/* Format is implicitly tested for 32 bit machines by plain_hash() */
-	return 0;
-}
-
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
-plain_hash_to_buffer(const void *p, char *buf, size_t len)
+static void __init
+test_hashed(const char *fmt, const void *p)
 {
+	char real[PLAIN_BUF_SIZE];
+	char hash[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, len, "%p", p);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
+	total_tests++;
 
-	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
-			PTR_VAL_NO_CRNG);
-		return 0;
+	nchars = snprintf(real, sizeof(real), "%px", p);
+	if (nchars != PTR_WIDTH) {
+		pr_err("error in test suite: vsprintf(\"%%px\", p) returned number of characters %d, expected %d\n",
+		       nchars, PTR_WIDTH);
+		goto err;
 	}
 
-	return 0;
-}
-
-static int __init
-plain_hash(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return ret;
-
-	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
-		return -1;
-
-	return 0;
-}
-
-/*
- * We can't use test() to test %p because we don't know what output to expect
- * after an address is hashed.
- */
-static void __init
-plain(void)
-{
-	int err;
+	nchars = snprintf(hash, sizeof(hash), fmt, p);
+	if (nchars != PTR_WIDTH) {
+		pr_warn("vsprintf(\"%s\", p) returned number of characters %d, expected %d\n",
+			fmt, nchars, PTR_WIDTH);
+		goto err;
+	}
 
-	err = plain_hash();
-	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
+	if (strncmp(hash, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
+		pr_warn_once("crng possibly not yet initialized. vsprinf(\"%s\", p) printed \"%s\"",
+			     fmt, hash);
+		total_tests--;
 		return;
 	}
 
-	err = plain_format();
-	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
+	/*
+	 * There is a small chance of a false negative on 32-bit systems
+	 * when the hash is the same as the pointer value.
+	 */
+	if (strncmp(hash, real, PTR_WIDTH) == 0) {
+		pr_warn("vsprintf(\"%s\", p) returned %s, expected hashed pointer\n",
+			fmt, hash);
+		goto err;
+	}
+
+#if BITS_PER_LONG == 64
+	if (strncmp(hash, ZEROS, PTR_WIDTH / 2) != 0) {
+		pr_warn("vsprintf(\"%s\", p) returned %s, expected %s in the top half bits\n",
+			fmt, hash, ZEROS);
+		goto err;
 	}
+#endif
+	return;
+
+err:
+	failed_tests++;
 }
 
 static void __init
-test_hashed(const char *fmt, const void *p)
+plain(void)
 {
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	/*
-	 * No need to increase failed test counter since this is assumed
-	 * to be called after plain().
-	 */
-	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return;
-
-	test(buf, fmt, p);
+	test_hashed("%p", PTR);
 }
 
 static void __init
-- 
2.16.4

