Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62D1365CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 04:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgAJD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 22:26:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:54125 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbgAJD0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:26:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 19:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; 
   d="scan'208";a="212113181"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2020 19:26:22 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/2] mm/huge_memory.c: use head to check huge zero page
Date:   Fri, 10 Jan 2020 11:26:09 +0800
Message-Id: <20200110032610.26499-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page could be a tail page, if this is the case, this BUG_ON will
never be triggered.

Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 168d8a1a9bac..90165f68cf13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2696,7 +2696,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unsigned long flags;
 	pgoff_t end;
 
-	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
+	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-- 
2.17.1

