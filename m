Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9DA2D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 05:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3Dho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 23:37:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfH3Dhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:37:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04FA0AE93D6D41465E28;
        Fri, 30 Aug 2019 11:37:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:37:33 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 4/7] erofs: kill __packed for on-disk structures
Date:   Fri, 30 Aug 2019 11:36:40 +0800
Message-ID: <20190830033643.51019-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830033643.51019-1-gaoxiang25@huawei.com>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Christoph claimed "Please don't add __packed" [1],
I have to remove all __packed except struct erofs_dirent here.

Note that all on-disk fields except struct erofs_dirent
(12 bytes with a 8-byte nid) in EROFS are naturally aligned.

[1] https://lore.kernel.org/lkml/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
no change.

 fs/erofs/erofs_fs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index fbdaf873d736..b07984a17f11 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -37,7 +37,7 @@ struct erofs_super_block {	/* off description */
 	__le32 requirements;	/* 80  (aka. feature_incompat) */
 
 	__u8 reserved2[44];	/* 84 */
-} __packed;			/* 128 bytes */
+};				/* 128 bytes */
 
 /*
  * erofs inode data mapping:
@@ -89,12 +89,12 @@ struct erofs_inode_v1 {		/* off description */
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
+	} i_u;
 	__le32 i_ino;		/* 20 only used for 32-bit stat compatibility */
 	__le16 i_uid;		/* 24 */
 	__le16 i_gid;		/* 26 */
 	__le32 i_reserved2;	/* 28 */
-} __packed;			/* 32 bytes */
+};				/* 32 bytes */
 
 /* 32 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V1   0
@@ -116,7 +116,7 @@ struct erofs_inode_v2 {		/* off description */
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
+	} i_u;
 
 	/* only used for 32-bit stat compatibility */
 	__le32 i_ino;		/* 20 only used for 32-bit stat compatibility */
@@ -127,7 +127,7 @@ struct erofs_inode_v2 {		/* off description */
 	__le32 i_ctime_nsec;	/* 40 */
 	__le32 i_nlink;		/* 44 */
 	__u8   i_reserved2[16];	/* 48 */
-} __packed;			/* 64 bytes */
+};				/* 64 bytes */
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -149,7 +149,7 @@ struct erofs_xattr_ibody_header {
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
-} __packed;
+};
 
 /* Name indexes */
 #define EROFS_XATTR_INDEX_USER              1
@@ -166,7 +166,7 @@ struct erofs_xattr_entry {
 	__le16 e_value_size;    /* size of attribute value */
 	/* followed by e_name and e_value */
 	char   e_name[0];       /* attribute name */
-} __packed;
+};
 
 static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
 {
@@ -272,8 +272,8 @@ struct z_erofs_vle_decompressed_index {
 		 * [1] - pointing to the tail cluster
 		 */
 		__le16 delta[2];
-	} di_u __packed;		/* 8 bytes */
-} __packed;
+	} di_u;			/* 8 bytes */
+};
 
 #define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
 	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-- 
2.17.1

