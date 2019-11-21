Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54DF105D13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 00:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKUXOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 18:14:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37097 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:14:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so2287366plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2veRivAEh/Lpdr/ITAgILE86AAw5jcwe/4mpzH2NlJY=;
        b=ePy4Igu7gMSF9I7sxcFxsVtHYtvJJ2SEnYiHowKoYYz0JdW1fbVLxfCsr5NiQNFD96
         S75Onl+RseVnFfQwCk0TEvq7bo+71LX5nid4yXpkidBnjdfT7azrp8iUcU0eXKuqqqAj
         Z8aCyx+1mc7qCC6QTIDXBUcAMy2pYNzJnxWQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2veRivAEh/Lpdr/ITAgILE86AAw5jcwe/4mpzH2NlJY=;
        b=ls1MU4CY0VHicC7W70KlPPu1dE85oFrpdQdnLjIywXjzPtf3r7//cRc4zHHfECnmyw
         TGh5sggnUcP414oQx6VFpiQPg4FHQnjqRx6IX+6uBq6SsQtdKM6CXeshOnD5aCJeW6wX
         J7XyB8Ck6F6ZzZlqQKlTgNa4k2rRCAdrkxzEtpky2q18lHaFI4YwS7SK/PP+r7QWXOEX
         yjo5VtTxs/g0a4t9zBxPOeFiY4LgapfU4NwxVW9o3YkID/dPTNI4mDWTc27ch+wlM8Po
         Cc525y4Ox7M8PN2tjIblXW6nKcz+QbrQw2pZrkniELX+g+inhlZVyfJRvlHIPE2lMa39
         3TWQ==
X-Gm-Message-State: APjAAAWKksKhcAZ/bjBSVf1wF+30hD5bRb15530CNLLLJtC5AD34cZev
        9lFDlj4sMOqSE8mOU84Rt0a9ZQ==
X-Google-Smtp-Source: APXvYqx10aUfkseuuvvIiZfCFrVLk2ANnIMrVihwB9ZsfC8ppUGV0nab1w1NRyDgV1ToQf1VrNj46Q==
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr14857916pjs.94.1574378061504;
        Thu, 21 Nov 2019 15:14:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x25sm4665058pfq.73.2019.11.21.15.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:14:20 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:14:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 8/8] crypto, x86/sha: Eliminate casts on asm
 implementations
Message-ID: <201911211512.6A86399@keescook>
References: <20191113182516.13545-1-keescook@chromium.org>
 <20191113182516.13545-9-keescook@chromium.org>
 <20191113195529.GD221701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113195529.GD221701@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:55:30AM -0800, Eric Biggers wrote:
> On Wed, Nov 13, 2019 at 10:25:16AM -0800, Kees Cook wrote:
> > In order to avoid CFI function prototype mismatches, this removes the
> > casts on assembly implementations of sha1/256/512 accelerators. The
> > safety checks from BUILD_BUG_ON() remain.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/crypto/sha1_ssse3_glue.c   | 61 ++++++++++++-----------------
> >  arch/x86/crypto/sha256_ssse3_glue.c | 31 +++++++--------
> >  arch/x86/crypto/sha512_ssse3_glue.c | 28 ++++++-------
> >  3 files changed, 50 insertions(+), 70 deletions(-)
> > 
> > diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
> > index 639d4c2fd6a8..a151d899f37a 100644
> > --- a/arch/x86/crypto/sha1_ssse3_glue.c
> > +++ b/arch/x86/crypto/sha1_ssse3_glue.c
> > @@ -27,11 +27,8 @@
> >  #include <crypto/sha1_base.h>
> >  #include <asm/simd.h>
> >  
> > -typedef void (sha1_transform_fn)(u32 *digest, const char *data,
> > -				unsigned int rounds);
> > -
> >  static int sha1_update(struct shash_desc *desc, const u8 *data,
> > -			     unsigned int len, sha1_transform_fn *sha1_xform)
> > +			     unsigned int len, sha1_block_fn *sha1_xform)
> >  {
> >  	struct sha1_state *sctx = shash_desc_ctx(desc);
> >  
> > @@ -39,48 +36,44 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
> >  	    (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
> >  		return crypto_sha1_update(desc, data, len);
> >  
> > -	/* make sure casting to sha1_block_fn() is safe */
> > +	/* make sure sha1_block_fn() use in generic routines is safe */
> >  	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
> 
> This update to the comment makes no sense, since sha1_block_fn() is obviously
> safe in the helpers, and this says nothing about the assembly functions.
> Instead this should say something like:
> 
> 	/*
> 	 * Make sure that struct sha1_state begins directly with the 160-bit
> 	 * SHA1 internal state, as this is what the assembly functions expect.
> 	 */
> 
> Likewise for SHA-256 and SHA-512, except for those it would be a 256-bit and
> 512-bit internal state respectively.

Thanks! Agreed, that is much clearer.

> > -asmlinkage void sha1_transform_ssse3(u32 *digest, const char *data,
> > -				     unsigned int rounds);
> > +asmlinkage void sha1_transform_ssse3(struct sha1_state *digest,
> > +				     u8 const *data, int rounds);
> 
> 'u8 const' is unconventional.  Please use 'const u8' instead.

Yeah, I noticed that but decided to disrupt less. Fixed now.

> Also, this function prototype is also given in a comment in the corresponding
> assembly file.  Can you please update that too, and also leave a comment in the
> assembly file like "struct sha1_state is assumed to begin with u32 state[5]."?
> 
> Likewise for all the other SHA-1, and SHA-256, and SHA-512 assembly functions,
> except it would be u32 state[8] for SHA-256 and u64 state[8] for SHA-512.

I love how each uses an entirely different comment style. :) Updated!

-- 
Kees Cook
