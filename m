Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FFD135708
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgAIKgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 05:36:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:57584 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgAIKgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:36:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 02:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="421743348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2020 02:36:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 394D96E; Thu,  9 Jan 2020 12:36:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] lib/test_bitmap: Fix address space when test user buffer
Date:   Thu,  9 Jan 2020 12:36:01 +0200
Message-Id: <20200109103601.45929-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
References: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force address space to avoid the following warning:

lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
lib/test_bitmap.c:461:53:    got char const *in

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 lib/test_bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 707b0389db35..61ed71c1daba 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -458,7 +458,8 @@ static void __init __test_bitmap_parse(int is_user)
 
 			set_fs(KERNEL_DS);
 			time = ktime_get();
-			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
+			err = bitmap_parse_user((__force const char __user *)test.in, len,
+						bmap, test.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
 		} else {
-- 
2.24.1

