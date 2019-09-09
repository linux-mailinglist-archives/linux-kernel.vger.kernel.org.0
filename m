Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0442AD238
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 05:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfIIDdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 23:33:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39591 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbfIIDdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so9275778lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6CTmyF8aBfZbpijYEnurX2JXQCdlqwHPyDFUxp7uk8=;
        b=iVcBCFIYuRxgyy4vx7972/+A+Q5uyFhpMFN2xj0VDNJ9BnoKdgmaVIqIECmMmHVgxO
         J9VYSsYWlYTL8//pPiX0caMC0GvfNXOExdsHYVAOjYB2C9gAL8oTcBe+D2357oP1kX5G
         UC1fUmqiLTbc+BR+g8YSuTqJt0UtG5DsJF+AivYqkzsszBuHQEcQdIrybykrwFTNLpkK
         GEih0MzWwK3z+Igrh8ZYZorgBE45Esl7+2XJbS5D4XL39evb/yN93cslO3VXUZtmWHP3
         448im3jGvPKOelmj77CN8a0yx3qjW3jmWwVP5sPcyiCsjnoiBgIa3uoRdygd2OfuvkUg
         pwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6CTmyF8aBfZbpijYEnurX2JXQCdlqwHPyDFUxp7uk8=;
        b=PYm+AAwlj6Gs/fsxRrDCr6agJfUGP2hotA1HCgmP4SyhmvB7KCGLD5ERzUtqWAf6t1
         jSpEGT8BUb2nleWMxbUE8Ge2+X12/sTH4ZlrwWVGUC2RuGEpZcKK4/UiYxvK9lEzhmp3
         q5k/4Q5seL7N36+tFpmVmHmAE9u7KfQtTVOhoPux5pZ1Xbj8gtjdWYraA2gCivm2pWx+
         vyVLHCHCzG12N9MO2PWAqHvexMnLpewVbgKwjVPL6TLF5bYpMu5KaRot5gye/g5CwaKT
         qiWVD7SV7kjlEP8R4WhBBz9nS+vRDfoEDkzvqmmc09mdVIoArBmpwvjnynT9XXOpZZJ9
         Qupg==
X-Gm-Message-State: APjAAAUkTKFlZsKQfKtRTcNKLXpYtdJcAX+C1SgCVdvWOO3okWPnztFO
        +zm+sX4XQqi6I5TO1NfzM7s=
X-Google-Smtp-Source: APXvYqwZWL2wBgM0k1DeWa+gJ1ehWCOkdn72od/xtZbiAOfmg5s7/BSPNWAWcIzVttn+bTekjbqnWg==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr14889756lfp.21.1567999993506;
        Sun, 08 Sep 2019 20:33:13 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 3/7] lib: add test for bitmap_parse()
Date:   Sun,  8 Sep 2019 20:30:17 -0700
Message-Id: <20190909033021.11600-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test is derived from bitmap_parselist()
NO_LEN is reserved for use in following patches.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 51a98f7ee79e6..e306d3da12019 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -206,7 +206,8 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
-#define PARSE_TIME 0x1
+#define PARSE_TIME	0x1
+#define NO_LEN		0x2
 
 struct test_bitmap_parselist{
 	const int errno;
@@ -329,6 +330,85 @@ static void __init __test_bitmap_parselist(int is_user)
 	}
 }
 
+static const unsigned long parse_test[] __initconst = {
+	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(1),
+	BITMAP_FROM_U64(0xdeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL),
+};
+
+static const unsigned long parse_test2[] __initconst = {
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xdeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xbaadf00ddeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0x0badf00ddeadbeef),
+};
+
+static const struct test_bitmap_parselist parse_tests[] __initconst = {
+	{0, "0",			&parse_test[0 * step], 32, 0},
+	{0, "1",			&parse_test[1 * step], 32, 0},
+	{0, "deadbeef",			&parse_test[2 * step], 32, 0},
+	{0, "1,0",			&parse_test[3 * step], 33, 0},
+
+	{0, "deadbeef,1,0",		&parse_test2[0 * 2 * step], 96, 0},
+	{0, "baadf00d,deadbeef,1,0",	&parse_test2[1 * 2 * step], 128, 0},
+	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, 0},
+
+	{-EINVAL,    "goodfood,deadbeef,1,0",	NULL, 128, 0},
+	{-EOVERFLOW, "3,0",			NULL, 33, 0},
+	{-EOVERFLOW, "123badf00d,deadbeef,1,0",	NULL, 128, 0},
+	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 90, 0},
+	{-EOVERFLOW, "fbadf00d,deadbeef,1,0",	NULL, 95, 0},
+	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 100, 0},
+};
+
+static void __init __test_bitmap_parse(int is_user)
+{
+	int i;
+	int err;
+	ktime_t time;
+	DECLARE_BITMAP(bmap, 2048);
+	char *mode = is_user ? "_user"  : "";
+
+	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
+		struct test_bitmap_parselist test = parse_tests[i];
+
+		if (is_user) {
+			size_t len = strlen(test.in);
+			mm_segment_t orig_fs = get_fs();
+
+			set_fs(KERNEL_DS);
+			time = ktime_get();
+			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
+			time = ktime_get() - time;
+			set_fs(orig_fs);
+		} else {
+			size_t len = test.flags & NO_LEN ?
+				UINT_MAX : strlen(test.in);
+			time = ktime_get();
+			err = bitmap_parse(test.in, len, bmap, test.nbits);
+			time = ktime_get() - time;
+		}
+
+		if (err != test.errno) {
+			pr_err("parse%s: %d: input is %s, errno is %d, expected %d\n",
+					mode, i, test.in, err, test.errno);
+			continue;
+		}
+
+		if (!err && test.expected
+			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
+			pr_err("parse%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					mode, i, test.in, bmap[0],
+					*test.expected);
+			continue;
+		}
+
+		if (test.flags & PARSE_TIME)
+			pr_err("parse%s: %d: input is '%s' OK, Time: %llu\n",
+					mode, i, test.in, time);
+	}
+}
+
 static void __init test_bitmap_parselist(void)
 {
 	__test_bitmap_parselist(0);
@@ -339,6 +419,16 @@ static void __init test_bitmap_parselist_user(void)
 	__test_bitmap_parselist(1);
 }
 
+static void __init test_bitmap_parse(void)
+{
+	__test_bitmap_parse(0);
+}
+
+static void __init test_bitmap_parse_user(void)
+{
+	__test_bitmap_parse(1);
+}
+
 #define EXP_BYTES	(sizeof(exp) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -410,6 +500,8 @@ static void __init selftest(void)
 	test_fill_set();
 	test_copy();
 	test_bitmap_arr32();
+	test_bitmap_parse();
+	test_bitmap_parse_user();
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
-- 
2.20.1

