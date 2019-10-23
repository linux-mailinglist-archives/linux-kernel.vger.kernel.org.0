Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F6E1D71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406259AbfJWN4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:56:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405260AbfJWN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:56:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 542A14C4B70DAA5B2CE0;
        Wed, 23 Oct 2019 21:56:41 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:56:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cifs: remove unused variable 'sid_user'
Date:   Wed, 23 Oct 2019 21:55:59 +0800
Message-ID: <20191023135559.31452-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/cifs/cifsacl.c:43:30: warning:
 sid_user defined but not used [-Wunused-const-variable=]

It is never used, so remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/cifsacl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index f842944a..06ffe52 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -39,8 +39,6 @@ static const struct cifs_sid sid_everyone = {
 /* security id for Authenticated Users system group */
 static const struct cifs_sid sid_authusers = {
 	1, 1, {0, 0, 0, 0, 0, 5}, {cpu_to_le32(11)} };
-/* group users */
-static const struct cifs_sid sid_user = {1, 2 , {0, 0, 0, 0, 0, 5}, {} };
 
 /* S-1-22-1 Unmapped Unix users */
 static const struct cifs_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
-- 
2.7.4


