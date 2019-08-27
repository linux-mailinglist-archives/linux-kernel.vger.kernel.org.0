Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F759E87B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfH0M5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:57:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbfH0M5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:57:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A1D90A53E12960B49B43;
        Tue, 27 Aug 2019 20:57:44 +0800 (CST)
Received: from localhost (10.47.86.181) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 20:57:35 +0800
Date:   Tue, 27 Aug 2019 13:57:22 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Mao Wenan <maowenan@huawei.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <wangzhou1@hisilicon.com>, <liguozhu@hisilicon.com>,
        <john.garry@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] crypto: hisilicon: select CRYPTO_LIB_DES while
 compiling SEC driver
Message-ID: <20190827135722.00000e6a@huawei.com>
In-Reply-To: <20190826115914.182700-1-maowenan@huawei.com>
References: <20190826115914.182700-1-maowenan@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.181]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 19:59:14 +0800
Mao Wenan <maowenan@huawei.com> wrote:

> When CRYPTO_DEV_HISI_SEC=y, below compilation error is found after 
> 'commit 894b68d8be4b ("crypto: hisilicon/des - switch to new verification routines")':
> 
> drivers/crypto/hisilicon/sec/sec_algs.o: In function `sec_alg_skcipher_setkey_des_cbc':
> sec_algs.c:(.text+0x11f0): undefined reference to `des_expand_key'
> drivers/crypto/hisilicon/sec/sec_algs.o: In function `sec_alg_skcipher_setkey_des_ecb':
> sec_algs.c:(.text+0x1390): undefined reference to `des_expand_key'
> make: *** [vmlinux] Error 1
> 
> This because DES library has been moved to lib/crypto in this commit 
> '04007b0e6cbb ("crypto: des - split off DES library from generic DES cipher driver")'.
> Fix this by selecting CRYPTO_LIB_DES in CRYPTO_DEV_HISI_SEC.
> 
> Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
> Fixes: 04007b0e6cbb ("crypto: des - split off DES library from generic DES cipher driver")
> Fixes: 894b68d8be4b ("crypto: hisilicon/des - switch to new verification routines")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Ah. It's that that third one that really introduced the dependency so possibly
only that one should be listed with a fixes tag.  However the right fix
at that point was to select CRYPTO_DES which then changed to CRYPTO_LIB_DES
only after the second patch.

It's not a fix for the first patch so that should probably not be there.

Otherwise, looks correct to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

thanks,

Jonathan



> ---
>  drivers/crypto/hisilicon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index fa8aa06..ebaf91e 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -4,6 +4,7 @@ config CRYPTO_DEV_HISI_SEC
>  	tristate "Support for Hisilicon SEC crypto block cipher accelerator"
>  	select CRYPTO_BLKCIPHER
>  	select CRYPTO_ALGAPI
> +	select CRYPTO_LIB_DES
>  	select SG_SPLIT
>  	depends on ARM64 || COMPILE_TEST
>  	depends on HAS_IOMEM


