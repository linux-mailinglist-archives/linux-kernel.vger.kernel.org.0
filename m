Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6345E920
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGCQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGCQcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:32:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB002187F;
        Wed,  3 Jul 2019 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562171554;
        bh=8hkx9D6cVHuLlyuoRR6plS3cZoqyazckirKKEEaVDhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlXDW6vx8wTFxhwAjRJH4wSDIXbJZ3SjmBvcvttiyLCS63EFVOW8+dJPOytcTUxD4
         dIv7CTcdJKQrr2CVJHK32yAfvGXwaHezOLLG7CvxC4ztyPsXl7CsCKC3nJ3+MiTBtk
         vwyZ4dKaKJ/Y08WQBFNAg/BcSzS9zX0nRZy79KOk=
Date:   Wed, 3 Jul 2019 18:32:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     fatihaltinpinar@gmail.com
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Staging: mt7621-dma: mtk-hsdma: fix a coding style issue
Message-ID: <20190703163232.GA29325@kroah.com>
References: <20190702080632.27470-1-fatihaltinpinar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702080632.27470-1-fatihaltinpinar@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:06:32AM +0300, fatihaltinpinar@gmail.com wrote:
> From: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
> 
> Fixed a coding style issue. Removed curly brackets of an one
> line if statement.
> 
> Signed-off-by: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> index 0fbb9932d6bb..a58725dd2611 100644
> --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> @@ -664,9 +664,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	hsdma = devm_kzalloc(&pdev->dev, sizeof(*hsdma), GFP_KERNEL);
> -	if (!hsdma) {
> +	if (!hsdma)
>  		return -EINVAL;
> -	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);

This change is already in my tree, always be sure to work against the
proper kernel tree for doing new development.

thanks,

greg k-h
