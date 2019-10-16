Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA84AD8CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfJPJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:51:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44478 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfJPJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:51:20 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKfxY-0002FJ-T2; Wed, 16 Oct 2019 10:51:12 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKfxY-0007bK-6H; Wed, 16 Oct 2019 10:51:12 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: huge_pte_offset() returns pte_t *, not integer
Date:   Wed, 16 Oct 2019 10:51:11 +0100
Message-Id: <20191016095111.29163-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The huge_pte_offset() returns a pte_t *, not an integer
so when huge-tlb is off, the replacement inline macro
should return a pte_t * too.

This fixes the following sparse warning:

mm/page_vma_mapped.c:156:29: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d0..e42c76aa1577 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -185,7 +185,7 @@ static inline void hugetlb_show_meminfo(void)
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
 #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
 				src_addr, pagep)	({ BUG(); 0; })
-#define huge_pte_offset(mm, address, sz)	0
+#define huge_pte_offset(mm, address, sz)	(pte_t *)NULL
 
 static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 {
-- 
2.23.0

