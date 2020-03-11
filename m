Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF518105E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 07:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKGGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 02:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKGGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:06:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960F921655;
        Wed, 11 Mar 2020 06:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583906783;
        bh=KN+8Bn3VC9leAlT1f02Os7gMAUM2T74PCNfPOjVGbWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWo4tT1gOx3yAEZEhjPSUV27VP0nWW866DOBe9RFC0C6PJN2Q8MgE3engI4aXxTkO
         Y0QkrjLic3u26gKiuvnnXAovwfMBRrvXkt+cOJ7u7PzU4yi/cMi58QvUGClPhpeDWO
         W9oYXFjWNdxhk0zAd/NCbxO4GpZVw1T6PKT1tSpw=
Date:   Wed, 11 Mar 2020 07:06:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcio Albano <marcio.ahf@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: fbtft: Remove prohibited spaces before ')'
Message-ID: <20200311060620.GB3522362@kroah.com>
References: <20200311012533.26167-1-marcio.ahf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311012533.26167-1-marcio.ahf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:25:33AM +0000, Marcio Albano wrote:
> Fix checkpatch errors:
> 
> "ERROR: space prohibited before that close parenthesis ')'"
> in fbtft-bus.c:65 and fbtft-bus.c:67.
> 
> Signed-off-by: Marcio Albano <marcio.ahf@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67..847cbfbbd 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

Always test-build your patches :(
