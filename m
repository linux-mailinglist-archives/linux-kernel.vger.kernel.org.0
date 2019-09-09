Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35A9AD622
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbfIIJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 05:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfIIJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:56:28 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFE12086D;
        Mon,  9 Sep 2019 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568022988;
        bh=gZ0748sBch7IpXH/kLfqLXjMbt6zIXw46guvy3EAtDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJBfDih22n1GvUOnHveq2BfLBrerPWSYxwXF3/rHjEIxO+Qs1MJL6JrubcX6uzbcV
         6y2swciZuLTWVPnyuF5ahYPPmm1oCR1YvyW+7aOIw7pyEIoyi4YZGiZKfSj/PMPNzJ
         qBn+WvWXaW1cWPgSrRBzz5yGOsltDF8WKP3VAe8Y=
Date:   Mon, 9 Sep 2019 10:56:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sreeram Veluthakkal <srrmvlt@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        nishadkamdar@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, payal.s.kshirsagar.98@gmail.com
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-ID: <20190909095625.GB17624@kroah.com>
References: <20190909012605.15051-1-srrmvlt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909012605.15051-1-srrmvlt@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> This patch fixes the issue:
> FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +       udelay(20);
> 
> Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index eeeeec97ad27..2dece71fd3b5 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpiod_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20, 40);

Is it "safe" to wait 40?  This kind of change you can only do if you
know this is correct.  Have you tested this with hardware?

thanks,

greg k-h
