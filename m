Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28DE186B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgCPMsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:48:54 -0400
Received: from verein.lst.de ([213.95.11.211]:54177 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbgCPMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:48:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1452368CEC; Mon, 16 Mar 2020 13:48:50 +0100 (CET)
Date:   Mon, 16 Mar 2020 13:48:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316124850.GB17386@lst.de>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314000007.13778-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:00:07PM -0700, Nicolin Chen wrote:
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>  {
>  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>  		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return (unsigned long)dma_get_mask(dev);

Just thinking out loud after my reply - shouldn't we just return ULONG_MAX
by default here to mark this as no limit?
