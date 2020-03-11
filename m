Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC37181F53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgCKRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:24:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbgCKRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E24BABD7;
        Wed, 11 Mar 2020 17:24:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/hugetlb: remove unnecessary memory fetch in PageHeadHuge()
Date:   Wed, 11 Mar 2020 18:24:40 +0100
Message-Id: <20200311172440.6988-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f1e61557f023 ("mm: pack compound_dtor and compound_order into one word
in struct page") changed compound_dtor from a pointer to an array index in
order to pack it. To check if page has the hugeltbfs compound_dtor, we can
just compare the index directly without fetching the function pointer.
Said commit did that with PageHuge() and we can do the same with PageHeadHuge()
to make the code a bit smaller and faster.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..ba1ca452aa7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1313,7 +1313,7 @@ int PageHeadHuge(struct page *page_head)
 	if (!PageHead(page_head))
 		return 0;
 
-	return get_compound_page_dtor(page_head) == free_huge_page;
+	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
 
 pgoff_t __basepage_index(struct page *page)
-- 
2.25.1

