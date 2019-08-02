Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE367EBB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 06:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfHBEzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 00:55:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48678 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfHBEzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:55:54 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPbE-0006IB-Tb; Fri, 02 Aug 2019 14:55:29 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPb9-0004ji-79; Fri, 02 Aug 2019 14:55:23 +1000
Date:   Fri, 2 Aug 2019 14:55:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        kasan-dev@googlegroups.com,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] crypto: jitterentropy: build without sanitizer
Message-ID: <20190802045523.GF18077@gondor.apana.org.au>
References: <20190724185207.4023459-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724185207.4023459-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 08:51:55PM +0200, Arnd Bergmann wrote:
> Recent clang-9 snapshots double the kernel stack usage when building
> this file with -O0 -fsanitize=kernel-hwaddress, compared to clang-8
> and older snapshots, this changed between commits svn364966 and
> svn366056:
> 
> crypto/jitterentropy.c:516:5: error: stack frame size of 2640 bytes in function 'jent_entropy_init' [-Werror,-Wframe-larger-than=]
> int jent_entropy_init(void)
>     ^
> crypto/jitterentropy.c:185:14: error: stack frame size of 2224 bytes in function 'jent_lfsr_time' [-Werror,-Wframe-larger-than=]
> static __u64 jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt)
>              ^
> 
> I prepared a reduced test case in case any clang developers want to
> take a closer look, but from looking at the earlier output it seems
> that even with clang-8, something was very wrong here.
> 
> Turn off any KASAN and UBSAN sanitizing for this file, as that likely
> clashes with -O0 anyway.  Turning off just KASAN avoids the warning
> already, but I suspect both of these have undesired side-effects
> for jitterentropy.
> 
> Link: https://godbolt.org/z/fDcwZ5
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
