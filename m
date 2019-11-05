Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0962AEF724
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfKEIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 03:21:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387484AbfKEIV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:21:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1660419F54FEFA14DB0E;
        Tue,  5 Nov 2019 16:21:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 16:21:46 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <n-horiguchi@ah.jp.nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: [PATCH] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
Message-ID: <7bc9d610-728c-37b0-d175-dba21dc0dfff@huawei.com>
Date:   Tue, 5 Nov 2019 16:21:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function page_shift() is supported after the commit 94ad9338109f
("mm: introduce page_shift()").

So replace with page_shift() in add_to_kill() for readability.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..e48c50cac889 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -326,7 +326,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	if (is_zone_device_page(p))
 		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
 	else
-		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
+		tk->size_shift = page_shift(compound_head(p));

 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
-- 
2.7.4

