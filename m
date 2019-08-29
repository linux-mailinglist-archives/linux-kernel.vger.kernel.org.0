Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB3A214A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH2QuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfH2QuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:50:10 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAC9208CB;
        Thu, 29 Aug 2019 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567097409;
        bh=Hslj8UGkEo+uEL+vuwTBz4V9Schqb3dk989zc+CeNYE=;
        h=From:To:Cc:Subject:Date:From;
        b=BWIBnFoCvnav1ZFWTSGjiXYAqgdO6IavKgAGKHeWQ68Cc1JGSC2R8HG/ChKL+FbEq
         q+SP4H7f3RZ/XFAQedch6EeKn8vQf3q/We5z94rbTYMiOKvPzYwsaDNHQyJRVx6qyf
         Z1jhCqpYdPUGisEw3PHHzp6C+/zAWX590OKClHR4=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix flushing node pages when checkpoint is disabled
Date:   Thu, 29 Aug 2019 09:50:08 -0700
Message-Id: <20190829165008.71226-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes skipping node page writes when checkpoint is disabled.
In this period, we can't rely on checkpoint to flush node pages.

Fixes: fd8c8caf7e7c ("f2fs: let checkpoint flush dnode page of regular")
Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5044eec8097..8b66bc4c004b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1524,7 +1524,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
-	if (wbc->sync_mode == WB_SYNC_NONE &&
+	if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+			wbc->sync_mode == WB_SYNC_NONE &&
 			IS_DNODE(page) && is_cold_node(page))
 		goto redirty_out;
 
@@ -1909,7 +1910,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	}
 
 	if (step < 2) {
-		if (wbc->sync_mode == WB_SYNC_NONE && step == 1)
+		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+				wbc->sync_mode == WB_SYNC_NONE && step == 1)
 			goto out;
 		step++;
 		goto next_step;
-- 
2.19.0.605.g01d371f741-goog

