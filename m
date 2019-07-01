Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC64518D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfFXQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:39:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfFXQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:39:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hfS0N-00067P-Fk; Mon, 24 Jun 2019 16:39:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: fix typo in debug message with struct field ia_valid
Date:   Mon, 24 Jun 2019 17:39:43 +0100
Message-Id: <20190624163943.6721-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Field ia_valid is being debugged with the field name iavalid, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index d7cc62252634..06a4892e9973 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2415,7 +2415,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 
 	xid = get_xid();
 
-	cifs_dbg(FYI, "setattr on file %pd attrs->iavalid 0x%x\n",
+	cifs_dbg(FYI, "setattr on file %pd attrs->ia_valid 0x%x\n",
 		 direntry, attrs->ia_valid);
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
-- 
2.20.1

