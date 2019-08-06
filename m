Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4C83642
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfHFQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbfHFQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e9aFg9y3NWAnc2PsHRJxtyHwhE0a0AbbxTY4a2BFPAw=; b=TdJihcN0imUrB+DXTgmH0YwTUb
        lhLq60JHilI/KNarxExvblJfGtJD/KeWw1YixvJmmQjZxBo3be+cmgsarEog2qaCkGzoYPJY6s8qs
        zDZh/xO+rJ1KZCNRLgq3pmAluvXZ31iOXadZOdkkZWIPMLgaTQONiL10gRria1wqAe3NyDFV1xDmY
        lHYDcFCpFmiKOrErT1VtfkzdIfcB6wRbYd0gXaFxWTUZ19blXt2ymzvsasYfbVxQsnFGJeH5AWd0S
        OPiYzPzKK5xu5e0oJQoArM98BctBcV8Y0EJN1AwB6LCKDlcmolgWN0XhXCXtGgkezGIKL8Zu2VFTc
        qp692nQg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yi-0000cX-Ex; Tue, 06 Aug 2019 16:06:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] mm: cleanup the hmm_vma_handle_pmd stub
Date:   Tue,  6 Aug 2019 19:05:49 +0300
Message-Id: <20190806160554.14046-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
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
 mm/hmm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 5e7afe685213..4aa7135f1094 100644
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
@@ -490,11 +487,12 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
-#else
-	/* If THP is not enabled then we should never reach this code ! */
-	return -EINVAL;
-#endif
 }
+#else /* CONFIG_TRANSPARENT_HUGEPAGE */
+/* stub to allow the code below to compile */
+int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
+		unsigned long end, uint64_t *pfns, pmd_t pmd);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 {
-- 
2.20.1

