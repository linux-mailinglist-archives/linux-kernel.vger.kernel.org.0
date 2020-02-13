Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7096815B8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 05:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgBMEbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 23:31:51 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45221 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729494AbgBMEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:31:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TprKpxQ_1581568298;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TprKpxQ_1581568298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Feb 2020 12:31:47 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     minchan@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: replace open codings to NUMA_NO_NODE
Date:   Thu, 13 Feb 2020 12:31:38 +0800
Message-Id: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 98fa15f34cb3 ("mm: replace all open encodings for
NUMA_NO_NODE") did the replacement across the kernel tree, but we got
some more in vmscan.c since then.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c05eb9e..567864a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2096,7 +2096,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 unsigned long reclaim_pages(struct list_head *page_list)
 {
-	int nid = -1;
+	int nid = NUMA_NO_NODE;
 	unsigned long nr_reclaimed = 0;
 	LIST_HEAD(node_page_list);
 	struct reclaim_stat dummy_stat;
@@ -2111,7 +2111,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 
 	while (!list_empty(page_list)) {
 		page = lru_to_page(page_list);
-		if (nid == -1) {
+		if (nid == NUMA_NO_NODE) {
 			nid = page_to_nid(page);
 			INIT_LIST_HEAD(&node_page_list);
 		}
@@ -2132,7 +2132,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 			putback_lru_page(page);
 		}
 
-		nid = -1;
+		nid = NUMA_NO_NODE;
 	}
 
 	if (!list_empty(&node_page_list)) {
-- 
1.8.3.1

