Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101625BB65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 14:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGAMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 08:22:02 -0400
Received: from 8bytes.org ([81.169.241.247]:33650 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfGAMWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:22:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 82844229; Mon,  1 Jul 2019 14:22:00 +0200 (CEST)
Date:   Mon, 1 Jul 2019 14:21:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190701122158.GE8166@8bytes.org>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622043814.5003-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:38:14PM -0700, Nicolin Chen wrote:
> The max_len is a u32 type variable so the calculation on the
> left hand of the last if-condition will potentially overflow
> when a cur_len gets closer to UINT_MAX -- note that there're
> drivers setting max_seg_size to UINT_MAX:
>   drivers/dma/dw-edma/dw-edma-core.c:745:
>     dma_set_max_seg_size(dma->dev, U32_MAX);
>   drivers/dma/dma-axi-dmac.c:871:
>     dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>   drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
>     dma_set_max_seg_size(dev, 0xffffffff);
>   drivers/nvme/host/pci.c:2520:
>     dma_set_max_seg_size(dev->dev, 0xffffffff);
> 
> So this patch just casts the cur_len in the calculation to a
> size_t type to fix the overflow issue, as it's not necessary
> to change the type of cur_len after all.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Looks good to me, but I let Robin take a look too before I apply it,
Robin?

