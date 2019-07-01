Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF032151D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfEQIMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 04:12:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38196 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEQIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:12:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hRXyj-0004tg-LP; Fri, 17 May 2019 08:12:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: fix memory leak of pneg_inbuf on -EOPNOTSUPP ioctl case
Date:   Fri, 17 May 2019 09:12:33 +0100
Message-Id: <20190517081233.11764-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the case where SMB2_ioctl returns the -EOPNOTSUPP error
there is a memory leak of pneg_inbuf. Fix this by returning via
the out_free_inbuf exit path that will perform the relevant kfree.

Addresses-Coverity: ("Resource leak")
Fixes: 969ae8e8d4ee ("cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPORTED")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 710ceb875161..5b8d1482ffbd 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1054,7 +1054,8 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 		 * not supported error. Client should accept it.
 		 */
 		cifs_dbg(VFS, "Server does not support validate negotiate\n");
-		return 0;
+		rc = 0;
+		goto out_free_inbuf;
 	} else if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
 		rc = -EIO;
-- 
2.20.1

