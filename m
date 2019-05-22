Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6465F264CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfEVNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 09:34:24 -0400
Received: from verein.lst.de ([213.95.11.211]:39603 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:34:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2550C67358; Wed, 22 May 2019 15:34:01 +0200 (CEST)
Date:   Wed, 22 May 2019 15:34:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190522133400.GA27229@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com> <20190522123243.GA26390@lst.de> <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com> <20190522130921.GA26874@lst.de> <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:25:38PM +0100, Robin Murphy wrote:
> Sure, but that should be irrelevant since the effective problem here is in 
> the sync_*_for_cpu direction, and it's the unmap which nobbles the buffer. 
> If the driver does this:
>
> 	dma_map_single(whole buffer);
> 	<device writes to part of buffer>
> 	dma_unmap_single(whole buffer);
> 	<contents of rest of buffer now undefined>
>
> then it could instead do this and be happy:
>
> 	dma_map_single(whole buffer, SKIP_CPU_SYNC);
> 	<device writes to part of buffer>
> 	dma_sync_single_for_cpu(updated part of buffer);
> 	dma_unmap_single(whole buffer, SKIP_CPU_SYNC);
> 	<contents of rest of buffer still valid>

Assuming the driver knows how much was actually DMAed this would
solve the issue.  Horia, does this work for you?
