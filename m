Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1EA3CDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfFKN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:57:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387835AbfFKN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:57:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE158C4322C7E5AD3117;
        Tue, 11 Jun 2019 21:57:30 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 21:57:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfrench@samba.org>, <lsahlber@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-cifs@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cifs: remove set but not used variable 'ioctl_buf' and 'cifsi'
Date:   Tue, 11 Jun 2019 21:53:15 +0800
Message-ID: <20190611135315.20012-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warnings:

fs/cifs/smb2ops.c: In function smb2_query_symlink:
fs/cifs/smb2ops.c:2417:8: warning: variable ioctl_buf set but not used [-Wunused-but-set-variable]
fs/cifs/smb2ops.c: In function smb3_punch_hole:
fs/cifs/smb2ops.c:2799:24: warning: variable cifsi set but not used [-Wunused-but-set-variable]

'ioctl_buf' is never used since introduction in commit ebaf546a5584 ("SMB3:
Clean up query symlink when reparse point")

'cifsi' is never used since introduction in commit 31742c5a3317 ("enable
fallocate punch hole ("fallocate -p") for SMB3")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/smb2ops.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e921e65..e8dfa34 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2414,7 +2414,6 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec close_iov[1];
 	struct smb2_create_rsp *create_rsp;
 	struct smb2_ioctl_rsp *ioctl_rsp;
-	char *ioctl_buf;
 	u32 plen;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
@@ -2496,7 +2495,6 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	if ((rc == 0) && (is_reparse_point)) {
 		/* See MS-FSCC 2.3.23 */
 
-		ioctl_buf = (char *)ioctl_rsp + le32_to_cpu(ioctl_rsp->OutputOffset);
 		plen = le32_to_cpu(ioctl_rsp->OutputCount);
 
 		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
@@ -2796,7 +2794,6 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			    loff_t offset, loff_t len)
 {
 	struct inode *inode;
-	struct cifsInodeInfo *cifsi;
 	struct cifsFileInfo *cfile = file->private_data;
 	struct file_zero_data_information fsctl_buf;
 	long rc;
@@ -2806,7 +2803,6 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	xid = get_xid();
 
 	inode = d_inode(cfile->dentry);
-	cifsi = CIFS_I(inode);
 
 	/* Need to make file sparse, if not already, before freeing range. */
 	/* Consider adding equivalent for compressed since it could also work */
-- 
2.7.4


