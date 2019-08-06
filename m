Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21C83643
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfHFQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbfHFQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YRRjZVhDBKVOH1jTuQF7A3O3z8BLVwvvxYuFPnL2EoU=; b=IOHXbjZxSo82prtQ4bNa7kyk3F
        ERoxF4OGQgr4Pywg2DaD0Fxz1thwKfufBvzCaB2SwknrAvMue4z8IwQDnfIS7C4dAIUE8D6MTBuSI
        TchmmS+U2xN96UVExRPZkKqdgBDJuV4HpexZYppF7x90Fp/azYAP4RG/FK+ihZw9+RcMPOc6lKJbb
        0918M0qgnb9VPmscGzQmtBWlAFXzEp561MFwTV/2Aldr8SoEMk4DlcqiqHrPlS2N7xv/WHPKtkInz
        9Zn5COJcEiL1EXqqFP+SaUI5SeOLPANFuORCxuyIops6El+WaLmnA1TRSJ4ubesVQF6Cwg5OX2of2
        4XBWzr8A==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yl-0000cx-0P; Tue, 06 Aug 2019 16:06:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] mm: cleanup the hmm_vma_walk_hugetlb_entry stub
Date:   Tue,  6 Aug 2019 19:05:50 +0300
Message-Id: <20190806160554.14046-13-hch@lst.de>
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

Stub out the whole function and assign NULL to the .hugetlb_entry method
if CONFIG_HUGETLB_PAGE is not set, as the method won't ever be called in
that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 4aa7135f1094..dee99d0cc856 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -767,11 +767,11 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #define hmm_vma_walk_pud	NULL
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
 static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
 {
-#ifdef CONFIG_HUGETLB_PAGE
 	unsigned long addr = start, i, pfn;
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -810,10 +810,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 
 	return ret;
-#else /* CONFIG_HUGETLB_PAGE */
-	return -EINVAL;
-#endif
 }
+#else
+#define hmm_vma_walk_hugetlb_entry NULL
+#endif /* CONFIG_HUGETLB_PAGE */
 
 static void hmm_pfns_clear(struct hmm_range *range,
 			   uint64_t *pfns,
-- 
2.20.1

