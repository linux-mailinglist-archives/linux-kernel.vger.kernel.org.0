Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFFEC0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfKAJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 05:54:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfKAJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:54:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60DFD2FAC0E85D290225;
        Fri,  1 Nov 2019 17:53:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 17:53:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: clean up check condition for writting beyond EOF
Date:   Fri, 1 Nov 2019 17:53:22 +0800
Message-ID: <20191101095324.9902-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up with below codes suggested by Eric:

__write_data_page()

	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);

	/*
	 * If the offset is out-of-range of file size,
	 * this page does not have to be written to disk.
	 */
	if (page->index >= nr_pages)
		goto out;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba3bcf4c7889..ca7161e38d1f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2204,6 +2204,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	const pgoff_t end_index = ((unsigned long long) i_size)
 							>> PAGE_SHIFT;
 	loff_t psize = (page->index + 1) << PAGE_SHIFT;
+	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
 	unsigned offset = 0;
 	bool need_balance_fs = false;
 	int err = 0;
@@ -2248,8 +2249,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	 * If the offset is out-of-range of file size,
 	 * this page does not have to be written to disk.
 	 */
-	offset = i_size & (PAGE_SIZE - 1);
-	if ((page->index >= end_index + 1) || !offset)
+	if (page->index >= nr_pages)
 		goto out;
 
 	zero_user_segment(page, offset, PAGE_SIZE);
-- 
2.18.0.rc1

