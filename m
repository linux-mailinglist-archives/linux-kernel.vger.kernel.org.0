Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710D4A9880
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 04:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfIECnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 22:43:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfIECnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:43:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8A9C1DB3F159A7D5A6F;
        Thu,  5 Sep 2019 10:43:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 10:42:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: exfat: Use kmemdup in exfat_symlink()
Date:   Thu, 5 Sep 2019 03:00:47 +0000
Message-ID: <20190905030047.88401-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/exfat/exfat_super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b5c2ca8c9aa..05fdecc3e9ea 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2696,12 +2696,11 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
-	EXFAT_I(inode)->target = kmalloc(len+1, GFP_KERNEL);
+	EXFAT_I(inode)->target = kmemdup(target, len + 1, GFP_KERNEL);
 	if (!EXFAT_I(inode)->target) {
 		err = -ENOMEM;
 		goto out;
 	}
-	memcpy(EXFAT_I(inode)->target, target, len+1);
 
 	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	d_instantiate(dentry, inode);



