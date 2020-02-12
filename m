Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16C15A55F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 10:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgBLJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 04:54:28 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:48218 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgBLJy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:54:28 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 84F9D3F3C3D7BE5FFB11;
        Wed, 12 Feb 2020 17:54:23 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 01C9ruoZ089308;
        Wed, 12 Feb 2020 17:53:56 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020021217541684-2102563 ;
          Wed, 12 Feb 2020 17:54:16 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     aryabinin@virtuozzo.com
Cc:     glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] lib: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.
Date:   Wed, 12 Feb 2020 17:53:48 +0800
Message-Id: <1581501228-5393-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-02-12 17:54:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-02-12 17:53:59,
        Serialize complete at 2020-02-12 17:53:59
X-MAIL: mse-fl2.zte.com.cn 01C9ruoZ089308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

Use kzalloc instead of manually setting kmalloc
with flag GFP_ZERO since kzalloc sets allocated memory
to zero.

Change in v2:
    add indation

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 lib/test_kasan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 328d33b..79be158 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -599,7 +599,7 @@ static noinline void __init kasan_memchr(void)
 	size_t size = 24;
 
 	pr_info("out-of-bounds in memchr\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	ptr = kzalloc(size, GFP_KERNEL);
 	if (!ptr)
 		return;
 
@@ -614,7 +614,7 @@ static noinline void __init kasan_memcmp(void)
 	int arr[9];
 
 	pr_info("out-of-bounds in memcmp\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	ptr = kzalloc(size, GFP_KERNEL);
 	if (!ptr)
 		return;
 
@@ -629,7 +629,7 @@ static noinline void __init kasan_strings(void)
 	size_t size = 24;
 
 	pr_info("use-after-free in strchr\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	ptr = kzalloc(size, GFP_KERNEL);
 	if (!ptr)
 		return;
 
-- 
1.9.1

