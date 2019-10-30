Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4718DE9D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfJ3OOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:14:32 -0400
Received: from out28-1.mail.aliyun.com ([115.124.28.1]:40440 "EHLO
        out28-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJ3OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:14:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.126954|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.447419-0.0048505-0.54773;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.FsafdIU_1572444865;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.FsafdIU_1572444865)
          by smtp.aliyun-inc.com(10.194.99.21);
          Wed, 30 Oct 2019 22:14:25 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-kernel@vger.kernel.org
Cc:     liuxiang_1999@126.com
Subject: [PATCH] lib: string: reduce unnecessary loop in strncpy
Date:   Wed, 30 Oct 2019 22:14:19 +0800
Message-Id: <1572444859-3687-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in strncpy, even src[0] is 0, loop will execute count times until
count is 0. It is better to exit the loop immediately when *src is 0.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
---
 lib/string.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 08ec58c..1065352 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -115,12 +115,8 @@ char *strncpy(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 
-	while (count) {
-		if ((*tmp = *src) != 0)
-			src++;
-		tmp++;
-		count--;
-	}
+	while (count-- && (*tmp++ = *src++) != '\0')
+		; /* nothing */
 	return dest;
 }
 EXPORT_SYMBOL(strncpy);
-- 
1.9.1

