Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1AA7D4B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 07:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfHAFCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 01:02:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfHAFCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:02:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so2710288wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lMqNv0u8vBtruasmPaSSkIba00POWJCMhQidPLWHY2M=;
        b=dol+D83wA19zSVl89V10SNxHVy3VlznKnl5Umucz1gmDWVF7T8xfFC2TsjaHKxbd5p
         MWqtlXDMw9eXmw49icqt8ZgKuwj6EkQkGCJZ2yeGvcEy9ofj0w0wSG3gk1nMsx14MEEo
         zAv965eqloPiIVBPO2FOXLVcKgZlOupIwdZJky3vmh+gPvQhmxK459/wGlQ2S0RUzW8N
         6U7n4UHPgVStZErjETjSp2udtUh+I7TLF5PveAGoONlFJzPlMKazI2ZHhWIMGWwgKzH3
         X5T7KrYIUyMOcO3cYiej1UpibwurUn/vZVF8VPIn60bQwSZ6+r1RUOHl+Kj3tG1HnOM+
         N4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lMqNv0u8vBtruasmPaSSkIba00POWJCMhQidPLWHY2M=;
        b=ckZ0ssF76rqyBN73AKIrg07F9deuBGbgFEQaSobuS3kRgggGMmJNPbdeng9PhdzJhM
         L1L2EBJKNA6Mu31dzsWYsjMy2xe5mDz0heezAsfEmKGc//er21dLs5Ehg/CLzmD0l1DK
         GG+bZkcfHzRpGTvd1pVn85hrHlVgK0ps2QzSiwePb6AUFkHCdmNqvXGMP7r8eYPWMr5z
         /OZBc5M3YrHJJ2RdV6w1+dg5yRcQeyHFzzGgEh6EhMus1FCCiaP00vK1/vZx/x3Wen5K
         5MeP7Vo6vlW2swVXACtRuHVUhInxGJ0bwFoVcdnEa7HiGMBS6y7BfnZXrcDlxkwDFIc5
         rjzQ==
X-Gm-Message-State: APjAAAWvl+NTc2D5WioruQG7/UAA80ablbx/Y2jGODYTxvjEzxGCxz4P
        LKPl7Pm7t0IPnlmagXYzjyyp6PD5L/2A+UCPwPhUuQ==
X-Google-Smtp-Source: APXvYqzW9Hm/OljmGnTNE3pQDpI/o8Ig99QXpNTASPVxDa38zfbVgd64ARE5k51pWFYGwCPqbIFwrAG+M8Ie4C+Isp4=
X-Received: by 2002:a1c:b706:: with SMTP id h6mr110550423wmf.119.1564635726867;
 Wed, 31 Jul 2019 22:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <13353.1564635114@turing-police>
In-Reply-To: <13353.1564635114@turing-police>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 1 Aug 2019 08:01:54 +0300
Message-ID: <CAKv+Gu8EF3R05hLWHh7mgbgkUyzBwELctdVvSFMq+6Crw6Tf4A@mail.gmail.com>
Subject: Re: [PATCH] linux-next 20190731 - aegis128-core.c fails to build
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Arnd)

On Thu, 1 Aug 2019 at 07:52, Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu=
> wrote:
>
> The recent NEON SIMD patches break the build if CONFIG_CRYPTO_AEGIS128_SI=
MD isn't set:
>
>   MODPOST 558 modules
> ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefine=
d!
> ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefine=
d!
> make[1]: *** [scripts/Makefile.modpost:105: modules-modpost] Error 1
> make: *** [Makefile:1299: modules] Error 2
>
> Add proper definitions and stubs to aegis.h so it builds both ways. This
> necessitated moving other stuff from aegis128-core.c to aegis.h so things=
 were
> defined in the proper order.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Which compiler version are you using? All references to the
crypt_aegis128_xx_simd() routines should disappear if
CONFIG_CRYPTO_AEGIS128_SIMD is not set (in which case have_simd will
always be false and so the compiler should optimize away those calls).


