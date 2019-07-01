Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A591127A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfECGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfECGWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:22:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA57206DF;
        Fri,  3 May 2019 06:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556864562;
        bh=SFt2Q6o5JVBgeAkxde1y5TMHPH00koLmrDQtDt0camY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDKahD+guA0fw30UkXo4tzV6udAMS07Ak9mvvJJvUo+JXwGJXLjtE1RYa6QSuDPFe
         fFIEQm3q9knlg47iCdZpbZraaDipuxAIQCtazCRHVsvwPZD42gOPwJFwxg3ogxK4Dk
         Et39TcyRpA1YxOzwFjfEUxttHxjIEMjqobLSqkqQ=
Date:   Fri, 3 May 2019 08:22:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: kpc_spi: Fix build error for
 {read,write}q
Message-ID: <20190503062239.GB319@kroah.com>
References: <20190503020630.15778-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503020630.15778-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:06:30PM -0700, Nathan Chancellor wrote:
> drivers/staging/kpc2000/kpc_spi/spi_driver.c:158:11: error: implicit
> declaration of function 'readq' [-Werror,-Wimplicit-function-declaration]
> drivers/staging/kpc2000/kpc_spi/spi_driver.c:167:5: error: implicit
> declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
> 
> Same as commit 91b6cb7216cd ("staging: kpc2000: fix up build problems
> with readq()").
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc_spi/spi_driver.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/kpc2000/kpc_spi/spi_driver.c b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> index 074a578153d0..3ace4e5c1284 100644
> --- a/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> +++ b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> -- 
> 2.21.0

Ah, good catch, I missed this file, sorry.

greg k-h
