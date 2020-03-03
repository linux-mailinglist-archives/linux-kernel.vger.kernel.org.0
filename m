Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881F6177270
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgCCJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:33:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728176AbgCCJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:33:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A86E17559CD094A3360F;
        Tue,  3 Mar 2020 17:33:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 17:33:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ubifs: ubifs_add_orphan: Fix a memory leak bug
Date:   Tue, 3 Mar 2020 17:40:23 +0800
Message-ID: <1583228423-60816-3-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
References: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory leak occurs when files with extended attributes are added to
orphan list.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Fixes: 988bec41318f3fa897e2f8("ubifs: orphan: Handle xattrs like files")
---
 fs/ubifs/orphan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index edf43ddd7dce..c769bf67e526 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -157,7 +157,7 @@ int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
 	int err = 0;
 	ino_t xattr_inum;
 	union ubifs_key key;
-	struct ubifs_dent_node *xent;
+	struct ubifs_dent_node *xent, *pxent = NULL;
 	struct fscrypt_name nm = {0};
 	struct ubifs_orphan *xattr_orphan;
 	struct ubifs_orphan *orphan;
@@ -181,11 +181,16 @@ int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
 		xattr_inum = le64_to_cpu(xent->inum);
 
 		xattr_orphan = orphan_add(c, xattr_inum, orphan);
-		if (IS_ERR(xattr_orphan))
+		if (IS_ERR(xattr_orphan)) {
+			kfree(xent);
 			return PTR_ERR(xattr_orphan);
+		}
 
+		kfree(pxent);
+		pxent = xent;
 		key_read(c, &xent->key, &key);
 	}
+	kfree(pxent);
 
 	return 0;
 }
-- 
2.7.4

