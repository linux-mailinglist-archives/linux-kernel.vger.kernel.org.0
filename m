Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27AED3C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 16:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfKCP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 10:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfKCP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 10:59:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1622084D;
        Sun,  3 Nov 2019 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572796745;
        bh=5+RnA+X1DFWJPbi3N2EMzBO+gOiVypkHZ165PeIF1Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWG5Nqd/lNyPeJDE1peJeV6xeY3rghE7drSUR/g16egfFAw0YK/yf1i4GHeeoMLm8
         ToFyugguVQ8yxO8Z2497awgAOFbj+1ghNNttrrA7AASM6AFlIVjEbtB0ehZRgc4shc
         W5BD9ihnYN7/kjX1XsciBB63T2KSVADotC5b1CXI=
Date:   Sun, 3 Nov 2019 16:59:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rama Kumar <ramakumar.kanasundara@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nishadkamdar@gmail.com
Subject: Re: [PATCH] FBTFT: Changed delay function.
Message-ID: <20191103155903.GA673124@kroah.com>
References: <20191103154003.2739-1-ramakumar.kanasundara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103154003.2739-1-ramakumar.kanasundara@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 09:40:03AM -0600, Rama Kumar wrote:
> 
> Hi,
> 
> Changed udelay() to usleep_range() based on the document in the path, "Documentation/timers/timers-howto.rst". It was suggested to use usleep_range() function for sleeping duration between 10us - 20 ms. original code used udelay() for sleeping 20 us.
>  
> ---
> drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index eeeeec97ad27..471a145e3c00 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpiod_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20,20);
>  	gpiod_set_value(par->gpio.reset, 1);
>  	mdelay(120);
>  }
> -- 
> Signed-off-by: Rama Kumar <ramakumar.kanasundara@gmail.com>

Always run checkptch.pl on patches you send out so you don't get grumpy
maintainers telling you to run checkpatch.pl on your patch :)

thanks,

greg k-h
