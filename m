Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D187DA469
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 05:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407675AbfJQDyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 23:54:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392243AbfJQDyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:54:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0BF5C6F2F1AB8227FC87;
        Thu, 17 Oct 2019 11:54:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 11:54:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Steve French <sfrench@samba.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] CIFS: remove set but not used variables 'cinode' and 'netfid'
Date:   Thu, 17 Oct 2019 03:53:51 +0000
Message-ID: <20191017035351.125013-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

fs/cifs/file.c: In function 'cifs_flock':
fs/cifs/file.c:1704:8: warning:
 variable 'netfid' set but not used [-Wunused-but-set-variable]

fs/cifs/file.c:1702:24: warning:
 variable 'cinode' set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 936e03892e2a..02a81dc6861a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1699,9 +1699,7 @@ int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
 	bool posix_lck = false;
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_tcon *tcon;
-	struct cifsInodeInfo *cinode;
 	struct cifsFileInfo *cfile;
-	__u16 netfid;
 	__u32 type;
 
 	rc = -EACCES;
@@ -1716,8 +1714,6 @@ int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
 	cifs_read_flock(fl, &type, &lock, &unlock, &wait_flag,
 			tcon->ses->server);
 	cifs_sb = CIFS_FILE_SB(file);
-	netfid = cfile->fid.netfid;
-	cinode = CIFS_I(file_inode(file));
 
 	if (cap_unix(tcon->ses) &&
 	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&



