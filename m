Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2801C1666F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEGPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 11:16:52 -0400
Received: from mx1.chost.de ([5.175.28.52]:53029 "EHLO mx1.chost.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfEGPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:16:51 -0400
Received: from vm002.chost.de ([::ffff:192.168.122.102])
  by mx1.chost.de with SMTP; Tue, 07 May 2019 17:17:39 +0200
  id 000000000133ACDA.000000005CD1A193.00003808
Received: by vm002.chost.de (sSMTP sendmail emulation); Tue, 07 May 2019 17:17:38 +0200
From:   Christoph Probst <kernel@probst.it>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Christoph Probst <kernel@probst.it>
Subject: [PATCH v2] cifs: fix strcat buffer overflow and reduce raciness in smb21_set_oplock_level()
Date:   Tue,  7 May 2019 17:16:40 +0200
Message-Id: <1557242200-26194-1-git-send-email-kernel@probst.it>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change strcat to strncpy in the "None" case to fix a buffer overflow
when cinode->oplock is reset to 0 by another thread accessing the same
cinode. It is never valid to append "None" to any other message.

Consolidate multiple writes to cinode->oplock to reduce raciness.

Signed-off-by: Christoph Probst <kernel@probst.it>
---
 fs/cifs/smb2ops.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c36ff0d..aa61dcf 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2917,26 +2917,28 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 		       unsigned int epoch, bool *purge_cache)
 {
 	char message[5] = {0};
+	unsigned int new_oplock = 0;
 
 	oplock &= 0xFF;
 	if (oplock == SMB2_OPLOCK_LEVEL_NOCHANGE)
 		return;
 
-	cinode->oplock = 0;
 	if (oplock & SMB2_LEASE_READ_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_READ_FLG;
+		new_oplock |= CIFS_CACHE_READ_FLG;
 		strcat(message, "R");
 	}
 	if (oplock & SMB2_LEASE_HANDLE_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_HANDLE_FLG;
+		new_oplock |= CIFS_CACHE_HANDLE_FLG;
 		strcat(message, "H");
 	}
 	if (oplock & SMB2_LEASE_WRITE_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_WRITE_FLG;
+		new_oplock |= CIFS_CACHE_WRITE_FLG;
 		strcat(message, "W");
 	}
-	if (!cinode->oplock)
-		strcat(message, "None");
+	if (!new_oplock)
+		strncpy(message, "None", sizeof(message));
+
+	cinode->oplock = new_oplock;
 	cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
 		 &cinode->vfs_inode);
 }
-- 
2.1.4

