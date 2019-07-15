Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0669C58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfGOUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:08:15 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60173 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfGOUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:08:14 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2BAE9100009;
        Mon, 15 Jul 2019 20:07:17 +0000 (UTC)
Date:   Mon, 15 Jul 2019 22:07:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <jamesg@zaltys.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.1 29/96] usb: gadget: udc: lpc32xx: allocate descriptor
 with GFP_ATOMIC
Message-ID: <20190715200717.GI4732@piout.net>
References: <20190708150526.234572443@linuxfoundation.org>
 <20190708150528.111562688@linuxfoundation.org>
 <20190710095910.GA7413@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710095910.GA7413@xo-6d-61-c0.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2019 11:59:10+0200, Pavel Machek wrote:
> On Mon 2019-07-08 17:13:01, Greg Kroah-Hartman wrote:
> > [ Upstream commit fbc318afadd6e7ae2252d6158cf7d0c5a2132f7d ]
> > 
> > Gadget drivers may queue request in interrupt context. This would lead to
> > a descriptor allocation in that context. In that case we would hit
> > BUG_ON(in_interrupt()) in __get_vm_area_node.
> > 
> > Also remove the unnecessary cast.
> 
> GFP_ATOMIC allocations can and do fail, but I don't see any explicit error handling.
> 
> Can someone check everything is ok?
> 

It is checked later on:

		dd = udc_dd_alloc(udc);
		if (!dd) {
			/* Error allocating DD */
			return -ENOMEM;
		}

> Thanks,
> 									Pavel
> 
> 
> > diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> > index b0781771704e..eafc2a00c96a 100644
> > --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> > +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> > @@ -922,8 +922,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
> >  	dma_addr_t			dma;
> >  	struct lpc32xx_usbd_dd_gad	*dd;
> >  
> > -	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> > -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> > +	dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
> >  	if (dd)
> >  		dd->this_dma = dma;
> >  
> > -- 
> > 2.20.1
> > 
> > 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
