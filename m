Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8978578
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfG2GxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:53:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbfG2Gwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3A70A6EC738553B517CB;
        Mon, 29 Jul 2019 14:52:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:29 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 14/22] staging: erofs: tidy up zpvec.h
Date:   Mon, 29 Jul 2019 14:51:51 +0800
Message-ID: <20190729065159.62378-15-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- use shorter function names:
  z_erofs_pagevec_enqueue and z_erofs_pagevec_dequeue;
- minor code cleanup.

In order to keep in line with erofs-outofstaging patchset.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/zdata.c |  6 +++---
 drivers/staging/erofs/zpvec.h | 25 +++++++++----------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index 02560b940558..29900ca7c9d4 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -314,8 +314,8 @@ static int z_erofs_vle_work_add_page(
 	    try_to_reuse_as_compressed_page(builder, page))
 		return 0;
 
-	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector,
-					   page, type, &occupied);
+	ret = z_erofs_pagevec_enqueue(&builder->vector,
+				      page, type, &occupied);
 	builder->work->vcnt += (unsigned int)ret;
 
 	return ret ? 0 : -EAGAIN;
@@ -941,7 +941,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	for (i = 0; i < work->vcnt; ++i) {
 		unsigned int pagenr;
 
-		page = z_erofs_pagevec_ctor_dequeue(&ctor, &page_type);
+		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
 
 		/* all pages in pagevec ought to be valid */
 		DBG_BUGON(!page);
diff --git a/drivers/staging/erofs/zpvec.h b/drivers/staging/erofs/zpvec.h
index 77bf6877bad8..9798f5627786 100644
--- a/drivers/staging/erofs/zpvec.h
+++ b/drivers/staging/erofs/zpvec.h
@@ -11,7 +11,7 @@
 
 #include "tagptr.h"
 
-/* page type in pagevec for unzip subsystem */
+/* page type in pagevec for decompress subsystem */
 enum z_erofs_page_type {
 	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
 	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
@@ -103,16 +103,14 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
 			z_erofs_pagevec_ctor_pagedown(ctor, false);
 		}
 	}
-
 	ctor->next = z_erofs_pagevec_ctor_next_page(ctor, i);
 	ctor->index = i;
 }
 
-static inline bool
-z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
-			     struct page *page,
-			     enum z_erofs_page_type type,
-			     bool *occupied)
+static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
+					   struct page *page,
+					   enum z_erofs_page_type type,
+					   bool *occupied)
 {
 	*occupied = false;
 	if (unlikely(!ctor->next && type))
@@ -131,15 +129,13 @@ z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
 		ctor->next = page;
 		*occupied = true;
 	}
-
-	ctor->pages[ctor->index++] =
-		tagptr_fold(erofs_vtptr_t, page, type);
+	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
 	return true;
 }
 
 static inline struct page *
-z_erofs_pagevec_ctor_dequeue(struct z_erofs_pagevec_ctor *ctor,
-			     enum z_erofs_page_type *type)
+z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
+			enum z_erofs_page_type *type)
 {
 	erofs_vtptr_t t;
 
@@ -156,11 +152,8 @@ z_erofs_pagevec_ctor_dequeue(struct z_erofs_pagevec_ctor *ctor,
 	if (*type == (uintptr_t)ctor->next)
 		ctor->next = tagptr_unfold_ptr(t);
 
-	ctor->pages[ctor->index++] =
-		tagptr_fold(erofs_vtptr_t, NULL, 0);
-
+	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, NULL, 0);
 	return tagptr_unfold_ptr(t);
 }
-
 #endif
 
-- 
2.17.1

