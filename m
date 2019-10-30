Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABFE9516
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 03:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJ3Cvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 22:51:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbfJ3Cvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:51:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E969BDF9E86883B783AE;
        Wed, 30 Oct 2019 10:51:37 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 10:51:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <n-horiguchi@ah.jp.nec.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH] mm/hwpoison-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Wed, 30 Oct 2019 10:47:40 +0800
Message-ID: <1572403660-44718-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 mm/hwpoison-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 5b7430b..e488876 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -67,8 +67,8 @@ static int hwpoison_unpoison(void *data, u64 val)
 	return unpoison_memory(val);
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
-DEFINE_SIMPLE_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
+DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
+DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
 
 static void pfn_inject_exit(void)
 {
-- 
1.7.12.4

