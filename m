Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1918E127
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCUMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 08:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCUMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:25:03 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB9620724;
        Sat, 21 Mar 2020 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793503;
        bh=baXkY26+grqrvtO0gFEMOKOPPJpTnN3B7ErAMOGPQeI=;
        h=From:To:Cc:Subject:Date:From;
        b=LS1uO6vlEb4UBkc+v99Z26763EJTT1Z7xagXup+HO0xapJrD9yp5dh1C+61pwexiw
         DOklNap9QXfHiD7PqUgFHG/z5vH6igI/AH2TEqQSyhamQvQ2aJSyZD54RUv1Fz598A
         uBSiDcLK5AjfSXusw0t9KhSz6W/+RgpIMpQtdxk4=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to clear PG_error if fsverity failed
Date:   Sat, 21 Mar 2020 20:24:11 +0800
Message-Id: <20200321122411.22597-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In f2fs_decompress_end_io(), we should clear PG_error flag before page
unlock, otherwise reread will fail due to the flag as described in
commit fb7d70db305a ("f2fs: clear PageError on the read path").

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df3e6ad5b6d7..f37b83534322 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1420,15 +1420,17 @@ void f2fs_decompress_end_io(struct page **rpages,
 		if (!rpage)
 			continue;
 
-		if (err || PageError(rpage)) {
-			ClearPageUptodate(rpage);
-			ClearPageError(rpage);
-		} else {
-			if (!verity || fsverity_verify_page(rpage))
-				SetPageUptodate(rpage);
-			else
-				SetPageError(rpage);
+		if (err || PageError(rpage))
+			goto clear_uptodate;
+
+		if (!verity || fsverity_verify_page(rpage)) {
+			SetPageUptodate(rpage);
+			goto unlock;
 		}
+clear_uptodate:
+		ClearPageUptodate(rpage);
+		ClearPageError(rpage);
+unlock:
 		unlock_page(rpage);
 	}
 }
-- 
2.22.0

