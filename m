Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFE79101
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfG2Qen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:34:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40498 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfG2Qem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so28534611pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vUjj6N1I6vMTCipD+qtqP93tKHcPzr/XHddLallJiUQ=;
        b=BQkHvxRpF2AAJ+UdBJQXbbI0xM/Y+dARaYo49C03ziIYjkFz5pUP1pQh04+R5Ouyh8
         06mEgzgPvGk/qWvvHfl4pn0hU+pE1OSamQLzLmTH7T/u40C4LYsLNa/aHdaA1+xkB3f5
         hIUIsGBkANMp3WAfzYKV3fmFZOJei+Rp2FsUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUjj6N1I6vMTCipD+qtqP93tKHcPzr/XHddLallJiUQ=;
        b=BSpIusid5Ht3/TZw0jKAJzCS/Hg6r1KUzxFpfLlfg3r6BaJI2Kxsi/K+eTHifIXyis
         5bXRBvXV4XBWMv00+SNgEmEb/dj8lAYLzbcDqQazDuHxfHXCzuC2KNpT+AzW95ZvTegO
         L+W+Of05ZaZwvX3VAxomUCbJQBwKoclKYsxm1CzmsRT2irOhYhAdH6MGA6YsMoi4YPOD
         qwThkTACHmBmPJNZedxAWwvq0C+2bODvN7g9/yHotMwpypJzhUwRyiX4E6H/YHadJMmB
         DLMFx42K6HYB+ddm7DavbGk1zAvAogGc919jT13nsb79tOhsDeWmRbQRLy0NdkCdAKJp
         g4hg==
X-Gm-Message-State: APjAAAVTzwUdXIz8zSda5w5Q6ih9naUoX3nqHFQkkX941yNsQhiL8Gm2
        JwJZqzNJ0cGauXH28qqCc/5nEQ==
X-Google-Smtp-Source: APXvYqx2FkrDdwq2i3WnLGDnQvHrZD/9LANeryz6v82uCSLvbbMEBPBAp1/MW4dWZBLjPOrNhzDhlw==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr106511441pgk.355.1564418081835;
        Mon, 29 Jul 2019 09:34:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c23sm56307412pgj.62.2019.07.29.09.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:34:41 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:34:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM: OMAP: dma: Mark expected switch fall-throughs
Message-ID: <201907290934.B2053972E3@keescook>
References: <20190728232240.GA22393@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728232240.GA22393@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:22:40PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> arch/arm/plat-omap/dma.c: In function 'omap_set_dma_src_burst_mode':
> arch/arm/plat-omap/dma.c:384:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dma_omap2plus()) {
>       ^
> arch/arm/plat-omap/dma.c:393:2: note: here
>   case OMAP_DMA_DATA_BURST_16:
>   ^~~~
> arch/arm/plat-omap/dma.c:394:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dma_omap2plus()) {
>       ^
> arch/arm/plat-omap/dma.c:402:2: note: here
>   default:
>   ^~~~~~~
> arch/arm/plat-omap/dma.c: In function 'omap_set_dma_dest_burst_mode':
> arch/arm/plat-omap/dma.c:473:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dma_omap2plus()) {
>       ^
> arch/arm/plat-omap/dma.c:481:2: note: here
>   default:
>   ^~~~~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/plat-omap/dma.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 79f43acf9acb..08c99413d02c 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -388,17 +388,15 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  		/*
>  		 * not supported by current hardware on OMAP1
>  		 * w |= (0x03 << 7);
> -		 * fall through
>  		 */
> +		/* fall through */
>  	case OMAP_DMA_DATA_BURST_16:
>  		if (dma_omap2plus()) {
>  			burst = 0x3;
>  			break;
>  		}
> -		/*
> -		 * OMAP1 don't support burst 16
> -		 * fall through
> -		 */
> +		/* OMAP1 don't support burst 16 */
> +		/* fall through */
>  	default:
>  		BUG();
>  	}
> @@ -474,10 +472,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  			burst = 0x3;
>  			break;
>  		}
> -		/*
> -		 * OMAP1 don't support burst 16
> -		 * fall through
> -		 */
> +		/* OMAP1 don't support burst 16 */
> +		/* fall through */
>  	default:
>  		printk(KERN_ERR "Invalid DMA burst mode\n");
>  		BUG();
> -- 
> 2.22.0
> 

-- 
Kees Cook
