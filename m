Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F721A7D3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfEKMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 08:36:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35140 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEKMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 08:36:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPRES-000895-A7; Sat, 11 May 2019 12:36:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: remove redundant assignment to variable ret
Date:   Sat, 11 May 2019 13:36:03 +0100
Message-Id: <20190511123603.3265-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value however this is never
read and later it is being reassigned to a new value. The assignment
is redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index c81f85003fc7..25cb7ad4fca3 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -71,7 +71,6 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 	if (ret == 0) {
 		ret = acl->size;
 		if (size > 0) {
-			ret = -ERANGE;
 			if (acl->size > size)
 				return -ERANGE;
 			memcpy(buffer, acl->data, acl->size);
-- 
2.20.1

