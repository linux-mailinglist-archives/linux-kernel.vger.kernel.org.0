Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4921303D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgADSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 13:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgADSLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 13:11:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9CE222C4;
        Sat,  4 Jan 2020 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578161481;
        bh=Ptj9u9fQjF9EMK9Gro45UkvbIInUQxphp5m/v+6NImw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2B78S1hC6LXyJqfrO9ggU9Ty6ZwAGzxexn63SYAAVg6Szlwi5Y5F9XE4qlaHnucY
         hc6fOadlD6vCx+TsjPj//yvDsmxRW6Sgx+nrelhg+cAW7tciBaCUf2pCvxh7Hcii1h
         ExIZ/hN52IPdS+W2IWtyleYnNQk8rU8xilPTfzhM=
Date:   Sat, 4 Jan 2020 19:11:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: remove header include path to
 drivers/staging
Message-ID: <20200104181117.GA1479922@kroah.com>
References: <20200104161827.18960-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104161827.18960-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 01:18:27AM +0900, Masahiro Yamada wrote:
> There is no need to add "ccflags-y += -I $(srctree)/drivers/staging"
> just for including <most/core.h>.
> 
> Use the #include "..." directive with the correct relative path.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/staging/most/Makefile       | 1 -
>  drivers/staging/most/cdev/Makefile  | 1 -
>  drivers/staging/most/cdev/cdev.c    | 3 ++-
>  drivers/staging/most/configfs.c     | 3 ++-
>  drivers/staging/most/core.c         | 3 ++-
>  drivers/staging/most/dim2/Makefile  | 1 -
>  drivers/staging/most/dim2/dim2.c    | 2 +-
>  drivers/staging/most/i2c/Makefile   | 1 -
>  drivers/staging/most/i2c/i2c.c      | 2 +-
>  drivers/staging/most/net/Makefile   | 1 -
>  drivers/staging/most/net/net.c      | 3 ++-
>  drivers/staging/most/sound/Makefile | 1 -
>  drivers/staging/most/sound/sound.c  | 3 ++-
>  drivers/staging/most/usb/Makefile   | 1 -
>  drivers/staging/most/usb/usb.c      | 3 ++-
>  drivers/staging/most/video/Makefile | 1 -
>  drivers/staging/most/video/video.c  | 2 +-
>  17 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
> index 85ea5a434ced..20a99ecb37c4 100644
> --- a/drivers/staging/most/Makefile
> +++ b/drivers/staging/most/Makefile
> @@ -2,7 +2,6 @@
>  obj-$(CONFIG_MOST) += most_core.o
>  most_core-y := core.o
>  most_core-y += configfs.o
> -ccflags-y += -I $(srctree)/drivers/staging/
>  
>  obj-$(CONFIG_MOST_CDEV)	+= cdev/
>  obj-$(CONFIG_MOST_NET)	+= net/

This all was done on purpose to make a follow-on patch much simpler that
I didn't end up taking as it still needed more work.

But I do agree with it, we shouldn't be abusing ccflags here, I'll go
queue this up in a day or so, thanks for this.

greg k-h
