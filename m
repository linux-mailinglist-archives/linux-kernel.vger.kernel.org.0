Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E186A5A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfIBPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 11:01:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41766 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfIBPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:01:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4nq4-00007n-OK; Mon, 02 Sep 2019 15:01:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][cifs-next] cifs: fix dereference on ses before it is null checked
Date:   Mon,  2 Sep 2019 16:01:52 +0100
Message-Id: <20190902150152.21550-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of pointer server dereferences pointer ses, however,
this dereference occurs before ses is null checked and hence we
have a potential null pointer dereference.  Fix this by only
dereferencing ses after it has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 2808c6639104 ("cifs: add new debugging macro cifs_server_dbg")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 0d60bd2f4dca..a90bd4d75b4d 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1242,12 +1242,13 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server;
 
 	if (ses == NULL) {
 		cifs_dbg(VFS, "Null smb session\n");
 		return -EIO;
 	}
+	server = ses->server;
 	if (server == NULL) {
 		cifs_dbg(VFS, "Null tcp session\n");
 		return -EIO;
-- 
2.20.1

