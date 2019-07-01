Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82464A964
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfFRSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfFRSF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:05:29 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528FF2063F;
        Tue, 18 Jun 2019 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881128;
        bh=zu49cMGWCOZqm0jpO1OSpCXjUzgW/CvCCjRK1XcoiR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqRhM9Jh9Uh6QscYb8TgS+av5lV+aMfdWA0J0VppbG+QcEprlSiuFMuPF7wfyu0z9
         DVQcfigeAfDvPkATHsenQEIfg2hPlwZzPZXmHyx/Wi1yTXp5j4rkwur81GaVh9A+ni
         ivBZtiDqof0stlo5uAyIUQbXEvc4rOEM6pzU3PU4=
Date:   Tue, 18 Jun 2019 11:05:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] crypto: serpent - mark __serpent_setkey_sbox
 noinline
Message-ID: <20190618180526.GG184520@gmail.com>
References: <20190618111953.3183723-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618111953.3183723-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:19:42PM +0200, Arnd Bergmann wrote:
> The same bug that gcc hit in the past is apparently now showing
> up with clang, which decides to inline __serpent_setkey_sbox:
> 
> crypto/serpent_generic.c:268:5: error: stack frame size of 2112 bytes in function '__serpent_setkey' [-Werror,-Wframe-larger-than=]
> 
> Marking it 'noinline' reduces the stack usage from 2112 bytes to
> 192 and 96 bytes, respectively, and seems to generate more
> useful object code.
> 
> Fixes: c871c10e4ea7 ("crypto: serpent - improve __serpent_setkey with UBSAN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: style improvements suggested by Eric Biggers
> ---
>  crypto/serpent_generic.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/serpent_generic.c b/crypto/serpent_generic.c
> index e57757904677..56fa665a4f01 100644
> --- a/crypto/serpent_generic.c
> +++ b/crypto/serpent_generic.c
> @@ -225,7 +225,13 @@
>  	x4 ^= x2;					\
>  	})
>  
> -static void __serpent_setkey_sbox(u32 r0, u32 r1, u32 r2, u32 r3, u32 r4, u32 *k)
> +/*
> + * both gcc and clang have misoptimized this function in the past,
> + * producing horrible object code from spilling temporary variables
> + * on the stack. Forcing this part out of line avoids that.
> + */
> +static noinline void __serpent_setkey_sbox(u32 r0, u32 r1, u32 r2,
> +					   u32 r3, u32 r4, u32 *k)
>  {
>  	k += 100;
>  	S3(r3, r4, r0, r1, r2); store_and_load_keys(r1, r2, r4, r3, 28, 24);
> -- 
> 2.20.0
> 

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
