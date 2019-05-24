Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27129F22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfEXTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 15:33:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:61073 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfEXTd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:33:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 12:33:28 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 12:33:28 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC] mm/swap: make release_pages() and put_pages() match
Date:   Fri, 24 May 2019 12:34:15 -0700
Message-Id: <20190524193415.9733-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

RFC I have no idea if this is correct or not.  But looking at
release_pages() I see a call to both __ClearPageActive() and
__ClearPageWaiters() while in __page_cache_release() I do not.

Is this a bug which needs to be fixed?  Did I miss clearing active
somewhere else in the call chain of put_page?

This was found via code inspection while determining if release_pages()
and the new put_user_pages() could be interchangeable.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/swap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/swap.c b/mm/swap.c
index 3a75722e68a9..9d0432baddb0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -69,6 +69,7 @@ static void __page_cache_release(struct page *page)
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
+	__ClearPageActive(page);
 	__ClearPageWaiters(page);
 	mem_cgroup_uncharge(page);
 }
-- 
2.20.1

