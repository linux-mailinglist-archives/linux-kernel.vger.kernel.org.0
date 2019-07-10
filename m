Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAB644CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfGJJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:59:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57505 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:59:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9A9DA8044A; Wed, 10 Jul 2019 11:59:43 +0200 (CEST)
Date:   Wed, 10 Jul 2019 11:59:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <jamesg@zaltys.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.1 29/96] usb: gadget: udc: lpc32xx: allocate descriptor
 with GFP_ATOMIC
Message-ID: <20190710095910.GA7413@xo-6d-61-c0.localdomain>
References: <20190708150526.234572443@linuxfoundation.org>
 <20190708150528.111562688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708150528.111562688@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-08 17:13:01, Greg Kroah-Hartman wrote:
> [ Upstream commit fbc318afadd6e7ae2252d6158cf7d0c5a2132f7d ]
> 
> Gadget drivers may queue request in interrupt context. This would lead to
> a descriptor allocation in that context. In that case we would hit
> BUG_ON(in_interrupt()) in __get_vm_area_node.
> 
> Also remove the unnecessary cast.

GFP_ATOMIC allocations can and do fail, but I don't see any explicit error handling.

Can someone check everything is ok?

Thanks,
									Pavel


> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index b0781771704e..eafc2a00c96a 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -922,8 +922,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
>  	dma_addr_t			dma;
>  	struct lpc32xx_usbd_dd_gad	*dd;
>  
> -	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> +	dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
>  	if (dd)
>  		dd->this_dma = dma;
>  
> -- 
> 2.20.1
> 
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
