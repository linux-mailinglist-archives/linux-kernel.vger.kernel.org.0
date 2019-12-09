Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015C0117931
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLIWYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfLIWXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:49 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6B220726;
        Mon,  9 Dec 2019 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930228;
        bh=8cR/ULUscr3UPWmG/10SoHiMq7WuYzVCxKz9deW1Qxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZwDje6T2zUqfXoR++5dwDY3Jy/iemEyl8zsXLQjRSzKeepB83oLKKujI/9UhJCJw
         jhHY6bviwuR8s9KOqKersNfKXiNps9uC0ffFJG4zYLw++izJY5sER/+PvwEVgeGdvP
         OEp2dTo264cXQ6tGFc5wlkU4WaRDEYfVnkq/QhOs=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs: should avoid recursive filesystem ops
Date:   Mon,  9 Dec 2019 14:23:43 -0800
Message-Id: <20191209222345.1078-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to use GFP_NOFS, since we did f2fs_lock_op().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6cebc6681487..eb653f700ade 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1191,13 +1191,13 @@ static int __exchange_data_block(struct inode *src_inode,
 
 		src_blkaddr = f2fs_kvzalloc(F2FS_I_SB(src_inode),
 					array_size(olen, sizeof(block_t)),
-					GFP_KERNEL);
+					GFP_NOFS);
 		if (!src_blkaddr)
 			return -ENOMEM;
 
 		do_replace = f2fs_kvzalloc(F2FS_I_SB(src_inode),
 					array_size(olen, sizeof(int)),
-					GFP_KERNEL);
+					GFP_NOFS);
 		if (!do_replace) {
 			kvfree(src_blkaddr);
 			return -ENOMEM;
-- 
2.19.0.605.g01d371f741-goog

