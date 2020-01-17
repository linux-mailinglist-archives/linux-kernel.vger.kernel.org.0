Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1A140226
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgAQC7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 21:59:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389065AbgAQC73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:59:29 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78CF5ED8B3F9E512D1F0;
        Fri, 17 Jan 2020 10:59:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 10:59:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfrench@samba.org>, <pshilov@microsoft.com>, <lsahlber@redhat.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cifs: remove set but not used variable 'server'
Date:   Fri, 17 Jan 2020 10:57:17 +0800
Message-ID: <20200117025717.58636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/cifs/smb2pdu.c: In function 'SMB2_query_directory':
fs/cifs/smb2pdu.c:4444:26: warning:
 variable 'server' set but not used [-Wunused-but-set-variable]
  struct TCP_Server_Info *server;

It is not used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/smb2pdu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index a23ca3d..64d5a36 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4441,13 +4441,10 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype = CIFS_NO_BUFFER;
 	struct kvec rsp_iov;
 	int rc = 0;
-	struct TCP_Server_Info *server;
 	struct cifs_ses *ses = tcon->ses;
 	int flags = 0;
 
-	if (ses && (ses->server))
-		server = ses->server;
-	else
+	if (!ses || !(ses->server))
 		return -EIO;
 
 	if (smb3_encryption_required(tcon))
-- 
2.7.4


