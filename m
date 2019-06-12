Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87F42A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440029AbfFLPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439907AbfFLPKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8529C2082C;
        Wed, 12 Jun 2019 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560352233;
        bh=iAlfPhH3vjfdnREbF2DGNOK6HWcjZ/QZ1kmiH8Yo6JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWv/5AVhfagi241tNO0tjdnWXskJPJOEy+yWY1JtTig6WdcbsqzjUb9lg5FtDRztn
         V53kBGKN3Ng76/W9rvHbNqWMKQRq2YytVVBuiqszSLBtzauiHovSv/PexzEF8SpI5A
         qhxRM0VKfWRzi5xhub8C98MtxdPGxQsMp7RtDyB0=
Date:   Wed, 12 Jun 2019 17:10:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     linux-kernel@vger.kernel.org, adurbin@chromium.org,
        groeck@chromium.org, dlaurie@chromium.org
Subject: Re: [PATCH] gsmi: Replace printk with relevant pr_<level>
Message-ID: <20190612151029.GA21343@kroah.com>
References: <20190612142727.GA1710@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612142727.GA1710@ahmlpt0706>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:57:27PM +0530, Saiyam Doshi wrote:
> >From 3a9cec48147b24fd9d793e0fdf20058461445646 Mon Sep 17 00:00:00 2001
> From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
> Date: Tue, 11 Jun 2019 19:21:50 +0530
> Subject: [PATCH] gsmi: Replace printk with relevant pr_<level>


Why is all of this in the changelog body?

Please just use 'git send-email' if you can not use a decent email
client.

> Replace printk() with pr_* macros for logging consistency.
> This also helps avoid checkpatch warnings.
> 
> Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
> ---
>  drivers/firmware/google/gsmi.c | 59 ++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index edaa4e5d84ad..e4e7f04bced8 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -151,7 +151,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
>  
>  	smibuf = kzalloc(sizeof(*smibuf), GFP_KERNEL);
>  	if (!smibuf) {
> -		printk(KERN_ERR "gsmi: out of memory\n");
> +		pr_err("gsmi: out of memory\n");

This message is not needed at all, checkpatch should have warned you
about that.

>  		return NULL;
>  	}
>  
> @@ -159,7 +159,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
>  	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
>  				       &smibuf->handle);
>  	if (!smibuf->start) {
> -		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
> +		pr_err("gsmi: failed to allocate name buffer\n");
>  		kfree(smibuf);
>  		return NULL;
>  	}
> @@ -257,34 +257,33 @@ static int gsmi_exec(u8 func, u8 sub)
>  		rc = 1;
>  		break;
>  	case GSMI_INVALID_PARAMETER:
> -		printk(KERN_ERR "gsmi: exec 0x%04x: Invalid parameter\n", cmd);
> +		pr_err("gsmi: exec 0x%04x: Invalid parameter\n", cmd);

why not dev_err() for all of these?  It's a driver, you should have a
device, use it so that the user has a chance to know what device is
acting up.

thanks,

greg k-h
