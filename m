Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB7B6420
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfIRNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 09:12:24 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:54000 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfIRNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:12:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2977127|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.151228-0.00972801-0.839044;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16370;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FX0WcNh_1568812325;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.FX0WcNh_1568812325)
          by smtp.aliyun-inc.com(10.194.98.226);
          Wed, 18 Sep 2019 21:12:05 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: [PATCH] mm: vmalloc: remove unnecessary highmem_mask from parameter of gfpflags_allow_blocking()
Date:   Wed, 18 Sep 2019 21:11:59 +0800
Message-Id: <1568812319-3467-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfpflags_allow_blocking() does not care about __GFP_HIGHMEM,
so highmem_mask can be removed.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7ba11e1..143c636 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2432,7 +2432,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			goto fail;
 		}
 		area->pages[i] = page;
-		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
+		if (gfpflags_allow_blocking(gfp_mask))
 			cond_resched();
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-- 
1.9.1

