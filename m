Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92613B95C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 07:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgAOGJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 01:09:38 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52727 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgAOGJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:09:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TnmuvRl_1579068565;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TnmuvRl_1579068565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Jan 2020 14:09:35 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in queue_pages_test_walk()
Date:   Wed, 15 Jan 2020 14:09:25 +0800
Message-Id: <1579068565-110432-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM_BUG_ON() is already used by queue_pages_test_walk(), it sounds
better to dump more debug information by using VM_BUG_ON_VMA() to help
debugging.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 067cf7d..801d45d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -621,7 +621,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	unsigned long flags = qp->flags;
 
 	/* range check first */
-	VM_BUG_ON((vma->vm_start > start) || (vma->vm_end < end));
+	VM_BUG_ON_VMA((vma->vm_start > start) || (vma->vm_end < end), vma);
 
 	if (!qp->first) {
 		qp->first = vma;
-- 
1.8.3.1

