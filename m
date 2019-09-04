Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F26A7FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfIDKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:06:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfIDKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:06:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7F48FD5C2E9101ECC8A;
        Wed,  4 Sep 2019 18:06:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 18:06:22 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] staging: exfat: remove the redundant check when kfree an object in exfat_destroy_inode
Date:   Wed, 4 Sep 2019 18:03:28 +0800
Message-ID: <1567591408-24268-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken the null check in account. hence it is unnecessary to add the
null check before kfree the object. Just remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/exfat/exfat_super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b5c2ca..87f858b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -3487,8 +3487,7 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 
 static void exfat_destroy_inode(struct inode *inode)
 {
-	if (EXFAT_I(inode)->target)
-		kfree(EXFAT_I(inode)->target);
+	kfree(EXFAT_I(inode)->target);
 	EXFAT_I(inode)->target = NULL;
 
 	kmem_cache_free(exfat_inode_cachep, EXFAT_I(inode));
-- 
1.7.12.4

