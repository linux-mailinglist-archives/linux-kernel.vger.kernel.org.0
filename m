Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726261583CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBJTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 14:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBJTds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:33:48 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE0320661;
        Mon, 10 Feb 2020 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581363227;
        bh=WC0L2aDucw6QUrcSWcQAQMpgXu/HX1CGii9MKxTZRJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iwb7scDSAXUg2EQYKdcIWWjPQOeN/boFWyQ/3192MLHLClkTYL5zD3Bo0pGD2hSGk
         6lXXYVSFSnrfdXujHSYIZdBgCYD+/FRiIOZxZY3yESF87SjaJNMp9K80s1/ZRImiqT
         3buqVvrkyXDSvcYr1Hxmrqo7c4Xntuth2gZ/5PGo=
Date:   Mon, 10 Feb 2020 11:33:46 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jiri Slaby <jslaby@suse.com>, Paul Burton <paulburton@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_ioc3: Fix ioremap call
Message-ID: <20200210193346.GA1177382@kroah.com>
References: <20200204113912.14048-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204113912.14048-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:39:12PM +0100, Thomas Bogendoerfer wrote:
> Commit 4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
> removed devm_ioremap_nocache, but 8250_ioc3 wasn't upstream at that
> time. So fix 8250_ioc3 by using devm_ioremap.
> 
> Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/tty/serial/8250/8250_ioc3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
> index 4c405f1b9c67..d5a39e105a76 100644
> --- a/drivers/tty/serial/8250/8250_ioc3.c
> +++ b/drivers/tty/serial/8250/8250_ioc3.c
> @@ -47,7 +47,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	membase = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
> +	membase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>  	if (!membase)
>  		return -ENOMEM;

Looks like Linus already fixed this in b0ef7cda8d9b ("Fix up remaining
devm_ioremap_nocache() in SGI IOC3 8250 UART driver")


