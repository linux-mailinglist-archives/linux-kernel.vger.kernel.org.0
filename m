Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7D18C575
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 03:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCTCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 22:48:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33438 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgCTCsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:48:10 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jF7hX-0000kR-4x; Fri, 20 Mar 2020 13:48:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Mar 2020 13:47:58 +1100
Date:   Fri, 20 Mar 2020 13:47:58 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: drbg: DRBG_CTR should select CTR
Message-ID: <20200320024758.GA20493@gondor.apana.org.au>
References: <1583874338-38321-1-git-send-email-clabbe@baylibre.com>
 <1583874338-38321-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583874338-38321-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:05:38PM +0000, Corentin Labbe wrote:
>
> Just selecting CTR lead also to a recursive dependency:
> crypto/Kconfig:1800:error: recursive dependency detected!
> crypto/Kconfig:1800:    symbol CRYPTO_DRBG_MENU is selected by
> CRYPTO_RNG_DEFAULT
> crypto/Kconfig:83:      symbol CRYPTO_RNG_DEFAULT is selected by
> CRYPTO_SEQIV
> crypto/Kconfig:330:     symbol CRYPTO_SEQIV is selected by CRYPTO_CTR
> crypto/Kconfig:370:     symbol CRYPTO_CTR is selected by CRYPTO_DRBG_CTR
> crypto/Kconfig:1822:    symbol CRYPTO_DRBG_CTR depends on
> CRYPTO_DRBG_MENU

The SEQIV select from CTR is historical and no longer necessary.
So let's just get rid of that and then DRBG can select CTR without
running into loops.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
