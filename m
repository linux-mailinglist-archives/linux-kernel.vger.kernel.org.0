Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB7181943
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 14:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgCKNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 09:10:09 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40383 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgCKNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:10:08 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03E7E23E68;
        Wed, 11 Mar 2020 14:10:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583932205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAA7KgLyLRLoYnDJlQStIPFh8C+EewIWjpAD8ZGuqRA=;
        b=jsXNM2wqYJpN/1wVlSTmmSoTtG9YSiVhax7XZQR/7UJqJqTS5sAj7Y2xen4E2VaQBtwcrA
        XJi7rd1OOu2MMSB56DCfEXzdveqkfrLYpfu2CObTktWidvgJ94BF2rpIOhadyjI9PkLc/a
        pkR0//E1A/CIBWYoBz2kP58g8s+KEVc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 14:10:04 +0100
From:   Michael Walle <michael@walle.cc>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] mfd: mfd-core: inherit only valid dma_masks/flags
 from parent
In-Reply-To: <5f167c37-566f-bd62-b0fd-fdb7925c5afd@arm.com>
References: <20200310230935.23962-1-michael@walle.cc>
 <5f167c37-566f-bd62-b0fd-fdb7925c5afd@arm.com>
Message-ID: <68db76c663170817c223fcf779a92d28@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.10
X-Rspamd-Server: web
X-Spam-Score: -0.10
X-Rspamd-Queue-Id: 03E7E23E68
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.662];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-03-11 12:25, schrieb Robin Murphy:
> On 2020-03-10 11:09 pm, Michael Walle wrote:
>> Only copy the dma_masks and flags from the parent device, if the 
>> parent
>> has a valid dma_mask/flags. Commit cdfee5623290 ("driver core:
>> initialize a default DMA mask for platform device") initialize the DMA
>> masks of a platform device. But if the parent doesn't have a dma_mask
>> set, for example if it's an I2C device, the dma_mask of the child
>> platform device will be set to zero again. Which leads to many "DMA 
>> mask
>> not set" warnings, if the MFD cell has the of_compatible property set.
>> 
>> [    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
>> [    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
>> [    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set
>> 
>> Thus a MFD child should just inherit valid dma_masks and keep the
>> platform default otherwise.
>> 
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> 
>> Hi,
>> 
>> I don't know if that is the correct way of handling things. Maybe I'm
>> also doing something wrong in my driver, I had a look at other I2C MFD
>> drivers but couldn't find a clue why they shouldn't have the same
>> problem.
> 
> The underlying issue is that about 99% of MFD children should not be
> going through dma_configure() at all because their parent 'real'
> device is not on a DMA-capable bus, but as they are platform devices
> we are forced to give them the benefit of the doubt. For DT systems
> the only vaguely-reasonable heuristic to distinguish between
> "platform" meaning "SoC memory-mapped device" and "platform" meaning
> "random crap made up by Linux" is whether the device has a populated
> OF node, but MFD's trick of hanging the parent device's OF node onto
> its synthesised children kicks a hole right through even that.

Thanks for the explanation.

> Modulo any other concerns with the existing code, does the change
> below make things work the way you want? It's still a bit of a bodge,
> but short of invasive large-scale changes with bus types I don't see a
> way to do the 'right' thing :/
> 
> Robin.
> 
> ----->8-----
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index f5a73af60dd4..1e4a6e8bd630 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, 
> int id,
> 
>  	pdev->dev.parent = parent;
>  	pdev->dev.type = &mfd_dev_type;
> -	pdev->dev.dma_mask = parent->dma_mask;
> +	pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;

That works.

-michael

>  	pdev->dev.dma_parms = parent->dma_parms;
>  	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
