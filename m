Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EE172D48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgB1AbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:31:01 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55586 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgB1AbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:31:01 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j7TYK-0008Qp-Q2; Fri, 28 Feb 2020 11:30:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Feb 2020 11:30:52 +1100
Date:   Fri, 28 Feb 2020 11:30:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: drbg: DRBG_CTR should select CTR
Message-ID: <20200228003052.GA9060@gondor.apana.org.au>
References: <1582127495-5871-1-git-send-email-clabbe@baylibre.com>
 <1582127495-5871-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582127495-5871-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:51:35PM +0000, Corentin Labbe wrote:
> if CRYPTO_DRBG_CTR is builtin and CTR is module, allocating such algo
> will fail.
> DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> alg: drbg: Failed to reset rng
> alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
> DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> alg: drbg: Failed to reset rng
> alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
> DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> alg: drbg: Failed to reset rng
> alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
> DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> alg: drbg: Failed to reset rng
> ialg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
> 
> Since setting DRBG_CTR=CTR lead to a recursive dependency, let's depends
> on CTR=y
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 6d27fc6a7bf5..eddeb43fc01c 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1822,7 +1822,7 @@ config CRYPTO_DRBG_HASH
>  config CRYPTO_DRBG_CTR
>  	bool "Enable CTR DRBG"
>  	select CRYPTO_AES
> -	depends on CRYPTO_CTR
> +	depends on CRYPTO_CTR=y

This should be turned into a select.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
