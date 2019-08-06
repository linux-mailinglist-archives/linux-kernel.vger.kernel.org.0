Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E423D83635
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfHFQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbfHFQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HrWzyj8Xwb8+ibZdNfy7jRFBuLt7LJC7W3wGhE3v6+k=; b=tn2lwfTfokh2Oc5zgMto3Ypnv3
        6iPGcbfNQjgmkUu5mqIUEy9RxUmoQoXg0P7FxJsxuV2BqHEUOHG1ZqrGSY77Pd6zjtOG6Kfvy56LL
        m3DeHaj1r7hN8MK2Z91bk1YSOGvBk4kWiIC+TWAZpScFP1nDvvHRZt0EY0fVphGycnOn6kL6BeVrB
        1ZEVzB+PTNmO7XUSZqoPkpb0bHShNHZF8PKoFc0MtKMY3kUn01xaKVO1LGg6/Iiv1krfGhdfpgyoI
        fiwRrtGmUw7YQTJ+jHCBUcPckkdw/G7pPSJPaJuqBBDwA0N34uvyfuMud/oaFaEHpUJsbW+AcXaEM
        neN8+r1A==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yT-0000Xl-31; Tue, 06 Aug 2019 16:06:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] mm: remove the unused vma argument to hmm_range_dma_unmap
Date:   Tue,  6 Aug 2019 19:05:43 +0300
Message-Id: <20190806160554.14046-6-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 1 -
 mm/hmm.c            | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 82265118d94a..59be0aa2476d 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -422,7 +422,6 @@ long hmm_range_dma_map(struct hmm_range *range,
 		       dma_addr_t *daddrs,
 		       unsigned int flags);
 long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct vm_area_struct *vma,
 			 struct device *device,
 			 dma_addr_t *daddrs,
 			 bool dirty);
diff --git a/mm/hmm.c b/mm/hmm.c
index d66fa29b42e0..3a3852660757 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1121,7 +1121,6 @@ EXPORT_SYMBOL(hmm_range_dma_map);
 /**
  * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dma_map()
  * @range: range being unmapped
- * @vma: the vma against which the range (optional)
  * @device: device against which dma map was done
  * @daddrs: dma address of mapped pages
  * @dirty: dirty page if it had the write flag set
@@ -1133,7 +1132,6 @@ EXPORT_SYMBOL(hmm_range_dma_map);
  * concurrent mmu notifier or sync_cpu_device_pagetables() to make progress.
  */
 long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct vm_area_struct *vma,
 			 struct device *device,
 			 dma_addr_t *daddrs,
 			 bool dirty)
-- 
2.20.1

