Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26ACF86CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 03:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLCOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 21:14:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35308 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLCOM (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Mon, 11 Nov 2019 21:14:12 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iULgm-0007WR-Ua; Tue, 12 Nov 2019 10:13:53 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iULgk-0004WR-QV; Tue, 12 Nov 2019 10:13:50 +0800
Date:   Tue, 12 Nov 2019 10:13:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, cyrille.pitchen@atmel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH -next] crypto: atmel - Fix randbuild error
Message-ID: <20191112021350.qu44becwmwom7ywu@gondor.apana.org.au>
References: <20191111133901.19164-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133901.19164-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:39:01PM +0800, YueHaibing wrote:
> If CRYPTO_AUTHENC is m, CRYPTO_DEV_ATMEL_SHA is m, but
> CRYPTO_DEV_ATMEL_AES is y, building will fails:
> 
> drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_init_tfm':
> atmel-aes.c:(.text+0x670): undefined reference to `atmel_sha_authenc_get_reqsize'
> atmel-aes.c:(.text+0x67a): undefined reference to `atmel_sha_authenc_spawn'
> drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_setkey':
> atmel-aes.c:(.text+0x7e5): undefined reference to `atmel_sha_authenc_setkey'
> 
> Fix this by moving the selection of CRYPTO_DEV_ATMEL_SHA under
> CRYPTO_DEV_ATMEL_AES.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to...")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This patch shows that moving CRYPTO_AUTHENC over was just papering
over a real problem.  Applying your patch essentially makes SHA
the same option as AES.

What we should do instead is turn DEV_ATMEL_AUTHENC into a bool,
and then add these to DEV_ATMEL_AES:

	select CRYPTO_AUTHENC if CRYPTO_DEV_ATMEL_AUTHENC
	select CRYPTO_DEV_ATMEL_SHA if CRYPTO_DEV_ATMEL_AUTHENC

Could you please do this and repost?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
