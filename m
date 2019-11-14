Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC66FB77A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfKMS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 13:27:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfKMS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:27:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so2192367pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0SldfB0j+4tKzSNZBilCOOuiK+IfM16jHWw6L5StrsI=;
        b=b6XpEfgqzGrU1tQHqumz1WgRqgES7GyOz0K3XKNnLg4+Q0nhTod/u8TWJuyYeU7ndF
         vNfnNFTFIetnXt2DOMBnqWxhwX4ky7m/TztimnnKHw7gWjvB+/DawG1mD6urae/cW/De
         jpFH2jDthBJfC7BPILUjSadtRARH6TvZ45DEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SldfB0j+4tKzSNZBilCOOuiK+IfM16jHWw6L5StrsI=;
        b=tP+KYEQ36FDp6j5TAUdS4pUwrzyI/T03RjEXQO+WTyDx9VdCHELgcbZZWLcAXWun5r
         Py31+Zq6GTh5fe6jiUORd+MXL8K6yc1sxO+V8kLFN7+iLE6y/Sl2UrWC6GxoOQOec+Uw
         HyhluGK7ix12ppcRvQTki02qnw42vTsEkl3GWbAUEF3VIxNaH28LuzI4AKc00zoTK0Qp
         BthHeKO5WwRKurZoAcJj6aJM1MwSag1QmGqIcapGIdINH7aMp3CmXYZhKpOJSexr8GuP
         Rkg5dnQfZJbFPiHDAh95pm0k8702ToIRAHVTQTD4ZxT6+PQ4h4kissZFocSuKoqjNR4S
         hxvQ==
X-Gm-Message-State: APjAAAU145Uv7xQPyd6KnXFttG2hkqt4FF6bAFdG76oWqLLnXnAJm5CN
        CwdIQoX5WUoFU4tZrnQEuzY4bg==
X-Google-Smtp-Source: APXvYqx0m1GhkzXSTISGNFHQr6CvD7Z1RZv2kccmR0jXTamqQxQSAWsV+5D86v+A+4qJ7/tw+/muIA==
X-Received: by 2002:a17:90a:fa96:: with SMTP id cu22mr6791848pjb.121.1573669641939;
        Wed, 13 Nov 2019 10:27:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13sm3803381pfc.110.2019.11.13.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:27:21 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:27:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sha: fix function types
Message-ID: <201911131026.7B0FA60@keescook>
References: <20191112223046.176097-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112223046.176097-1-samitolvanen@google.com>
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

Looks good, yes. This looks very similar to what I needed to do for
x86's SHA routines.

