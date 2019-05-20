Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2822F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfETIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfETIsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:48:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD81E206BA;
        Mon, 20 May 2019 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342133;
        bh=NcGHUP5bfjC+KvBqbjpW3Rz+kDpoXWvwotRjq0NhZes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE9NkMdtE28blg0UokXhR1YvVgQAauR4AcLN+luyqhyUXtYu9J9qrZO/TytqsOQe8
         WrV/rGyWHaB74clMMqKclgBcIRI2ALkWmg7/p9EOv9tD1JFpeEss3X+nnAxqHLtgAD
         R7EPilrv+UyoNe/DOEIrOkU/bfSkaFas5p2ONIt4=
Date:   Mon, 20 May 2019 10:48:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moses Christopher <moseschristopherb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        david.kershner@unisys.com, forest@alittletooquiet.net,
        davem@davemloft.net, ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com,
        arnd@arndb.de, christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com
Subject: Re: [PATCH v1 5/6] staging: rtl8723bs: use help instead of
 ---help--- in Kconfig
Message-ID: <20190520084850.GA703@kroah.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
 <20190518063341.11178-6-moseschristopherb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518063341.11178-6-moseschristopherb@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 12:03:40PM +0530, Moses Christopher wrote:
>   - Resolve the following warning from the Kconfig,
>     "WARNING: prefer 'help' over '---help---' for new help texts"
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
> ---
>  drivers/staging/rtl8723bs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
> index 744091d46f4c..a88467334dac 100644
> --- a/drivers/staging/rtl8723bs/Kconfig
> +++ b/drivers/staging/rtl8723bs/Kconfig
> @@ -5,7 +5,7 @@ config RTL8723BS
>  	depends on m
>  	select WIRELESS_EXT
>  	select WEXT_PRIV
> -	---help---
> +	help
>  	This option enables support for RTL8723BS SDIO drivers, such as
>  	the wifi found on the 1st gen Intel Compute Stick, the CHIP
>  	and many other Intel Atom and ARM based devices.

No indentation here?  Why not?

thanks,

greg k-h
