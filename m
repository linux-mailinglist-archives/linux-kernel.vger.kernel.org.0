Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF66D484DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfFQOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:04:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33432 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFQOE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:04:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hcsFV-0000fY-LT; Mon, 17 Jun 2019 22:04:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hcsFQ-00037A-5L; Mon, 17 Jun 2019 22:04:36 +0800
Date:   Mon, 17 Jun 2019 22:04:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - reduce stack usage in fuzzers
Message-ID: <20190617140435.qjzcouaqzepaicf4@gondor.apana.org.au>
References: <20190617132343.2678836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132343.2678836-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:23:02PM +0200, Arnd Bergmann wrote:
> On arm32, we get warnings about high stack usage in some of the functions:
> 
> crypto/testmgr.c:2269:12: error: stack frame size of 1032 bytes in function 'alg_test_aead' [-Werror,-Wframe-larger-than=]
> static int alg_test_aead(const struct alg_test_desc *desc, const char *driver,
>            ^
> crypto/testmgr.c:1693:12: error: stack frame size of 1312 bytes in function '__alg_test_hash' [-Werror,-Wframe-larger-than=]
> static int __alg_test_hash(const struct hash_testvec *vecs,
>            ^
> 
> On of the larger objects on the stack here is struct testvec_config, so
> change that to dynamic allocation.
> 
> Fixes: 40153b10d91c ("crypto: testmgr - fuzz AEADs against their generic implementation")
> Fixes: d435e10e67be ("crypto: testmgr - fuzz skciphers against their generic implementation")
> Fixes: 9a8a6b3f0950 ("crypto: testmgr - fuzz hashes against their generic implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I only compile-tested this, and it's not completely trivial, so please
> review carefully.

These structures are not meant to be that big.  I suspect something
has gone awry with the recent security conversions.

Kees?
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
