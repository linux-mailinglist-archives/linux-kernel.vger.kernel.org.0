Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958F858810
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF0RMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:12:19 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50411 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfF0RMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:12:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TVMmS7H_1561655524;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVMmS7H_1561655524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Jun 2019 01:12:12 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     rientjes@google.com, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 -mm] mm: account lazy free pages into available memory
Date:   Fri, 28 Jun 2019 01:12:04 +0800
Message-Id: <1561655524-89276-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561655524-89276-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1561655524-89276-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Available memory is one of the most important metrics for memory
pressure.  Currently, lazy free pages are not accounted into available
memory, but they are reclaimable actually, like reclaimable slabs.

Accounting lazy free pages into available memory should reflect the real
memory pressure status, and also would help administrators and/or other
high level scheduling tools make better decision.

The /proc/meminfo would show more available memory with test which
creates ~1GB deferred split THP.

Before:
MemAvailable:   43544272 kB
...
AnonHugePages:     10240 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
LazyFreePages:   1046528 kB

After:
MemAvailable:   44415124 kB
...
AnonHugePages:      6144 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
LazyFreePages:   1046528 kB

MADV_FREE pages are not accounted for NR_LAZYFREE since they have been
put on inactive file LRU and accounted into available memory.
Accounting here would double account them.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cab50e8..58ceca5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5005,6 +5005,7 @@ long si_mem_available(void)
 	unsigned long wmark_low = 0;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long reclaimable;
+	unsigned long lazyfree;
 	struct zone *zone;
 	int lru;
 
@@ -5038,6 +5039,10 @@ long si_mem_available(void)
 			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
 	available += reclaimable - min(reclaimable / 2, wmark_low);
 
+	/* Lazyfree pages are reclaimable when memory pressure is hit */
+	lazyfree = global_node_page_state(NR_LAZYFREE);
+	available += lazyfree - min(lazyfree / 2, wmark_low);
+
 	if (available < 0)
 		available = 0;
 	return available;
-- 
1.8.3.1

