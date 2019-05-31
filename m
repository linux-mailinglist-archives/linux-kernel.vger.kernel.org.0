Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C888B31202
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEaQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 12:11:47 -0400
Received: from smtprz14.163.net ([106.3.154.247]:36482 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaQLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:11:47 -0400
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id 38A5B1C81BB1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:59 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID 390728459
          for <linux-kernel@vger.kernel.org>;
          Fri, 31 May 2019 23:50:59 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 5CFC71C81B97
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:58 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 583E510018B7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:58 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PcrpKDZU1KxI for <linux-kernel@vger.kernel.org>;
        Fri, 31 May 2019 23:50:57 +0800 (CST)
Received: from localhost (unknown [222.209.18.96])
        by antispam1.tom.com (Postfix) with ESMTPA id 317E3100112A;
        Fri, 31 May 2019 23:50:57 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v2] fs: buffer: fix fully_mapped reset in block_read_full_page()
Date:   Fri, 31 May 2019 23:50:51 +0800
Message-Id: <1559317851-3861-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because get_block() might set the buffer mapped, fully_mapped reset 
should be done according to the result of buffer_mapped(bh) 
which check the buffer mapped attribute again after get_block().

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---

Changes in v2:
 change comment

 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e450c55..987aadb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2243,7 +2243,6 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		if (!buffer_mapped(bh)) {
 			int err = 0;
 
-			fully_mapped = 0;
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
@@ -2251,6 +2250,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
+				fully_mapped = 0;
 				zero_user(page, i * blocksize, blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
-- 
1.9.1

