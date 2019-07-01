Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0515018
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfEFPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 11:25:39 -0400
Received: from mx1.chost.de ([5.175.28.52]:40320 "EHLO mx1.chost.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfEFPZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:25:38 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 11:25:37 EDT
Received: from vm002.chost.de ([::ffff:192.168.122.102])
  by mx1.chost.de with SMTP; Mon, 06 May 2019 17:21:16 +0200
  id 000000000133BD2A.000000005CD050EC.00007663
Received: by vm002.chost.de (sSMTP sendmail emulation); Mon, 06 May 2019 17:21:15 +0200
From:   Christoph Probst <kernel@probst.it>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Christoph Probst <kernel@probst.it>
Subject: [PATCH] cifs: fix strcat buffer overflow in smb21_set_oplock_level()
Date:   Mon,  6 May 2019 17:16:32 +0200
Message-Id: <1557155792-2703-1-git-send-email-kernel@probst.it>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change strcat to strcpy in the "None" case as it is never valid to append
"None" to any other message. It may also overflow char message[5], in a
race condition on cinode if cinode->oplock is unset by another thread
after "RHW" or "RH" had been written to message.

Signed-off-by: Christoph Probst <kernel@probst.it>
---
 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c36ff0d..5fd5567 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2936,7 +2936,7 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 		strcat(message, "W");
 	}
 	if (!cinode->oplock)
-		strcat(message, "None");
+		strcpy(message, "None");
 	cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
 		 &cinode->vfs_inode);
 }
-- 
2.1.4

