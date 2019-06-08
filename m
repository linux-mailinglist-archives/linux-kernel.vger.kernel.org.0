Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739B839C5F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfFHKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 06:21:25 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51230 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989282; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHwp4EaKIApS7gi/29f6skCLdTCv8U5u1pmErrPTMLI=;
        b=pGCnBukmxLAU2uMSE8Ka0VnpptlMtXGRYMwBXdpKjDMYfjAihdVNbK2MRxxmxfwvyZsZEe
        TuuUOO4ul6WcDYTITpPuy/2E6dcWqT9+0PU8xcnjVknKdPr1hrAqN+ADoQshvWaC/la5zQ
        tuxwfMpZ2/uoBxEGoHtxnBnz2r7aTSE=
Date:   Sat, 08 Jun 2019 12:21:18 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: jz4740: Make probe function __init_or_module
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1559989278.1815.4@crapouillou.net>
In-Reply-To: <20190607155751.15778-1-paul@crapouillou.net>
References: <20190607155751.15778-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this patch.


Le ven. 7 juin 2019 =E0 17:57, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/musb/jz4740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 5261f8dfedec..c881f6d14752 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -105,7 +105,7 @@ static const struct musb_platform_ops=20
> jz4740_musb_ops =3D {
>  	.init		=3D jz4740_musb_init,
>  };
>=20
> -static int jz4740_probe(struct platform_device *pdev)
> +static int __init_or_module jz4740_probe(struct platform_device=20
> *pdev)
>  {
>  	struct musb_hdrc_platform_data	*pdata =3D &jz4740_musb_platform_data;
>  	struct platform_device		*musb;
> @@ -174,7 +174,7 @@ static int jz4740_probe(struct platform_device=20
> *pdev)
>  	return ret;
>  }
>=20
> -static int jz4740_remove(struct platform_device *pdev)
> +static int __exit jz4740_remove(struct platform_device *pdev)
>  {
>  	struct jz4740_glue	*glue =3D platform_get_drvdata(pdev);
>=20
> --
> 2.21.0.593.g511ec345e18
>=20

=

