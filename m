Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3CDE445A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392895AbfFMQp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:45:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46840 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfFMGB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:01:59 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbIo7-0005k6-E6; Thu, 13 Jun 2019 14:01:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbIo1-0002AR-Pd; Thu, 13 Jun 2019 14:01:49 +0800
Date:   Thu, 13 Jun 2019 14:01:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] crypto: user - fix potential warnings in cryptouser.h
Message-ID: <20190613060149.a66vdfyrxe356nr2@gondor.apana.org.au>
References: <20190609065710.18735-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609065710.18735-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 03:57:10PM +0900, Masahiro Yamada wrote:
>
> diff --git a/include/crypto/internal/cryptouser.h b/include/crypto/internal/cryptouser.h
> index 8c602b187c58..2339cb06dbf8 100644
> --- a/include/crypto/internal/cryptouser.h
> +++ b/include/crypto/internal/cryptouser.h
> @@ -3,12 +3,15 @@
>  
>  extern struct sock *crypto_nlsk;
>  
> +struct crypto_user_alg;

Please change this to instead include <linux/cryptouser.h>.

In the crypto API the internal header file should always include the
external header file.

You can also remove the inclusion of the external header file from
the users of crypto/internal/cryptouser.h.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
