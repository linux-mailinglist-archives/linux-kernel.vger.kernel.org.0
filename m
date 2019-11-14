Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681C4FB955
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 15:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfKMUEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:04:22 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D7B206E5;
        Wed, 13 Nov 2019 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573675462;
        bh=LZIwwPqo6cGSYYo3omBkRDVFip05Z5LaeW4j2tDTV2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhnZFjvlbtfVvcPSF1Xz2bXxwpvSyQKGXcs/DZmH2Yq6Qo5X6zS2xMotyjpkxZx6x
         CBBLyub/I93WCDLJkqQlz+qJKMDdR92ckWE9aeoZS0KU0JuiLO68+Z8tcNS1zd10Pw
         SXhtQGMI7Ad6ZHKdgaQ60mOoZNuf6k6cAqaMMnN4=
Date:   Wed, 13 Nov 2019 12:04:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sha: fix function types
Message-ID: <20191113200419.GE221701@gmail.com>
Mail-Followup-To: Sami Tolvanen <samitolvanen@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191112223046.176097-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112223046.176097-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 02:30:46PM -0800, Sami Tolvanen wrote:
> Declare assembly functions with the expected function type
> instead of casting pointers in C to avoid type mismatch failures
> with Control-Flow Integrity (CFI) checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/crypto/sha1-ce-glue.c   | 12 +++++-------
>  arch/arm64/crypto/sha2-ce-glue.c   | 26 +++++++++++---------------
>  arch/arm64/crypto/sha256-glue.c    | 30 ++++++++++++------------------
>  arch/arm64/crypto/sha512-ce-glue.c | 23 ++++++++++-------------
>  arch/arm64/crypto/sha512-glue.c    | 13 +++++--------
>  5 files changed, 43 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> index bdc1b6d7aff7..3153a9bbb683 100644
> --- a/arch/arm64/crypto/sha1-ce-glue.c
> +++ b/arch/arm64/crypto/sha1-ce-glue.c
> @@ -25,7 +25,7 @@ struct sha1_ce_state {
>  	u32			finalize;
>  };
>  
> -asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> +asmlinkage void sha1_ce_transform(struct sha1_state *sst, u8 const *src,
>  				  int blocks);

Please update the comments in the corresponding assembly files too.

Also, this change doesn't really make sense because the assembly functions still
expect struct sha1_ce_state, and they access sha1_ce_state::finalize which is
not present in struct sha1_state.  There should either be wrapper functions that
explicitly do the cast from sha1_state to sha1_ce_state, or there should be
comments in the assembly files that very clearly explain that although the
function prototype takes sha1_state, it's really assumed to be a sha1_ce_state.

Likewise for SHA-256 and SHA-512.

- Eric
