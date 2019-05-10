Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476441A0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfEJP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 11:59:58 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:59606 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727346AbfEJP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:59:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 426E0181D396A;
        Fri, 10 May 2019 15:59:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2904:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3874:4321:5007:6691:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12296:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: plot02_906f77e1ab355
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 May 2019 15:59:52 +0000 (UTC)
Message-ID: <82974f50ad02342abd59b800a802f7adecabc0b9.camel@perches.com>
Subject: Re: [PATCH] usb: gadget: udc: lpc32xx: allocate descriptor with
 GFP_ATOMIC
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <james.grant@jci.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 May 2019 08:59:51 -0700
In-Reply-To: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
References: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 14:42 +0200, Alexandre Belloni wrote:
> Gadget drivers may queue request in interrupt context. This would lead to
> a descriptor allocation in that context. In that case we would hit
> BUG_ON(in_interrupt()) in __get_vm_area_node.
[]
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
[]
> @@ -938,7 +938,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
>  	struct lpc32xx_usbd_dd_gad	*dd;
>  
>  	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> +			udc->dd_cache, (GFP_ATOMIC | GFP_DMA), &dma);

trivia:

This could fit nicely on a single line without the
unnecessary cast and the unnecessary parentheses
around the GFP_ types.


