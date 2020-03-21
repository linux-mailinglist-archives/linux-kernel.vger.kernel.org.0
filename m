Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D018E125
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCUMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCUMXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:23:52 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB3B20722;
        Sat, 21 Mar 2020 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793431;
        bh=CLphnmsgUdhergwuL7TSo/4QUaTvu2i11XGuraVfcfM=;
        h=From:To:Cc:Subject:Date:From;
        b=qDGl6I5ValARktfRM5ZGaY1/IsvHQoZGLy0jwuPVkjVXk4gbZnWbaIjcPXg3YDy0w
         D06hW/4tHBdCcTCgpb5yHPpvjbjXaeB+jV7GIniNnWc83LKTizyvRsZd4mXl8JuQru
         wng+yST0rRDlle9MUr3Tnn3NunsFjZsAz/xP57/8=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't call fscrypt_get_encryption_info() explicitly in f2fs_tmpfile()
Date:   Sat, 21 Mar 2020 20:23:27 +0800
Message-Id: <20200321122327.22522-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In f2fs_tmpfile(), parent inode's encryption info is only used when
inheriting encryption context to its child inode, however, we have
already called fscrypt_get_encryption_info() in fscrypt_inherit_context()
to get the encryption info, so just removing unneeded one in
f2fs_tmpfile().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 95cfbce062e8..f54119da2217 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -874,12 +874,6 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) {
-		int err = fscrypt_get_encryption_info(dir);
-		if (err)
-			return err;
-	}
-
 	return __f2fs_tmpfile(dir, dentry, mode, NULL);
 }
 
-- 
2.22.0

