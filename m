Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01364A977
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfFRSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfFRSHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:07:50 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D762063F;
        Tue, 18 Jun 2019 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881270;
        bh=eNYbObxTyev7HB64V8QVPEXdlAg7TDx8hT2C3MX03yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2fP+/h9oISFVSf5Zaw5YOn8UIu2Uy3T5ohsniKPb0hDCGcqdpg89juBEpJtvaxxK
         gVKY+FbG9x0ZyA2ZN2sQxWEETWWu1eSEsJf2a0x0Tv7f3fT+q/Biv7gKrDkpS/zeZI
         cf2czZqmT1iZ4QyQ5+gB8PpdTtO25yGGsvCGWpNg=
Date:   Tue, 18 Jun 2019 11:07:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: testmgr - dynamically allocate
 crypto_shash
Message-ID: <20190618180748.GI184520@gmail.com>
References: <20190618092215.2790800-1-arnd@arndb.de>
 <20190618092215.2790800-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618092215.2790800-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:21:53AM +0200, Arnd Bergmann wrote:
> The largest stack object in this file is now the shash descriptor.
> Since there are many other stack variables, this can push it
> over the 1024 byte warning limit, in particular with clang and
> KASAN:
> 
> crypto/testmgr.c:1693:12: error: stack frame size of 1312 bytes in function '__alg_test_hash' [-Werror,-Wframe-larger-than=]
> 
> Make test_hash_vs_generic_impl() do the same thing as the
> corresponding eaed and skcipher functions by allocating the

Typo: "eaed" should be "aead"

> descriptor dynamically. We can still do better than this,
> but it brings us well below the 1024 byte limit.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 9a8a6b3f0950 ("crypto: testmgr - fuzz hashes against their generic implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Actual patch looks fine though.  Thanks!

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
