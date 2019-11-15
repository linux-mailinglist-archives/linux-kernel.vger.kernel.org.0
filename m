Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F3FDC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKOLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 06:32:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38466 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfKOLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:32:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so10034178wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 03:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbyPL8sD3PdrXer26nTPqwpkCln8AicPZfVsETHDNoo=;
        b=EreKvAPhl3BdSzt1q1jtAvfCXgteeYNhfoDR3nGvsBCKDiihmQy3Ov77KZjIOJZbBw
         /BD1IkOax+QUinqoKskaMdMfR1CXWlXUqiV/gA5fjRVAIZzJp9lHe9tzHop84SxuH5Ti
         g4TllEY9mK/H1YQTAoSsBVKCL0pR/iYjZR0z8tRPd8kn9f/tVsgpliL2RhnKtfe71Qo0
         2PGUAooXus9NKW9BXOipEYJ1dHaJJdr6jknxt0YGWuNcMX6Yd2Bv35sVMdu5jqS1z779
         BTxGTDlDSaeeG/aJ1qveztAT8btnh6WE0CDJmkAfE1+eFnqJjfqbgfXcwOQ2sqQhZR+v
         Zt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbyPL8sD3PdrXer26nTPqwpkCln8AicPZfVsETHDNoo=;
        b=W9MpmjBOTw9lknQf0q1d7OqqaqvvRW7f0lAGnBD7zE4ZzoWTx0n82TW3lNlrRkucO/
         6XR7aiWzWy/97UjsBB5SwD5ni/ssLOHhnmqq0QXuH2eBTIgCLaTC8Ee57j/OdXOOXzr+
         6XCEgP70T5FeO6yQ7F3pL/MMHPXxH46Ek5ycEfQieoZl7UhlnE+3KAWUHSdmM07s3Fwu
         x5cVonVIz5WufhwzLbj5cCYQm+nm/8/pOaMxP7vUi1LdriVuzYKNPZNNbmcAuGkHgBQA
         M3It6xhbcifAt4kRr5qcLWHf8ii6xmUV/LUPyXTTOPrtGLjnN2QnkPqwdaYCkzcYdW4E
         OFRA==
X-Gm-Message-State: APjAAAU4ThkzKzzPkaCwLbtUnykDz92+Avqnv8zrzhCDLTHt6sl07wE5
        AP4Zx7sqAnQCw6trivzA6WFoW+pV6C+Kaq/B+mByMQ==
X-Google-Smtp-Source: APXvYqz+zx5uW0o3xOZmZwmpqV554auqXSNIGVl4LwW5UXuqw3kzGxLKiGLuREvDKKDPlO+Afa6Sad8RF2MppEj2UK4=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr12941215wmb.136.1573817551365;
 Fri, 15 Nov 2019 03:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com> <20191114225113.155143-1-samitolvanen@google.com>
In-Reply-To: <20191114225113.155143-1-samitolvanen@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Nov 2019 11:32:23 +0000
Message-ID: <CAKv+Gu98uOZz7ZrG66gQerBq+hmwHmL4ebz5oDL16hxg=Y_YvA@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: arm64/sha: fix function types
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 22:51, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Instead of casting pointers to callback functions, add C wrappers
> to avoid type mismatch failures with Control-Flow Integrity (CFI)
> checking.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/crypto/sha1-ce-glue.c   | 17 +++++++++------
>  arch/arm64/crypto/sha2-ce-glue.c   | 34 ++++++++++++++++++------------
>  arch/arm64/crypto/sha256-glue.c    | 32 +++++++++++++++++-----------
>  arch/arm64/crypto/sha512-ce-glue.c | 26 ++++++++++++-----------
>  arch/arm64/crypto/sha512-glue.c    | 15 ++++++++-----
>  5 files changed, 76 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> index bdc1b6d7aff7..76a951ce2a7b 100644
> --- a/arch/arm64/crypto/sha1-ce-glue.c
> +++ b/arch/arm64/crypto/sha1-ce-glue.c
> @@ -28,6 +28,13 @@ struct sha1_ce_state {
>  asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
>                                   int blocks);
>
> +static inline void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> +                                      int blocks)

