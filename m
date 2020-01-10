Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0005E136599
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 03:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgAJC6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 21:58:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:30219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJC63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:58:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 18:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="236722161"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 18:58:28 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/huge_memory.c: reduce critical section protected by split_queue_lock
Date:   Fri, 10 Jan 2020 10:55:16 +0800
Message-Id: <20200110025516.23996-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_queue_lock protects data in struct deferred_split. We can release
the lock after delete the page from deferred_split_queue.

This patch moves the THP accounting out of the lock protection, which is
introduced in commit 65c453778aea ("mm, rmap: account shmem thp pages").

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3c745d298a27..88c541bf44c7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2810,6 +2810,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
+		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
 			if (PageSwapBacked(head))
 				__dec_node_page_state(head, NR_SHMEM_THPS);
@@ -2817,7 +2818,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		spin_unlock(&ds_queue->split_queue_lock);
 		__split_huge_page(page, list, end, flags);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
-- 
2.17.1

