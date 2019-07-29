Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DB7855B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfG2Gwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:52:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfG2Gwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43E344C4AB38D58BBAB4;
        Mon, 29 Jul 2019 14:52:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:30 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 15/22] staging: erofs: remove redundant braces in inode.c
Date:   Mon, 29 Jul 2019 14:51:52 +0800
Message-ID: <20190729065159.62378-16-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant braces in inode.c since
these are all single statements.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index c13d66ccc74a..286729143365 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -35,16 +35,15 @@ static int read_inode(struct inode *inode, void *data)
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
 		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode)) {
+		    S_ISLNK(inode->i_mode))
 			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
-		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 			inode->i_rdev =
 				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
-		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
 			inode->i_rdev = 0;
-		} else {
+		else
 			return -EIO;
-		}
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
@@ -69,16 +68,15 @@ static int read_inode(struct inode *inode, void *data)
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
 		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode)) {
+		    S_ISLNK(inode->i_mode))
 			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
-		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 			inode->i_rdev =
 				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
 			inode->i_rdev = 0;
-		} else {
+		else
 			return -EIO;
-		}
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
-- 
2.17.1

