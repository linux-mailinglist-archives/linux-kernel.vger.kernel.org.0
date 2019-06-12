Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA541A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 03:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbfFLBtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 21:49:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729044AbfFLBtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:49:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E8849EB679BB46D72185;
        Wed, 12 Jun 2019 09:49:10 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 09:48:57 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] futex: Fix futex lock the wrong page
Date:   Wed, 12 Jun 2019 09:54:25 +0800
Message-ID: <1560304465-68966-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstram commit 65d8fc777f6d ("futex: Remove requirement
for lock_page() in get_futex_key()") use variable 'page' as
the page head, when merge it to stable branch, the variable
`page_head` is page head.

In the stable branch, the variable `page` not means the page
head, when lock the page head, we should lock 'page_head',
rather than 'page'.

It maybe lead a hung task problem.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc: stable@vger.kernel.org
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ec9df5b..15d850f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -593,8 +593,8 @@ again:
 		 * applies. If this is really a shmem page then the page lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
+		lock_page(page_head);
+		shmem_swizzled = PageSwapCache(page_head) || page_head->mapping;
 		unlock_page(page_head);
 		put_page(page_head);
 
-- 
2.7.4

