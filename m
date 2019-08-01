Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6697DD6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfHAOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:08:25 -0400
Received: from verein.lst.de ([213.95.11.211]:43788 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfHAOIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:08:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7FDE168AFE; Thu,  1 Aug 2019 16:08:20 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:08:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, phill@raspberryi.org,
        f.fainelli@gmail.com, will@kernel.org, robh+dt@kernel.org,
        eric@anholt.net, mbrugger@suse.com, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] mm: comment arm64's usage of 'enum zone_type'
Message-ID: <20190801140820.GC23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de> <20190731154752.16557-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731154752.16557-9-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:47:51PM +0200, Nicolas Saenz Julienne wrote:
> +	 * Architecture			Limit
> +	 * ----------------------------------
> +	 * parisc, ia64, sparc, arm64	<4G
> +	 * s390, powerpc		<2G
> +	 * arm				Various
> +	 * alpha			Unlimited or 0-16MB.
>  	 *
>  	 * i386, x86_64 and multiple other arches
> -	 * 			<16M.
> +	 *				<16M.

powerpc is also Various now, arm64 isn't really < 4G, ia64 only uses
ZONE_DMA32 these days, and parisc doesn't seem to use neither ZONE_DMA
nor ZONE_DMA32.

Based on that I'm not sure the list really makes much sense.

>  	 */
>  	ZONE_DMA,
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
>  	/*
> -	 * x86_64 needs two ZONE_DMAs because it supports devices that are
> -	 * only able to do DMA to the lower 16M but also 32 bit devices that
> -	 * can only do DMA areas below 4G.
> +	 * x86_64 and arm64 need two ZONE_DMAs because they support devices
> +	 * that are only able to DMA a fraction of the 32 bit addressable
> +	 * memory area, but also devices that are limited to that whole 32 bit
> +	 * area.
>  	 */
>  	ZONE_DMA32,

Maybe just say various architectures instead of mentioning specific
ones?  Something like "Some 64-bit platforms need.."
