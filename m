Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72A142661
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgATI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 03:59:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbgATI7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:59:04 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 522D414C753858038CAE;
        Mon, 20 Jan 2020 16:59:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:58:54 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     David Howells <dhowells@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] watch_queue: Fix error return code in watch_queue_set_size()
Date:   Mon, 20 Jan 2020 08:54:11 +0000
Message-ID: <20200120085411.116252-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: d9a34f010efd ("pipe: Add general notification queue support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/watch_queue.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index f195cbbbb3d3..3051cf4e35c6 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -252,21 +252,27 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
-	if (!pages)
+	if (!pages) {
+		ret = -ENOMEM;
 		goto error;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
-		if (!pages[i])
+		if (!pages[i]) {
+			ret = -ENOMEM;
 			goto error_p;
+		}
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
 	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
 	bmsize *= sizeof(unsigned long);
 	bitmap = kmalloc(bmsize, GFP_KERNEL);
-	if (!bitmap)
+	if (!bitmap) {
+		ret = -ENOMEM;
 		goto error_p;
+	}
 
 	memset(bitmap, 0xff, bmsize);
 	wqueue->notes = pages;



