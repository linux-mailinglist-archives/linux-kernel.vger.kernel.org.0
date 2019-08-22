Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9D9A263
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393345AbfHVVxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:53:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50050 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388259AbfHVVxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:53:17 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0v17-0005AS-Si; Thu, 22 Aug 2019 21:53:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: mft: fix spelling mistake "initiailized" -> "initialized"
Date:   Thu, 22 Aug 2019 22:53:13 +0100
Message-Id: <20190822215313.5080-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a ntfs_debug message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 20c841a906f2..218984422f49 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1580,7 +1580,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	ATTR_RECORD *a;
 	int ret;
 
-	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	ntfs_debug("Extending mft bitmap initialized (and data) size.");
 	mft_ni = NTFS_I(vol->mft_ino);
 	mftbmp_vi = vol->mftbmp_ino;
 	mftbmp_ni = NTFS_I(mftbmp_vi);
-- 
2.20.1