Nit: making a function inline when all we ever do is take its address
is rather pointless, so please drop that (below as well)

With that fixed (and assuming that the crypto selftests still pass -
please confirm that you've tried that)

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> +{
> +       return sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst),
> +                                src, blocks);
> +}
> +
>  const u32 sha1_ce_offsetof_count = offsetof(struct sha1_ce_state, sst.count);
>  const u32 sha1_ce_offsetof_finalize = offsetof(struct sha1_ce_state, finalize);
>
> @@ -41,8 +48,7 @@ static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
>
>         sctx->finalize = 0;
>         kernel_neon_begin();
> -       sha1_base_do_update(desc, data, len,
> -                           (sha1_block_fn *)sha1_ce_transform);
> +       sha1_base_do_update(desc, data, len, __sha1_ce_transform);
>         kernel_neon_end();
>
>         return 0;
> @@ -64,10 +70,9 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
>         sctx->finalize = finalize;
>
>         kernel_neon_begin();
> -       sha1_base_do_update(desc, data, len,
> -                           (sha1_block_fn *)sha1_ce_transform);
> +       sha1_base_do_update(desc, data, len, __sha1_ce_transform);
>         if (!finalize)
> -               sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
> +               sha1_base_do_finalize(desc, __sha1_ce_transform);
>         kernel_neon_end();
>         return sha1_base_finish(desc, out);
>  }
> @@ -81,7 +86,7 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
>
>         sctx->finalize = 0;
>         kernel_neon_begin();
> -       sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
> +       sha1_base_do_finalize(desc, __sha1_ce_transform);
>         kernel_neon_end();
>         return sha1_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> index 604a01a4ede6..6042555517b0 100644
> --- a/arch/arm64/crypto/sha2-ce-glue.c
> +++ b/arch/arm64/crypto/sha2-ce-glue.c
> @@ -28,6 +28,13 @@ struct sha256_ce_state {
>  asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
>                                   int blocks);
>
> +static inline void __sha2_ce_transform(struct sha256_state *sst, u8 const *src,
> +                                      int blocks)
> +{
> +       return sha2_ce_transform(container_of(sst, struct sha256_ce_state, sst),
> +                                src, blocks);
> +}
> +
>  const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
>                                               sst.count);
>  const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
> @@ -35,6 +42,12 @@ const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
>
>  asmlinkage void sha256_block_data_order(u32 *digest, u8 const *src, int blocks);
>
> +static inline void __sha256_block_data_order(struct sha256_state *sst,
> +                                            u8 const *src, int blocks)
> +{
> +       return sha256_block_data_order(sst->state, src, blocks);
> +}
> +
>  static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
>                             unsigned int len)
>  {
> @@ -42,12 +55,11 @@ static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
>
>         if (!crypto_simd_usable())
>                 return sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                               __sha256_block_data_order);
>
>         sctx->finalize = 0;
>         kernel_neon_begin();
> -       sha256_base_do_update(desc, data, len,
> -                             (sha256_block_fn *)sha2_ce_transform);
> +       sha256_base_do_update(desc, data, len, __sha2_ce_transform);
>         kernel_neon_end();
>
>         return 0;
> @@ -62,9 +74,8 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
>         if (!crypto_simd_usable()) {
>                 if (len)
>                         sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> -               sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                               __sha256_block_data_order);
> +               sha256_base_do_finalize(desc, __sha256_block_data_order);
>                 return sha256_base_finish(desc, out);
>         }
>
> @@ -75,11 +86,9 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
>         sctx->finalize = finalize;
>
>         kernel_neon_begin();
> -       sha256_base_do_update(desc, data, len,
> -                             (sha256_block_fn *)sha2_ce_transform);
> +       sha256_base_do_update(desc, data, len, __sha2_ce_transform);
>         if (!finalize)
> -               sha256_base_do_finalize(desc,
> -                                       (sha256_block_fn *)sha2_ce_transform);
> +               sha256_base_do_finalize(desc, __sha2_ce_transform);
>         kernel_neon_end();
>         return sha256_base_finish(desc, out);
>  }
> @@ -89,14 +98,13 @@ static int sha256_ce_final(struct shash_desc *desc, u8 *out)
>         struct sha256_ce_state *sctx = shash_desc_ctx(desc);
>
>         if (!crypto_simd_usable()) {
> -               sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +               sha256_base_do_finalize(desc, __sha256_block_data_order);
>                 return sha256_base_finish(desc, out);
>         }
>
>         sctx->finalize = 0;
>         kernel_neon_begin();
> -       sha256_base_do_finalize(desc, (sha256_block_fn *)sha2_ce_transform);
> +       sha256_base_do_finalize(desc, __sha2_ce_transform);
>         kernel_neon_end();
>         return sha256_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
> index e273faca924f..bb0f89382d70 100644
> --- a/arch/arm64/crypto/sha256-glue.c
> +++ b/arch/arm64/crypto/sha256-glue.c
> @@ -27,14 +27,26 @@ asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
>                                         unsigned int num_blks);
>  EXPORT_SYMBOL(sha256_block_data_order);
>
> +static inline void __sha256_block_data_order(struct sha256_state *sst,
> +                                            u8 const *src, int blocks)
> +{
> +       return sha256_block_data_order(sst->state, src, blocks);
> +}
> +
>  asmlinkage void sha256_block_neon(u32 *digest, const void *data,
>                                   unsigned int num_blks);
>
> +static inline void __sha256_block_neon(struct sha256_state *sst,
> +                                      u8 const *src, int blocks)
> +{
> +       return sha256_block_neon(sst->state, src, blocks);
> +}
> +
>  static int crypto_sha256_arm64_update(struct shash_desc *desc, const u8 *data,
>                                       unsigned int len)
>  {
>         return sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                                    __sha256_block_data_order);
>  }
>
>  static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
> @@ -42,9 +54,8 @@ static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
>  {
>         if (len)
>                 sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> -       sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                                     __sha256_block_data_order);
> +       sha256_base_do_finalize(desc, __sha256_block_data_order);
>
>         return sha256_base_finish(desc, out);
>  }
> @@ -87,7 +98,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
>
>         if (!crypto_simd_usable())
>                 return sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                               __sha256_block_data_order);
>
>         while (len > 0) {
>                 unsigned int chunk = len;
> @@ -103,8 +114,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
>                                 sctx->count % SHA256_BLOCK_SIZE;
>
>                 kernel_neon_begin();
> -               sha256_base_do_update(desc, data, chunk,
> -                                     (sha256_block_fn *)sha256_block_neon);
> +               sha256_base_do_update(desc, data, chunk, __sha256_block_neon);
>                 kernel_neon_end();
>                 data += chunk;
>                 len -= chunk;
> @@ -118,15 +128,13 @@ static int sha256_finup_neon(struct shash_desc *desc, const u8 *data,
>         if (!crypto_simd_usable()) {
>                 if (len)
>                         sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_order);
> -               sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_data_order);
> +                               __sha256_block_data_order);
> +               sha256_base_do_finalize(desc, __sha256_block_data_order);
>         } else {
>                 if (len)
>                         sha256_update_neon(desc, data, len);
>                 kernel_neon_begin();
> -               sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_neon);
> +               sha256_base_do_finalize(desc, __sha256_block_neon);
>                 kernel_neon_end();
>         }
>         return sha256_base_finish(desc, out);
> diff --git a/arch/arm64/crypto/sha512-ce-glue.c b/arch/arm64/crypto/sha512-ce-glue.c
> index 2369540040aa..076fcae454e0 100644
> --- a/arch/arm64/crypto/sha512-ce-glue.c
> +++ b/arch/arm64/crypto/sha512-ce-glue.c
> @@ -29,16 +29,21 @@ asmlinkage void sha512_ce_transform(struct sha512_state *sst, u8 const *src,
>
>  asmlinkage void sha512_block_data_order(u64 *digest, u8 const *src, int blocks);
>
> +static inline void __sha512_block_data_order(struct sha512_state *sst,
> +                                            u8 const *src, int blocks)
> +{
> +       return sha512_block_data_order(sst->state, src, blocks);
> +}
> +
>  static int sha512_ce_update(struct shash_desc *desc, const u8 *data,
>                             unsigned int len)
>  {
>         if (!crypto_simd_usable())
>                 return sha512_base_do_update(desc, data, len,
> -                               (sha512_block_fn *)sha512_block_data_order);
> +                                            __sha512_block_data_order);
>
>         kernel_neon_begin();
> -       sha512_base_do_update(desc, data, len,
> -                             (sha512_block_fn *)sha512_ce_transform);
> +       sha512_base_do_update(desc, data, len, sha512_ce_transform);
>         kernel_neon_end();
>
>         return 0;
> @@ -50,16 +55,14 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
>         if (!crypto_simd_usable()) {
>                 if (len)
>                         sha512_base_do_update(desc, data, len,
> -                               (sha512_block_fn *)sha512_block_data_order);
> -               sha512_base_do_finalize(desc,
> -                               (sha512_block_fn *)sha512_block_data_order);
> +                                             __sha512_block_data_order);
> +               sha512_base_do_finalize(desc, __sha512_block_data_order);
>                 return sha512_base_finish(desc, out);
>         }
>
>         kernel_neon_begin();
> -       sha512_base_do_update(desc, data, len,
> -                             (sha512_block_fn *)sha512_ce_transform);
> -       sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
> +       sha512_base_do_update(desc, data, len, sha512_ce_transform);
> +       sha512_base_do_finalize(desc, sha512_ce_transform);
>         kernel_neon_end();
>         return sha512_base_finish(desc, out);
>  }
> @@ -67,13 +70,12 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
>  static int sha512_ce_final(struct shash_desc *desc, u8 *out)
>  {
>         if (!crypto_simd_usable()) {
> -               sha512_base_do_finalize(desc,
> -                               (sha512_block_fn *)sha512_block_data_order);
> +               sha512_base_do_finalize(desc, __sha512_block_data_order);
>                 return sha512_base_finish(desc, out);
>         }
>
>         kernel_neon_begin();
> -       sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
> +       sha512_base_do_finalize(desc, sha512_ce_transform);
>         kernel_neon_end();
>         return sha512_base_finish(desc, out);
>  }
> diff --git a/arch/arm64/crypto/sha512-glue.c b/arch/arm64/crypto/sha512-glue.c
> index d915c656e5fe..125aac89c3c4 100644
> --- a/arch/arm64/crypto/sha512-glue.c
> +++ b/arch/arm64/crypto/sha512-glue.c
> @@ -20,15 +20,21 @@ MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_CRYPTO("sha384");
>  MODULE_ALIAS_CRYPTO("sha512");
>
> -asmlinkage void sha512_block_data_order(u32 *digest, const void *data,
> +asmlinkage void sha512_block_data_order(u64 *digest, const void *data,
>                                         unsigned int num_blks);
>  EXPORT_SYMBOL(sha512_block_data_order);
>
> +static inline void __sha512_block_data_order(struct sha512_state *sst,
> +                                            u8 const *src, int blocks)
> +{
> +       return sha512_block_data_order(sst->state, src, blocks);
> +}
> +
>  static int sha512_update(struct shash_desc *desc, const u8 *data,
>                          unsigned int len)
>  {
>         return sha512_base_do_update(desc, data, len,
> -                       (sha512_block_fn *)sha512_block_data_order);
> +                                    __sha512_block_data_order);
>  }
>
>  static int sha512_finup(struct shash_desc *desc, const u8 *data,
> @@ -36,9 +42,8 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
>  {
>         if (len)
>                 sha512_base_do_update(desc, data, len,
> -                       (sha512_block_fn *)sha512_block_data_order);
> -       sha512_base_do_finalize(desc,
> -                       (sha512_block_fn *)sha512_block_data_order);
> +                                     __sha512_block_data_order);
> +       sha512_base_do_finalize(desc, __sha512_block_data_order);
>
>         return sha512_base_finish(desc, out);
>  }
>
> base-commit: 96b95eff4a591dbac582c2590d067e356a18aacb
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
