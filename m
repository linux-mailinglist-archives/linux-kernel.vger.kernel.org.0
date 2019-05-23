Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB722845B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfEWQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 12:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731299AbfEWQ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:57:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3E62070D;
        Thu, 23 May 2019 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558630320;
        bh=TCw7cKoRb0mNvs2XUEnU4+3yGCOFVTVy1RJc0z1Ogw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yaCvTrdue+ruF5/+/4uQDCzrgFwtbSrks+PtpQpAJ8fQNoyl0AZFXYR41m8P0b6AZ
         RWHVm1Q2EQImnFPXFOU+0KUkHzWCf4dmAQNDWr/n6M1YR0tltL3ICmW0M02M3o0A6A
         GU5rSksqUXUmyhJn9xel9Ex9paNHOFXzYT6bmb2A=
Date:   Thu, 23 May 2019 18:51:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     christian.gromm@microchip.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: usb: Remove variable frame_size
Message-ID: <20190523165157.GA19908@kroah.com>
References: <20190523132334.29611-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523132334.29611-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:53:34PM +0530, Nishka Dasgupta wrote:
> Remove variable frame_size as its multiple usages are all independent of
> each other and so can be returned separately.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/most/usb/usb.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
> index 360cb5b7a10b..751e82cf66c5 100644
> --- a/drivers/staging/most/usb/usb.c
> +++ b/drivers/staging/most/usb/usb.c
> @@ -186,32 +186,28 @@ static inline int start_sync_ep(struct usb_device *usb_dev, u16 ep)
>   */
>  static unsigned int get_stream_frame_size(struct most_channel_config *cfg)
>  {
> -	unsigned int frame_size = 0;
>  	unsigned int sub_size = cfg->subbuffer_size;
>  
>  	if (!sub_size) {
>  		pr_warn("Misconfig: Subbuffer size zero.\n");
> -		return frame_size;
> +		return 0;
>  	}
>  	switch (cfg->data_type) {
>  	case MOST_CH_ISOC:
> -		frame_size = AV_PACKETS_PER_XACT * sub_size;
> -		break;
> +		return AV_PACKETS_PER_XACT * sub_size;
>  	case MOST_CH_SYNC:
>  		if (cfg->packets_per_xact == 0) {
>  			pr_warn("Misconfig: Packets per XACT zero\n");
> -			frame_size = 0;
> +			return 0;
>  		} else if (cfg->packets_per_xact == 0xFF) {
> -			frame_size = (USB_MTU / sub_size) * sub_size;
> +			return (USB_MTU / sub_size) * sub_size;
>  		} else {
> -			frame_size = cfg->packets_per_xact * sub_size;
> +			return cfg->packets_per_xact * sub_size;
>  		}
> -		break;
>  	default:
>  		pr_warn("Query frame size of non-streaming channel\n");
> -		break;
> +		return 0;
>  	}
> -	return frame_size;
>  }

Now it just feels like you are doing "busy work" :(

frame_size makes sense here, right?  Why change this code?

Remember, code is written for developers first, the compiler second.
Reading this with frame_size makes it much more obvious what this code
does when you read it again in 5-10 years.  Why change this, you have
not made it faster, or smaller at all.

So no, I would not accept this, sorry.

We have so many _real_ things to do in the drivers/staging/ directory if
you are looking for stuff to clean up.  Don't try to micro-optimize
things that do not matter at the expense of understanding.

thanks,

greg k-h
