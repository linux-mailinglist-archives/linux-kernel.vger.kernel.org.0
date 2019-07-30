Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC967A0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfG3Fwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:52:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbfG3Fwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WWqUlWBk9SeNDsTgchqiBvCPPdXQGby4eLwA4l1Wn/c=; b=UQt+nBOCFLuTt9lR9m80f7mUgE
        lS9m/3kgkBnUgWm075wpjDvoWcfsvGjj6XNdiPu0xYJSsIR91F3EVZwqjOtGPHT3tWlZR1g4Z/KQV
        sMdXE4d3yo6a78yBkEuoY1UtuG8aYk83pTsB59Pqnw9yKDyyqlzcymrOVg3Ou7ovmKyZvBhF6NEzZ
        YLcfiBi183KQGYbKJQFVbR+/FEJmnM8Cf0NcQFhzluMjCVBfbn7EewshSuoqwtxhgBLdNx+a/2VgS
        05Skzq6tlpaW0rNMPwXleuGdfG+87MF1AAS0XJXPfCY9/nfdHzoMBWXoCqJG0YWhBv5LN55u8SyqL
        DNIqFunQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL43-0001QQ-Bt; Tue, 30 Jul 2019 05:52:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] mm: cleanup the hmm_vma_handle_pmd stub
Date:   Tue, 30 Jul 2019 08:52:01 +0300
Message-Id: <20190730055203.28467-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stub out the whole function when CONFIG_TRANSPARENT_HUGEPAGE is not set
to make the function easier to read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 4d3bd41b6522..f4e90ea5779f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -455,13 +455,10 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-static int hmm_vma_handle_pmd(struct mm_walk *walk,
-			      unsigned long addr,
-			      unsigned long end,
-			      uint64_t *pfns,
-			      pmd_t pmd)
-{
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
+		unsigned long end, uint64_t *pfns, pmd_t pmd)
+{
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct dev_pagemap *pgmap = NULL;
@@ -490,11 +487,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
-#else
-	/* If THP is not enabled then we should never reach this code ! */
+}
+#else /* CONFIG_TRANSPARENT_HUGEPAGE */
+static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
+		unsigned long end, uint64_t *pfns, pmd_t pmd)
+{
 	return -EINVAL;
-#endif
 }
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 {
-- 
2.20.1