Reviewed-by: Kees Cook <keescook@chromium.org>

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
>  
>  const u32 sha1_ce_offsetof_count = offsetof(struct sha1_ce_state, sst.count);
> @@ -41,8 +41,7 @@ static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
>  
>  	sctx->finalize = 0;
>  	kernel_neon_begin();
> -	sha1_base_do_update(desc, data, len,
> -			    (sha1_block_fn *)sha1_ce_transform);
> +	sha1_base_do_update(desc, data, len, sha1_ce_transform);
>  	kernel_neon_end();
>  
>  	return 0;
> @@ -64,10 +63,9 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
>  	sctx->finalize = finalize;
>  
>  	kernel_neon_begin();
> -	sha1_base_do_update(desc, data, len,
> -			    (sha1_block_fn *)sha1_ce_transform);
> +	sha1_base_do_update(desc, data, len, sha1_ce_transform);
>  	if (!finalize)
> -		sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
> +		sha1_base_do_finalize(desc, sha1_ce_transform);
>  	kernel_neon_end();
>  	return sha1_base_finish(desc, out);
>  }
> @@ -81,7 +79,7 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
>  
>  	sctx->finalize = 0;
>  	kernel_neon_begin();
> -	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
> +	sha1_base_do_finalize(desc, sha1_ce_transform);
>  	kernel_neon_end();
>  	return sha1_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> index 604a01a4ede6..a4dacedfe4d4 100644
> --- a/arch/arm64/crypto/sha2-ce-glue.c
> +++ b/arch/arm64/crypto/sha2-ce-glue.c
> @@ -25,7 +25,7 @@ struct sha256_ce_state {
>  	u32			finalize;
>  };
>  
> -asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
> +asmlinkage void sha2_ce_transform(struct sha256_state *sst, u8 const *src,
>  				  int blocks);
>  
>  const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
> @@ -33,7 +33,8 @@ const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
>  const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
>  						 finalize);
>  
> -asmlinkage void sha256_block_data_order(u32 *digest, u8 const *src, int blocks);
> +asmlinkage void sha256_block_data_order(struct sha256_state *sst, u8 const *src,
> +					int blocks);
>  
>  static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
>  			    unsigned int len)
> @@ -42,12 +43,11 @@ static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
>  
>  	if (!crypto_simd_usable())
>  		return sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> +				sha256_block_data_order);
>  
>  	sctx->finalize = 0;
>  	kernel_neon_begin();
> -	sha256_base_do_update(desc, data, len,
> -			      (sha256_block_fn *)sha2_ce_transform);
> +	sha256_base_do_update(desc, data, len, sha2_ce_transform);
>  	kernel_neon_end();
>  
>  	return 0;
> @@ -62,9 +62,8 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
>  	if (!crypto_simd_usable()) {
>  		if (len)
>  			sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> -		sha256_base_do_finalize(desc,
> -				(sha256_block_fn *)sha256_block_data_order);
> +				sha256_block_data_order);
> +		sha256_base_do_finalize(desc, sha256_block_data_order);
>  		return sha256_base_finish(desc, out);
>  	}
>  
> @@ -75,11 +74,9 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
>  	sctx->finalize = finalize;
>  
>  	kernel_neon_begin();
> -	sha256_base_do_update(desc, data, len,
> -			      (sha256_block_fn *)sha2_ce_transform);
> +	sha256_base_do_update(desc, data, len, sha2_ce_transform);
>  	if (!finalize)
> -		sha256_base_do_finalize(desc,
> -					(sha256_block_fn *)sha2_ce_transform);
> +		sha256_base_do_finalize(desc, sha2_ce_transform);
>  	kernel_neon_end();
>  	return sha256_base_finish(desc, out);
>  }
> @@ -89,14 +86,13 @@ static int sha256_ce_final(struct shash_desc *desc, u8 *out)
>  	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
>  
>  	if (!crypto_simd_usable()) {
> -		sha256_base_do_finalize(desc,
> -				(sha256_block_fn *)sha256_block_data_order);
> +		sha256_base_do_finalize(desc, sha256_block_data_order);
>  		return sha256_base_finish(desc, out);
>  	}
>  
>  	sctx->finalize = 0;
>  	kernel_neon_begin();
> -	sha256_base_do_finalize(desc, (sha256_block_fn *)sha2_ce_transform);
> +	sha256_base_do_finalize(desc, sha2_ce_transform);
>  	kernel_neon_end();
>  	return sha256_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
> index e273faca924f..dac3157937ba 100644
> --- a/arch/arm64/crypto/sha256-glue.c
> +++ b/arch/arm64/crypto/sha256-glue.c
> @@ -23,28 +23,25 @@ MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_CRYPTO("sha224");
>  MODULE_ALIAS_CRYPTO("sha256");
>  
> -asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
> -					unsigned int num_blks);
> +asmlinkage void sha256_block_data_order(struct sha256_state *sst, u8 const *src,
> +					int blocks);
>  EXPORT_SYMBOL(sha256_block_data_order);
>  
> -asmlinkage void sha256_block_neon(u32 *digest, const void *data,
> -				  unsigned int num_blks);
> +asmlinkage void sha256_block_neon(struct sha256_state *sst, u8 const *src,
> +				  int blocks);
>  
>  static int crypto_sha256_arm64_update(struct shash_desc *desc, const u8 *data,
>  				      unsigned int len)
>  {
> -	return sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> +	return sha256_base_do_update(desc, data, len, sha256_block_data_order);
>  }
>  
>  static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
>  				     unsigned int len, u8 *out)
>  {
>  	if (len)
> -		sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> -	sha256_base_do_finalize(desc,
> -				(sha256_block_fn *)sha256_block_data_order);
> +		sha256_base_do_update(desc, data, len, sha256_block_data_order);
> +	sha256_base_do_finalize(desc, sha256_block_data_order);
>  
>  	return sha256_base_finish(desc, out);
>  }
> @@ -87,7 +84,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
>  
>  	if (!crypto_simd_usable())
>  		return sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> +				sha256_block_data_order);
>  
>  	while (len > 0) {
>  		unsigned int chunk = len;
> @@ -103,8 +100,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
>  				sctx->count % SHA256_BLOCK_SIZE;
>  
>  		kernel_neon_begin();
> -		sha256_base_do_update(desc, data, chunk,
> -				      (sha256_block_fn *)sha256_block_neon);
> +		sha256_base_do_update(desc, data, chunk, sha256_block_neon);
>  		kernel_neon_end();
>  		data += chunk;
>  		len -= chunk;
> @@ -118,15 +114,13 @@ static int sha256_finup_neon(struct shash_desc *desc, const u8 *data,
>  	if (!crypto_simd_usable()) {
>  		if (len)
>  			sha256_base_do_update(desc, data, len,
> -				(sha256_block_fn *)sha256_block_data_order);
> -		sha256_base_do_finalize(desc,
> -				(sha256_block_fn *)sha256_block_data_order);
> +				sha256_block_data_order);
> +		sha256_base_do_finalize(desc, sha256_block_data_order);
>  	} else {
>  		if (len)
>  			sha256_update_neon(desc, data, len);
>  		kernel_neon_begin();
> -		sha256_base_do_finalize(desc,
> -				(sha256_block_fn *)sha256_block_neon);
> +		sha256_base_do_finalize(desc, sha256_block_neon);
>  		kernel_neon_end();
>  	}
>  	return sha256_base_finish(desc, out);
> diff --git a/arch/arm64/crypto/sha512-ce-glue.c b/arch/arm64/crypto/sha512-ce-glue.c
> index 2369540040aa..0f964235d753 100644
> --- a/arch/arm64/crypto/sha512-ce-glue.c
> +++ b/arch/arm64/crypto/sha512-ce-glue.c
> @@ -27,18 +27,18 @@ MODULE_LICENSE("GPL v2");
>  asmlinkage void sha512_ce_transform(struct sha512_state *sst, u8 const *src,
>  				    int blocks);
>  
> -asmlinkage void sha512_block_data_order(u64 *digest, u8 const *src, int blocks);
> +asmlinkage void sha512_block_data_order(struct sha512_state *sst, u8 const *src,
> +					int blocks);
>  
>  static int sha512_ce_update(struct shash_desc *desc, const u8 *data,
>  			    unsigned int len)
>  {
>  	if (!crypto_simd_usable())
>  		return sha512_base_do_update(desc, data, len,
> -				(sha512_block_fn *)sha512_block_data_order);
> +					     sha512_block_data_order);
>  
>  	kernel_neon_begin();
> -	sha512_base_do_update(desc, data, len,
> -			      (sha512_block_fn *)sha512_ce_transform);
> +	sha512_base_do_update(desc, data, len, sha512_ce_transform);
>  	kernel_neon_end();
>  
>  	return 0;
> @@ -50,16 +50,14 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
>  	if (!crypto_simd_usable()) {
>  		if (len)
>  			sha512_base_do_update(desc, data, len,
> -				(sha512_block_fn *)sha512_block_data_order);
> -		sha512_base_do_finalize(desc,
> -				(sha512_block_fn *)sha512_block_data_order);
> +					      sha512_block_data_order);
> +		sha512_base_do_finalize(desc, sha512_block_data_order);
>  		return sha512_base_finish(desc, out);
>  	}
>  
>  	kernel_neon_begin();
> -	sha512_base_do_update(desc, data, len,
> -			      (sha512_block_fn *)sha512_ce_transform);
> -	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
> +	sha512_base_do_update(desc, data, len, sha512_ce_transform);
> +	sha512_base_do_finalize(desc, sha512_ce_transform);
>  	kernel_neon_end();
>  	return sha512_base_finish(desc, out);
>  }
> @@ -67,13 +65,12 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
>  static int sha512_ce_final(struct shash_desc *desc, u8 *out)
>  {
>  	if (!crypto_simd_usable()) {
> -		sha512_base_do_finalize(desc,
> -				(sha512_block_fn *)sha512_block_data_order);
> +		sha512_base_do_finalize(desc, sha512_block_data_order);
>  		return sha512_base_finish(desc, out);
>  	}
>  
>  	kernel_neon_begin();
> -	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
> +	sha512_base_do_finalize(desc, sha512_ce_transform);
>  	kernel_neon_end();
>  	return sha512_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha512-glue.c b/arch/arm64/crypto/sha512-glue.c
> index d915c656e5fe..0f6b610a7954 100644
> --- a/arch/arm64/crypto/sha512-glue.c
> +++ b/arch/arm64/crypto/sha512-glue.c
> @@ -20,25 +20,22 @@ MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_CRYPTO("sha384");
>  MODULE_ALIAS_CRYPTO("sha512");
>  
> -asmlinkage void sha512_block_data_order(u32 *digest, const void *data,
> -					unsigned int num_blks);
> +asmlinkage void sha512_block_data_order(struct sha512_state *sst,
> +					u8 const *src, int blocks);
>  EXPORT_SYMBOL(sha512_block_data_order);
>  
>  static int sha512_update(struct shash_desc *desc, const u8 *data,
>  			 unsigned int len)
>  {
> -	return sha512_base_do_update(desc, data, len,
> -			(sha512_block_fn *)sha512_block_data_order);
> +	return sha512_base_do_update(desc, data, len, sha512_block_data_order);
>  }
>  
>  static int sha512_finup(struct shash_desc *desc, const u8 *data,
>  			unsigned int len, u8 *out)
>  {
>  	if (len)
> -		sha512_base_do_update(desc, data, len,
> -			(sha512_block_fn *)sha512_block_data_order);
> -	sha512_base_do_finalize(desc,
> -			(sha512_block_fn *)sha512_block_data_order);
> +		sha512_base_do_update(desc, data, len, sha512_block_data_order);
> +	sha512_base_do_finalize(desc, sha512_block_data_order);
>  
>  	return sha512_base_finish(desc, out);
>  }
> 
> base-commit: 100d46bd72ec689a5582c2f5f4deadc5bcb92d60
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

-- 
Kees Cook