> ---
> diff --git a/crypto/aegis.h b/crypto/aegis.h
> index 4d56a85aea49..50a7496ca4ae 100644
> --- a/crypto/aegis.h
> +++ b/crypto/aegis.h
> @@ -13,6 +13,11 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>
> +#define AEGIS128_NONCE_SIZE 16
> +#define AEGIS128_STATE_BLOCKS 5
> +#define AEGIS128_KEY_SIZE 16
> +#define AEGIS128_MIN_AUTH_SIZE 8
> +#define AEGIS128_MAX_AUTH_SIZE 16
>  #define AEGIS_BLOCK_SIZE 16
>
>  union aegis_block {
> @@ -21,6 +26,39 @@ union aegis_block {
>         u8 bytes[AEGIS_BLOCK_SIZE];
>  };
>
> +struct aegis_state {
> +       union aegis_block blocks[AEGIS128_STATE_BLOCKS];
> +};
> +
> +struct aegis_ctx {
> +       union aegis_block key;
> +};
> +
> +struct aegis128_ops {
> +       int (*skcipher_walk_init)(struct skcipher_walk *walk,
> +                                 struct aead_request *req, bool atomic);
> +
> +       void (*crypt_chunk)(struct aegis_state *state, u8 *dst,
> +                           const u8 *src, unsigned int size);
> +};
> +
> +
> +#ifdef CONFIG_CRYPTO_AEGIS128_SIMD
> +bool crypto_aegis128_have_simd(void);
> +void crypto_aegis128_update_simd(struct aegis_state *state, const void *=
msg);
> +void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *d=
st,
> +                                       const u8 *src, unsigned int size)=
;
> +void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *d=
st,
> +                                       const u8 *src, unsigned int size)=
;
> +#else
> +static inline bool crypto_aegis128_have_simd(void) { return false; }
> +static inline void crypto_aegis128_update_simd(struct aegis_state *state=
, const void *msg) { }
> +static inline void crypto_aegis128_encrypt_chunk_simd(struct aegis_state=
 *state, u8 *dst,
> +                                       const u8 *src, unsigned int size)=
 { }
> +static inline void crypto_aegis128_decrypt_chunk_simd(struct aegis_state=
 *state, u8 *dst,
> +                                       const u8 *src, unsigned int size)=
 { }
> +#endif
> +
>  #define AEGIS_BLOCK_ALIGN (__alignof__(union aegis_block))
>  #define AEGIS_ALIGNED(p) IS_ALIGNED((uintptr_t)p, AEGIS_BLOCK_ALIGN)
>
> diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
> index f815b4685156..8b738128a921 100644
> --- a/crypto/aegis128-core.c
> +++ b/crypto/aegis128-core.c
> @@ -20,37 +20,8 @@
>
>  #include "aegis.h"
>
> -#define AEGIS128_NONCE_SIZE 16
> -#define AEGIS128_STATE_BLOCKS 5
> -#define AEGIS128_KEY_SIZE 16
> -#define AEGIS128_MIN_AUTH_SIZE 8
> -#define AEGIS128_MAX_AUTH_SIZE 16
> -
> -struct aegis_state {
> -       union aegis_block blocks[AEGIS128_STATE_BLOCKS];
> -};
> -
> -struct aegis_ctx {
> -       union aegis_block key;
> -};
> -
> -struct aegis128_ops {
> -       int (*skcipher_walk_init)(struct skcipher_walk *walk,
> -                                 struct aead_request *req, bool atomic);
> -
> -       void (*crypt_chunk)(struct aegis_state *state, u8 *dst,
> -                           const u8 *src, unsigned int size);
> -};
> -
>  static bool have_simd;
>
> -bool crypto_aegis128_have_simd(void);
> -void crypto_aegis128_update_simd(struct aegis_state *state, const void *=
msg);
> -void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *d=
st,
> -                                       const u8 *src, unsigned int size)=
;
> -void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *d=
st,
> -                                       const u8 *src, unsigned int size)=
;
> -
>  static void crypto_aegis128_update(struct aegis_state *state)
>  {
>         union aegis_block tmp;
>
