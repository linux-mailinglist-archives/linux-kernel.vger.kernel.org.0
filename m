Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1916AC461
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 06:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394249AbfIGED6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 00:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfIGED5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 00:03:57 -0400
Received: from localhost (unknown [194.251.198.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 696492070C;
        Sat,  7 Sep 2019 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567829037;
        bh=GlLbsvCo+oy2TQLeThNPpkAfA0etuDXhcXFlruBQ34U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pieaM6cqi+Uaga3OWCaPxSRG5IKnY7f6jSEhaXdXjS0J5JaiUZhujPz754RfpeleJ
         iWYFEh5CoA9iHA1Kt6mQFTPJD6YwIE6c4tmPVLdHNuyyj+B4XHnSEWiKoyXDlLkyfq
         o2/WzTJa4YS8v7eL/IUr4Lodh6k3UN3eluHEtaBI=
Date:   Sat, 7 Sep 2019 07:03:53 +0300
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 9/9] sunxi_defconfig: add new crypto options
Message-ID: <20190907040353.hrz7gmqgzpfpo4xj@flea>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-10-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906184551.17858-10-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:45:51PM +0200, Corentin Labbe wrote:
> This patch adds the new allwinner crypto configs to sunxi_defconfig
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Can you also enable it in arm64's defconfig as a module?

>
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index df433abfcb02..d0ab8ba7710a 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -150,4 +150,6 @@ CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> +CONFIG_CRYPTO_DEV_ALLWINNER=y
> +CONFIG_CRYPTO_DEV_SUN8I_CE=y
>  CONFIG_CRYPTO_DEV_SUN4I_SS=y
> --
> 2.21.0
>

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
