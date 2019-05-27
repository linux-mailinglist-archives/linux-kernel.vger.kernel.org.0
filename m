Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34302B871
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfE0Phz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 11:37:55 -0400
Received: from 8bytes.org ([81.169.241.247]:40386 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfE0Phy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:37:54 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3162D244; Mon, 27 May 2019 17:37:53 +0200 (CEST)
Date:   Mon, 27 May 2019 17:37:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: implement generic dma_map_ops for IOMMUs v5
Message-ID: <20190527153751.GF12745@8bytes.org>
References: <20190520072948.11412-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520072948.11412-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Hi Robin,

On Mon, May 20, 2019 at 09:29:24AM +0200, Christoph Hellwig wrote:
> I think we are finally ready for the generic dma-iommu series.  I have
> various DMA API changes pending, and Tom has patches ready to convert
> the AMD and Intel iommu drivers over to it.  I'd love to have this
> in a stable branch shared between the dma-mapping and iommu trees
> the day after rc2 is released.  I volunteer to create the branch,
> but I'm fine with it living in the iommu tree as well.  Before that
> Will has already said he wants to send the first patch in the series
> to Linus for this merge window.

First a big "THANK YOU" for working on this and getting it ready. It is
an important step towards generic dma-ops for all iommu drivers,
something I wished to have for years and planned to work on myself, but
didn't find the time.

I applied this series to a new generic-dma-ops branch in the iommu
tree and plan to send it upstream in the next merge window.

Thanks again,

       Joerg
