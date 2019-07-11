Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8323264ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfGJQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 12:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfGJQfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:35:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD06020844;
        Wed, 10 Jul 2019 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562776542;
        bh=h/1uTzMKlOKJst3NnJsnh16b5AsNQV/yJCBKBWrsTYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPyYp5EjnSzmapw3Ny/7iPEEjt/QnJCQo/tjOyrX0IsAhyQf7f2ydIwvecZcNCuNF
         cpnY82hOHXiPKo0eoHuwWg5XCg2/Cp0kd/2aK3F/mZ0YCHiWOwy03KzYkxtP3Qhuct
         xwOr3YDFSugMAU0iT5At+tdaWY28lkCxo/ofJ8i4=
Date:   Wed, 10 Jul 2019 18:35:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, David Lin <dtwlin@gmail.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add logging statement when kfifo_alloc
 fails
Message-ID: <20190710163538.GA30902@kroah.com>
References: <20190710122018.2250-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710122018.2250-1-iamkeyur96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:20:17AM -0400, Keyur Patel wrote:
> Added missing logging statement when kfifo_alloc fails, to improve
> debugging.
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> ---
>  drivers/staging/greybus/uart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index b3bffe91ae99..86a395ae177d 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -856,8 +856,10 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
>  
>  	retval = kfifo_alloc(&gb_tty->write_fifo, GB_UART_WRITE_FIFO_SIZE,
>  			     GFP_KERNEL);
> -	if (retval)
> +	if (retval) {
> +		pr_err("kfifo_alloc failed\n");
>  		goto exit_buf_free;
> +	}

You should have already gotten an error message from the log if this
fails, from the kmalloc_array() call failing, right?

So why is this needed?  We have been trying to remove these types of
messages and keep them in the "root" place where the failure happens.

thanks,

greg k-h
