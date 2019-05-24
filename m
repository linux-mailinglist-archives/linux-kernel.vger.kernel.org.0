Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18482290DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfEXGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:20:01 -0400
Received: from verein.lst.de ([213.95.11.211]:51576 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfEXGUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:20:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ADBB268AFE; Fri, 24 May 2019 08:19:36 +0200 (CEST)
Date:   Fri, 24 May 2019 08:19:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     airlied@linux.ie, daniel@ffwll.ch, thellstrom@vmware.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: fix a warning due to missing dma_parms
Message-ID: <20190524061936.GA2337@lst.de>
References: <20190524023719.1495-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524023719.1495-1-cai@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:37:19PM -0400, Qian Cai wrote:
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index bf6c3500d363..5c567b81174f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -747,6 +747,13 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
>  	if (unlikely(ret != 0))
>  		goto out_err0;
>  
> +	dev->dev->dma_parms =  kzalloc(sizeof(*dev->dev->dma_parms),
> +				       GFP_KERNEL);
> +	if (!dev->dev->dma_parms)
> +		goto out_err0;

What bus does this device come from?  I though vmgfx was a (virtualized)
PCI device, in which case this should be provided by the PCI core.
Or are we calling DMA mapping routines on arbitrary other struct device,
in which case that is the real bug and we should switch the PCI device
instead.

> +	dma_set_max_seg_size(dev->dev, *dev->dev->dma_mask);

That looks odd.  If you want to support an unlimited segment size
just pass UINT_MAX here.
