Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6822016A9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBXPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:19:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35320 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgBXPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:19:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so9825008wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4JyKYMLcjkuhV880m1VVxSJ3o0/QSXYlmmHZLgGbBs=;
        b=UQK3K2Gl/itI8chGjYgrXBownF6wnW9i5V2SNuFZs/dNrGM09ZLSX64aMdnnzAgutA
         oKrfRbKXeF9+zXYd6vTkLgovyaOd/UvfhCcK2jz4u67rgtx3i7C5MF6xQmeeu8mLXw3T
         V/RfAUDa17bi8dtDDSuyWYIJs9Vo3e2Jjxg/tRAMlouup31lB5OU/n0CDDCpeg4bTO//
         RHbtjC8qHrmaa+oZzOgOG39hq5X36XK4oq/suw3ucXjuzlJMRpF88FmRjITsJO82QOZR
         sU7dYEbon/yAkTxssRVtqgRGXVGB13EW77sbti1/nnUn+Xk3rwiIg2iC2ahSTFPqaABV
         JHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4JyKYMLcjkuhV880m1VVxSJ3o0/QSXYlmmHZLgGbBs=;
        b=OweiXzPoE/i/QqaThVn7c1/GoCwTdMrAz4ZsDtSC8hOThHnF/Z/HtXASBofp8vVbJ9
         5DZSz4uPjTqhWVENPjkkiHoKI4QAH/Ik1SYgoMGPTpHr7Gr3TvgWtFXzEiYdCR5d8vuz
         RIgD1fPg261DbCAp7LSgdiEc/ICCXSoZwAGx7Gzj8VAzcziJn8HzFU0lwBH9GCpLaIFU
         tEbOTlDdx6AVElF4o/X8GlCImLUp159J1DuM4kXjrFsmP6j8bVKLhZ7LlKEvh4rWOquh
         HD7qzyvzg22UmAzRYKLPWtDEFC+uxcbTKpQtee8kh/ZpWbpK2PHhunf9TO/PQ1L20/eq
         1nyQ==
X-Gm-Message-State: APjAAAW1LF7p72G4SSDTwF9Ijw42BVATLaZgpmSC+Sz9e4i5H1cn5NOw
        G/vO8+gV88E+key/hmpz8+ELsenOAUSdWwF1JLe1wg==
X-Google-Smtp-Source: APXvYqyNLkwLtxz573uyNilTmTW64flEKaMcDZCZ2l6skMIlgyJjf9Fo58D2tGc5jJ9ztdftX1d6XORKQphA8ltIw5A=
X-Received: by 2002:a1c:282:: with SMTP id 124mr21977917wmc.62.1582557549834;
 Mon, 24 Feb 2020 07:19:09 -0800 (PST)
MIME-Version: 1.0
References: <1582555661-25737-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1582555661-25737-1-git-send-email-clabbe@baylibre.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Feb 2020 16:18:58 +0100
Message-ID: <CAKv+Gu9qyAov1mrOVH+fWizFk-a-MtbC4a95k21qG2cZaFD0Sg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: arm64: CE: implement export/import
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 at 15:47, Corentin Labbe <clabbe@baylibre.com> wrote:
>
> When an ahash algorithm fallback to another ahash and that fallback is
> shaXXX-CE, doing export/import lead to error like this:
> alg: ahash: sha1-sun8i-ce export() overran state buffer on test vector 0, cfg=\"import/export\"
>
> This is due to the descsize of shaxxx-ce being larger than struct shaxxx_state
> off by an u32.
> For fixing this, let's implement export/import which rip the finalize
> variant instead of using generic export/import.
>
> Fixes: 6ba6c74dfc6b ("arm64/crypto: SHA-224/SHA-256 using ARMv8 Crypto Extensions")
> Fixes: 2c98833a42cd ("arm64/crypto: SHA-1 using ARMv8 Crypto Extensions")
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> Changes since v1:
> - memcpy directly &sctx->sst instead of sctx. As suggested by Eric Biggers
>
>  arch/arm64/crypto/sha1-ce-glue.c | 20 ++++++++++++++++++++
>  arch/arm64/crypto/sha2-ce-glue.c | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> index 63c875d3314b..565ef604ca04 100644
> --- a/arch/arm64/crypto/sha1-ce-glue.c
> +++ b/arch/arm64/crypto/sha1-ce-glue.c
> @@ -91,12 +91,32 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
>         return sha1_base_finish(desc, out);
>  }
>
> +static int sha1_ce_export(struct shash_desc *desc, void *out)
> +{
> +       struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> +
> +       memcpy(out, &sctx->sst, sizeof(struct sha1_state));
> +       return 0;
> +}
> +
> +static int sha1_ce_import(struct shash_desc *desc, const void *in)
> +{
> +       struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> +
> +       memcpy(&sctx->sst, in, sizeof(struct sha1_state));
> +       sctx->finalize = 0;
> +       return 0;
> +}
> +
>  static struct shash_alg alg = {
>         .init                   = sha1_base_init,
>         .update                 = sha1_ce_update,
>         .final                  = sha1_ce_final,
>         .finup                  = sha1_ce_finup,
> +       .import                 = sha1_ce_import,
> +       .export                 = sha1_ce_export,
>         .descsize               = sizeof(struct sha1_ce_state),
> +       .statesize              = sizeof(struct sha1_state),
>         .digestsize             = SHA1_DIGEST_SIZE,
>         .base                   = {
>                 .cra_name               = "sha1",
> diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> index a8e67bafba3d..9450d19b9e6e 100644
> --- a/arch/arm64/crypto/sha2-ce-glue.c
> +++ b/arch/arm64/crypto/sha2-ce-glue.c
> @@ -109,12 +109,32 @@ static int sha256_ce_final(struct shash_desc *desc, u8 *out)
>         return sha256_base_finish(desc, out);
>  }
>
> +static int sha256_ce_export(struct shash_desc *desc, void *out)
> +{
> +       struct sha256_ce_state *sctx = shash_desc_ctx(desc);
> +
> +       memcpy(out, &sctx->sst, sizeof(struct sha256_state));
> +       return 0;
> +}
> +
> +static int sha256_ce_import(struct shash_desc *desc, const void *in)
> +{
> +       struct sha256_ce_state *sctx = shash_desc_ctx(desc);
> +
> +       memcpy(&sctx->sst, in, sizeof(struct sha256_state));
> +       sctx->finalize = 0;
> +       return 0;
> +}
> +
>  static struct shash_alg algs[] = { {
>         .init                   = sha224_base_init,
>         .update                 = sha256_ce_update,
>         .final                  = sha256_ce_final,
>         .finup                  = sha256_ce_finup,
> +       .export                 = sha256_ce_export,
> +       .import                 = sha256_ce_import,
>         .descsize               = sizeof(struct sha256_ce_state),
> +       .statesize              = sizeof(struct sha256_state),
>         .digestsize             = SHA224_DIGEST_SIZE,
>         .base                   = {
>                 .cra_name               = "sha224",
> @@ -128,7 +148,10 @@ static struct shash_alg algs[] = { {
>         .update                 = sha256_ce_update,
>         .final                  = sha256_ce_final,
>         .finup                  = sha256_ce_finup,
> +       .export                 = sha256_ce_export,
> +       .import                 = sha256_ce_import,
>         .descsize               = sizeof(struct sha256_ce_state),
> +       .statesize              = sizeof(struct sha256_state),
>         .digestsize             = SHA256_DIGEST_SIZE,
>         .base                   = {
>                 .cra_name               = "sha256",
> --
> 2.24.1
>
