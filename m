Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC043C522
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbfFKHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 03:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfFKHaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:30:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41BF821721;
        Tue, 11 Jun 2019 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560238207;
        bh=dSkXBR/OCEtFzFA8xUYw0p2FJxmWLSoWVqkK+1ttkkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0hiDa8n/fQqJYAnuExr8vtVgb4frORxcZEH5epOHkTE779ih7PtuEEhaEDEyH2m9
         8fSFpiDJ4q3y5NiztDL7WTKzIP2SAGeamb8m+62LSpGvG1s3a0kr9QJdS0od3EmWmY
         K8eRbXyF0EuDdBKj/sGCyFFYdM/8SD6i0WTa3ji0=
Date:   Tue, 11 Jun 2019 09:30:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Daniel Mack <daniel@caiaq.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: lis3lv02d: Switch to SPDX header
Message-ID: <20190611073005.GA11407@kroah.com>
References: <20190611072018.2978605-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611072018.2978605-1-lkundrak@v3.sk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:20:18AM +0200, Lubomir Rintel wrote:
> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/misc/lis3lv02d/lis3lv02d_spi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> index e575475123c8..d7f17c59f3e7 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * lis3lv02d_spi - SPI glue layer for lis3lv02d
>   *
>   * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  publishhed by the Free Software Foundation.
>   */
>  
>  #include <linux/module.h>
> -- 
> 2.21.0
> 

Please always work with the latest kernel tree, this was fixed in
5.2-rc4.

thanks,

greg k-h
