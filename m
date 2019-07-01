Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CFB4E0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFUHAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 03:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfFUHAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:00:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D682083B;
        Fri, 21 Jun 2019 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561100441;
        bh=zClx4AqHl0gMIQrc/v1hyIHp40/LhtEQJ7h/y0NBjzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcmgNr6TnwvVuGRCXjGPEUoRO/6QLS6GBHc9NchMjTxgY6Ribxum5iIMRDNOVuBd0
         SeB9SdOdletFA5JbexgMIdmgP6KG1ANWR16iMEQAgDNEP6RQdWMZhscBYUqsZV/4nu
         sL+KjsZTxxeoMzDFX+PyacDvswzBQMb0TdTckrCg=
Date:   Fri, 21 Jun 2019 09:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: Fix build error
Message-ID: <20190621070038.GA3029@kroah.com>
References: <20190621034221.36708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621034221.36708-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:42:21AM +0800, YueHaibing wrote:
> when CRYPTO is m and KS7010 is y, building fails:
> 
> drivers/staging/ks7010/ks_hostif.o: In function `michael_mic.constprop.13':
> ks_hostif.c:(.text+0x560): undefined reference to `crypto_alloc_shash'
> ks_hostif.c:(.text+0x580): undefined reference to `crypto_shash_setkey'
> ks_hostif.c:(.text+0x5e0): undefined reference to `crypto_destroy_tfm'
> ks_hostif.c:(.text+0x614): undefined reference to `crypto_shash_update'
> ks_hostif.c:(.text+0x62c): undefined reference to `crypto_shash_update'
> ks_hostif.c:(.text+0x648): undefined reference to `crypto_shash_finup'
> 
> select CRYPTO and CRYPTO_HASH to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC implementation.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/ks7010/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
> index 0987fdc..6a20e64 100644
> --- a/drivers/staging/ks7010/Kconfig
> +++ b/drivers/staging/ks7010/Kconfig
> @@ -5,6 +5,8 @@ config KS7010
>  	select WIRELESS_EXT
>  	select WEXT_PRIV
>  	select FW_LOADER
> +	select CRYPTO
> +	select CRYPTO_HASH

selects are horrible.  can we do a depends on instead?

thanks,

greg k-h
