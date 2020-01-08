Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6581134050
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgAHLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:21:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbgAHLVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:21:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E1441D60C144FDC3B04F;
        Wed,  8 Jan 2020 19:21:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 19:20:59 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <me@bobcopeland.com>
CC:     <linux-karma-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH] fs: omfs: use kmemdup
Date:   Wed, 8 Jan 2020 19:16:48 +0800
Message-ID: <20200108111648.36050-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memdup.cocci warnings:
./fs/omfs/inode.c:366:9-16: WARNING opportunity for kmemdup

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
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
2.7.4

