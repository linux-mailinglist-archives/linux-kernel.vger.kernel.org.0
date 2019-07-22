Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B2703B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGVP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 11:26:40 -0400
Received: from verein.lst.de ([213.95.11.211]:33275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfGVP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:26:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C11868B20; Mon, 22 Jul 2019 17:26:38 +0200 (CEST)
Date:   Mon, 22 Jul 2019 17:26:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
 against NULL dma_mask
Message-ID: <20190722152637.GA3780@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-2-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> +			dma_get_required_mask(dev);

This should really use a separate if statement, but I can fix that
up when applying it.
