Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C961E4A967
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfFRSGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfFRSGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:06:06 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E282E2063F;
        Tue, 18 Jun 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881166;
        bh=Mt7M1hiWtQFwHq/JT2TzGw7U6sxTiqsy7sABsh5xXvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OltEX/WH5jdgnZK3v8w1kduvN71wI1G5FXhUIK4Mp90AycejE1S/M7hr+/fs+IHpC
         pz9GJhoAKDcrJWBvYKw9jpdLNj4VQZqCdA0h0AzO/gX0BAv9l98u16IpqCd1iAwQcm
         78yJHuQIuV5gGqpgnMMr2Gii5KtSc47SxNZqZ8KU=
Date:   Tue, 18 Jun 2019 11:06:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] crypto: testmgr - dynamically allocate
 testvec_config
Message-ID: <20190618180604.GH184520@gmail.com>
References: <20190618092215.2790800-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618092215.2790800-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:21:52AM +0200, Arnd Bergmann wrote:
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

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
