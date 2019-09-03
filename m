Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC634A61AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfICGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 02:42:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfICGmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:42:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFC12872195C1A84D3AA;
        Tue,  3 Sep 2019 14:42:44 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 14:42:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <me@bobcopeland.com>
CC:     <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-karma-devel@lists.sourceforge.net>
Subject: [PATCH] fs: omfs: Use kmemdup rather than duplicating its implementation in omfs_get_imap
Date:   Tue, 3 Sep 2019 14:39:44 +0800
Message-ID: <1567492784-19304-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup contains the kmalloc + memcpy. hence it is better to use kmemdup
directly. Just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index b76ec6b..8867cef 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
1.7.12.4

