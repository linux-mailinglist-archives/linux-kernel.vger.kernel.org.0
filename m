Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8350D7BC91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfGaJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 05:05:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGaJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:05:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hskY2-0003Hf-Qu; Wed, 31 Jul 2019 09:05:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove redundant assignment to variable rc
Date:   Wed, 31 Jul 2019 10:05:26 +0100
Message-Id: <20190731090526.27245-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable rc is being initialized with a value that is never read
and rc is being re-assigned a little later on. The assignment is
redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index ee5d74988a9f..a653c429e8dc 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3617,7 +3617,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	  unsigned int *nbytes, char **buf, int *buf_type)
 {
 	struct smb_rqst rqst;
-	int resp_buftype, rc = -EACCES;
+	int resp_buftype, rc;
 	struct smb2_read_plain_req *req = NULL;
 	struct smb2_read_rsp *rsp = NULL;
 	struct kvec iov[1];
-- 
2.20.1

