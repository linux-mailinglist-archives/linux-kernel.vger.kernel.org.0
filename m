Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E416A805A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfIDK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:29:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfIDK3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:29:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE76BC91298ED4A67C5A;
        Wed,  4 Sep 2019 18:29:07 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 18:28:57 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@kernel.org>
CC:     <anshuman.khandual@arm.com>, <vbabka@suse.cz>,
        <zhongjiang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
Date:   Wed, 4 Sep 2019 18:26:03 +0800
Message-ID: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
compare with zero. And __get_user_pages_locked will return an long value.
Hence, Convert the long to compare with zero is feasible.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 23a9f9c..956d5a1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1508,7 +1508,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((nr_pages > 0) && migrate_allow) {
+		if (((long)nr_pages > 0) && migrate_allow) {
 			drain_allow = true;
 			goto check_again;
 		}
-- 
1.7.12.4

