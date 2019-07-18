Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA56D655
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 23:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbfGRVRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 17:17:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37292 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfGRVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:17:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so13179340pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RheZEo0ByWVoAsse+7+UzvQGL1lauI18cqCeYYEU2X4=;
        b=itwJ/6Zo6ire+6bY6hv/pHAeUJPBFE0mWVZnPXePsf/QCBsQoyCkvttntCGmZgpt9q
         di/Tml8A3uZ0iGk9DEVxW9HY1uF7ArPmEZ/UVzu940F6WjerA2LRyzN8JvbSaI/msr99
         A/E5jXKI5Eppe+p99lyQeYLNzcbNg5YciIM9MWBbs/P3RoWvlK+N/bz3qlsfRwZgzIxs
         eYoJPyEMm3drO2JNaQkdca3XU3sPsszzTWIF6u/sNGNVEZIcRLO0wS0SZ8leeC1cFS1Q
         RPxB72BpTO+9tXVFOqiYLj4NsRV2QiH+AVdCbLe9YfuQv8XtvyIXFh7GUYVqdnPP7y1Y
         iDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RheZEo0ByWVoAsse+7+UzvQGL1lauI18cqCeYYEU2X4=;
        b=lD2V2qo2KrL47RE25w2mANoeOeU4po51RO4prY8f3HY3mYxbSGxPfCoEiw6wp25r+Y
         ECgLtTMYYd939Vwhi+6L+0soiPwpmo0+v3zS0b4FM3G0G5J05VPh7GPNLkIaRUYC0UPo
         gvSYU+vUu3QYc7+Z5m3gCGU1YcInbFCcpbaJbuPp83+DeOLgF10D7YwxEUtVStel+Oh5
         3Qczo4LdVbkqF/6exq3Lio7g4yMTAONmtUWph9rcqUrrKUbTR6mw2oM/eDisGk0JWtuG
         61mVQ9NxXENKdZJXQyQWGWSz4TQDstJ60/lYCzrBhx4kAzJo6H9j5VoZQWzHCMLavPUt
         C61g==
X-Gm-Message-State: APjAAAVrJit5HDxiTwof2vZLVS7UXo+Bx2okrFEZlfUTAK5aE8TDl5EO
        9cb05BQoO0sVOpMWNPjayBukeNFKUlF0akm/aPuNsw==
X-Google-Smtp-Source: APXvYqymD3aZQjaUYh2vja626iApTb0mflzjq8KhKYrkBfBW1qEnkrZNy9omKOFqWN6nM+ILbWAQkpFSVU2vHEbSpMM=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr46303202pgs.10.1563484636536;
 Thu, 18 Jul 2019 14:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190718135017.2493006-1-arnd@arndb.de>
In-Reply-To: <20190718135017.2493006-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 14:17:05 -0700
Message-ID: <CAKwvOd=HEjDA7pcsQvONoHgU2JH3xz+9MwHU0pXKathDRQx=nQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: aegis: fix badly optimized clang output
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:50 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Clang sometimes makes very different inlining decisions from gcc.
> In case of the aegis crypto algorithms, it decides to turn the innermost
> primitives (and, xor, ...) into separate functions but inline most of
> the rest.
>
> This results in a huge amount of variables spilled on the stack, leading
> to rather slow execution as well as kernel stack usage beyond the 32-bit
> warning limit when CONFIG_KASAN is enabled:
>
> crypto/aegis256.c:123:13: warning: stack frame size of 648 bytes in function 'crypto_aegis256_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis256.c:366:13: warning: stack frame size of 1264 bytes in function 'crypto_aegis256_crypt' [-Wframe-larger-than=]
> crypto/aegis256.c:187:13: warning: stack frame size of 656 bytes in function 'crypto_aegis256_decrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128l.c:135:13: warning: stack frame size of 832 bytes in function 'crypto_aegis128l_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128l.c:415:13: warning: stack frame size of 1480 bytes in function 'crypto_aegis128l_crypt' [-Wframe-larger-than=]
> crypto/aegis128l.c:218:13: warning: stack frame size of 848 bytes in function 'crypto_aegis128l_decrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128.c:116:13: warning: stack frame size of 584 bytes in function 'crypto_aegis128_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128.c:351:13: warning: stack frame size of 1064 bytes in function 'crypto_aegis128_crypt' [-Wframe-larger-than=]
> crypto/aegis128.c:177:13: warning: stack frame size of 592 bytes in function 'crypto_aegis128_decrypt_chunk' [-Wframe-larger-than=]
>
> Forcing the primitives to all get inlined avoids the issue and the
> resulting code is similar to what gcc produces.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/aegis.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/aegis.h b/crypto/aegis.h
> index 41a3090cda8e..efed7251c49d 100644
> --- a/crypto/aegis.h
> +++ b/crypto/aegis.h
> @@ -34,21 +34,21 @@ static const union aegis_block crypto_aegis_const[2] = {
>         } },
>  };
>
> -static void crypto_aegis_block_xor(union aegis_block *dst,
> +static __always_inline void crypto_aegis_block_xor(union aegis_block *dst,

`static inline` would be more concise and expand to the same
attribute, IIRC.  Not sure if that's worth sending a v2. But for now,
thanks for the patch and:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
