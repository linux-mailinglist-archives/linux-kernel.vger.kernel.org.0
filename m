Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3993FCDC72
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfJGHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 03:34:53 -0400
Received: from verein.lst.de ([213.95.11.211]:35373 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfJGHex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:34:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D08CD68B20; Mon,  7 Oct 2019 09:34:48 +0200 (CEST)
Date:   Mon, 7 Oct 2019 09:34:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007073448.GA882@lst.de>
References: <20191007022454.GA5270@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007022454.GA5270@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

can you try the patch below?


diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..52b709bf2b55 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static u64 intel_get_required_mask(struct device *dev)
+{
+	if (!iommu_need_mapping(dev))
+		return dma_direct_get_required_mask(dev);
+	return DMA_BIT_MASK(32);
+}
+
 static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
@@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
 	.dma_supported = dma_direct_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
+	.get_required_mask = intel_get_required_mask,
 };
 
 static void
