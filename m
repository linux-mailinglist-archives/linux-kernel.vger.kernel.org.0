Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4782ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 07:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfHFFXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 01:23:30 -0400
Received: from verein.lst.de ([213.95.11.211]:53115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731625AbfHFFX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:23:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A815768B05; Tue,  6 Aug 2019 07:23:25 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:23:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] dma-direct: don't truncate dma_required_mask to bus
 addressing capabilities
Message-ID: <20190806052325.GB13409@lst.de>
References: <20190805155153.11021-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805155153.11021-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:51:53PM +0200, Lucas Stach wrote:
> The dma required_mask needs to reflect the actual addressing capabilities
> needed to handle the whole system RAM. When truncated down to the bus
> addressing capabilities dma_addressing_limited() will incorrectly signal
> no limitations for devices which are restricted by the bus_dma_mask.
> 
> Fixes: b4ebe6063204 (dma-direct: implement complete bus_dma_mask handling)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Yeah, this looks sensible.  Atish, can you check if this helps on the
HiFive board as well?
