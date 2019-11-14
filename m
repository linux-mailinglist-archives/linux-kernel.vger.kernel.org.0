Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BEFB675
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKMRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 12:30:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfKMRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E04425BCBE64080B92D2;
        Thu, 14 Nov 2019 01:30:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 01:30:37 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] sbitmap: Delete sbitmap_any_bit_clear()
Date:   Thu, 14 Nov 2019 01:27:22 +0800
Message-ID: <1573666042-176756-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
References: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the only caller of this function has been deleted, delete this one
also.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/sbitmap.h |  9 ---------
 lib/sbitmap.c           | 17 -----------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index a986ac12a848..e40d019c3d9d 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -216,15 +216,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
  */
 bool sbitmap_any_bit_set(const struct sbitmap *sb);
 
-/**
- * sbitmap_any_bit_clear() - Check for an unset bit in a &struct
- * sbitmap.
- * @sb: Bitmap to check.
- *
- * Return: true if any bit in the bitmap is clear, false otherwise.
- */
-bool sbitmap_any_bit_clear(const struct sbitmap *sb);
-
 #define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
 #define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
 
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 969e5400a615..33feec8989f1 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -236,23 +236,6 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
 }
 EXPORT_SYMBOL_GPL(sbitmap_any_bit_set);
 
-bool sbitmap_any_bit_clear(const struct sbitmap *sb)
-{
-	unsigned int i;
-
-	for (i = 0; i < sb->map_nr; i++) {
-		const struct sbitmap_word *word = &sb->map[i];
-		unsigned long mask = word->word & ~word->cleared;
-		unsigned long ret;
-
-		ret = find_first_zero_bit(&mask, word->depth);
-		if (ret < word->depth)
-			return true;
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
-
 static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 {
 	unsigned int i, weight = 0;
-- 
2.17.1

