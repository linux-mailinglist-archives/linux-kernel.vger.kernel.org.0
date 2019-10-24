Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC52E3622
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409570AbfJXPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:04:57 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:47984 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407327AbfJXPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:04:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1422553|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.217482-0.0138334-0.768685;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FppA4zP_1571929478;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.FppA4zP_1571929478)
          by smtp.aliyun-inc.com(10.194.97.171);
          Thu, 24 Oct 2019 23:04:38 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        liuxiang_1999@126.com
Subject: [PATCH v2] mm: gup: fix comment of __get_user_pages()
Date:   Thu, 24 Oct 2019 23:04:32 +0800
Message-Id: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment of __get_user_pages() and make it more clear.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
---

Changes in v2:
 as suggested by John, rewrite the comment about return value.

 mm/gup.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a3..bc6a254 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *		Or NULL if the caller does not require them.
  * @nonblocking: whether waiting for disk IO or mmap_sem contention
  *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with. vmas will only
- * remain valid while mmap_sem is held.
+ * Returns either number of pages pinned (which may be less than the
+ * number requested), or an error. Details about the return value:
+ *
+ * -- If nr_pages is 0, returns 0.
+ * -- If nr_pages is >0, but no pages were pinned, returns -errno.
+ * -- If nr_pages is >0, and some pages were pinned, returns the number of
+ *    pages pinned. Again, this may be less than nr_pages.
+ *
+ * The caller is responsible for releasing returned @pages, via put_page().
+ *
+ * @vmas are valid only as long as mmap_sem is held.
  *
  * Must be called with mmap_sem held.  It may be released.  See below.
  *
-- 
1.9.1

