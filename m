Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8BA5303
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfIBJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:40:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfIBJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:40:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4ipQ-0007Da-BR; Mon, 02 Sep 2019 09:40:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] staging: exfat: remove return and error return via a goto
Date:   Mon,  2 Sep 2019 10:40:52 +0100
Message-Id: <20190902094052.28029-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return statement is incorrect, the error exit should be by
assigning ret with the error code and exiting via label out.
Thanks to Valdis Klētnieks for correcting my original fix.

Addresses-Coverity: ("Structurally dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: exit via the got rather than returning via the return statement

---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b5c2ca8c9aa..8c2130cc431b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -664,7 +664,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	dentry = p_fs->fs_func->find_dir_entry(sb, &dir, &uni_name, num_entries,
 					       &dos_name, TYPE_ALL);
 	if (dentry < -1) {
-		return FFS_NOTFOUND;
+		ret = FFS_NOTFOUND;
 		goto out;
 	}
 
-- 
2.20.1

