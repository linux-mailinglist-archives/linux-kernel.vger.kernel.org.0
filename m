Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFEF0FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 08:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfKFHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 02:06:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730997AbfKFHGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:06:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6189FAA464E38B6DEF4;
        Wed,  6 Nov 2019 15:06:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 6 Nov 2019
 15:06:39 +0800
To:     <akpm@linux-foundation.org>, <jgg@ziepe.ca>, <mhocko@suse.com>,
        <jglisse@redhat.com>, <minchan@kernel.org>, <peterz@infradead.org>,
        <jack@suse.cz>, <rppt@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] mm/madvise: replace with page_size() in
 madvise_inject_error()
Message-ID: <29dce60c-38d6-0220-f292-e298f0c78c4d@huawei.com>
Date:   Wed, 6 Nov 2019 15:06:27 +0800
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

The function page_size() is supported after the commit a50b854e073c
("mm: introduce page_size()").

Replace with page_size() in madvise_inject_error() for readability.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 mm/madvise.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2be9f3fdb05e..38c4e7fcf850 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -856,13 +856,13 @@ static int madvise_inject_error(int behavior,
 {
 	struct page *page;
 	struct zone *zone;
-	unsigned int order;
+	unsigned int size;

 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;


-	for (; start < end; start += PAGE_SIZE << order) {
+	for (; start < end; start += size) {
 		unsigned long pfn;
 		int ret;

@@ -874,9 +874,9 @@ static int madvise_inject_error(int behavior,
 		/*
 		 * When soft offlining hugepages, after migrating the page
 		 * we dissolve it, therefore in the second loop "page" will
-		 * no longer be a compound page, and order will be 0.
+		 * no longer be a compound page.
 		 */
-		order = compound_order(compound_head(page));
+		size = page_size(compound_head(page));

 		if (PageHWPoison(page)) {
 			put_page(page);
-- 
2.7.4

