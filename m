Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033DF125F58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 11:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLSKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 05:41:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfLSKlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:41:25 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B0393D3EB05AC1DBC20E;
        Thu, 19 Dec 2019 18:41:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 18:41:16 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>
Subject: [PATCH RESEND] 9p: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 18:48:37 +0800
Message-ID: <1576752517-58292-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

fs/9p/vfs_inode.c:146:3-4: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b82423a..c9255d3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -143,7 +143,7 @@ static umode_t p9mode2unixmode(struct v9fs_session_info *v9ses,
 		default:
 			p9_debug(P9_DEBUG_ERROR, "Unknown special type %c %s\n",
 				 type, stat->extension);
-		};
+		}
 		*rdev = MKDEV(major, minor);
 	} else
 		res |= S_IFREG;
--
2.7.4

