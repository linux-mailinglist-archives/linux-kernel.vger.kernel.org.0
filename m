Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D7191708
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCXQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:56:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37119 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgCXQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:56:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so3605198plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TpragRZcw0zTQSnhep+0z7BDuiqv6MvTdfAt2UZcKM=;
        b=Nwb+jWCcjn9NJR+RcjP+pCjNIX2TKnhvcn+CdukBInhiqxe+4kpWzx2XVvwiTs35Db
         anejDfFLvHXMjlN6esfQebSFDE8jvNPruDjNGL6XPn6CGHHyFV8odwMG/yp8y6kBQymw
         moMX6fYvrelX7azVNFr/hCPmqFY+neNjc/5cKDmwiE3G+uL2H81syN4cqut0ZAis2Rh/
         BY70gmW0BFqnSevWKZ56xJOWzHhmmLVXuVFKynMpEj8G1eyxoJgKhRCe5r1quU8HPll3
         J+V0cb32oz++wAtJyG0Wwb9AJwdDA3BS+qMgrtZTKDtX307UWH6uu9kQbHuze+YcIBeO
         4S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TpragRZcw0zTQSnhep+0z7BDuiqv6MvTdfAt2UZcKM=;
        b=NB+C4y3ROm2Q31wcrBGlOzWktKyYMusgaCDxp29Ffh22OePDZGWd7Bum9390s+gQ4W
         PZhoRWDl3HvrDHGcnMSsJiLGpGpJn8o/X8Mwo3MhaQUJ10rHqxSEUR+1BqHZjo81/51M
         0w9DOkf1KS8wiSD+Xefa6m7QjNVKpN05ozj2T9KpIc1V93RoJ7NcmAW1DKdZeI7JvxD4
         dJU9Et0pXANakaE+qqlXDny8N4uwua5ubeYpZP2CO4bIvaKBvdVPeSo02x3OyrQMEWQT
         AIYKKu2loSi44Obe+V6BQkyZaNjpSisGzp1OD1XcSCIZnpc66eFMTlFYyynYWt4+Q/w8
         woEQ==
X-Gm-Message-State: ANhLgQ1EBqDVxMdf5ubF1OGgMf05ouAbDYJ7VCoT5KGjmxibUnIFskT2
        wQikoFfL690qPqYYpXhPvJYpRrlBzB+VaWt/GrgSoA==
X-Google-Smtp-Source: ADFU+vtw53dprFB9oag0X9HXc73Rj1Tqjmp7Haecp9myvzWRS4U3Q+BL3AsSaJXvT2i+fS/FCIiRFkU8ta8vOSlVCEc=
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr21047743plt.223.1585068990536;
 Tue, 24 Mar 2020 09:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200324084821.29944-1-masahiroy@kernel.org> <20200324084821.29944-7-masahiroy@kernel.org>
In-Reply-To: <20200324084821.29944-7-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 09:56:18 -0700
Message-ID: <CAKwvOdkc6WgW7Knnk8rb92iYUOjc7bBZ6Ln69jjRa+N=-JLz+g@mail.gmail.com>
Subject: Re: [PATCH 06/16] x86: remove always-defined CONFIG_AS_SSSE3
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_SSSE3 was introduced by commit 75aaf4c3e6a4 ("x86/raid6:
> correctly check for assembler capabilities").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").

Looks like binutils gained SSE3 support in 2005; 2.21 was released in 2010.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by LLVM integrated assembler.
>
> Remove CONFIG_AS_SSSE3, which is always defined.
>
> I added ifdef CONFIG_X86 to lib/raid6/algos.c to avoid link errors
> on non-x86 architectures.
>
> lib/raid6/algos.c is built not only for the kernel but also for
> testing the library code from userspace. I added -DCONFIG_X86 to
> lib/raid6/test/Makefile to cator to this usecase.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>
>  arch/x86/Makefile              | 5 ++---
>  arch/x86/crypto/blake2s-core.S | 2 --
>  lib/raid6/algos.c              | 2 +-
>  lib/raid6/recov_ssse3.c        | 6 ------
>  lib/raid6/test/Makefile        | 4 +---
>  5 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index e4a062313bb0..94f89612e024 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -178,7 +178,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>  endif
>
>  # does binutils support specific instructions?
> -asinstr += $(call as-instr,pshufb %xmm0$(comma)%xmm0,-DCONFIG_AS_SSSE3=1)
>  avx_instr := $(call as-instr,vxorps %ymm0$(comma)%ymm1$(comma)%ymm2,-DCONFIG_AS_AVX=1)
>  avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
>  avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)
> @@ -186,8 +185,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
>  sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
>  adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
>
> -KBUILD_AFLAGS += $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -KBUILD_CFLAGS += $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_AFLAGS += $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_CFLAGS += $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
>
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>
> diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/crypto/blake2s-core.S
> index 24910b766bdd..2ca79974f819 100644
> --- a/arch/x86/crypto/blake2s-core.S
> +++ b/arch/x86/crypto/blake2s-core.S
> @@ -46,7 +46,6 @@ SIGMA2:
>  #endif /* CONFIG_AS_AVX512 */
>
>  .text
> -#ifdef CONFIG_AS_SSSE3
>  SYM_FUNC_START(blake2s_compress_ssse3)
>         testq           %rdx,%rdx
>         je              .Lendofloop
> @@ -174,7 +173,6 @@ SYM_FUNC_START(blake2s_compress_ssse3)
>  .Lendofloop:
>         ret
>  SYM_FUNC_END(blake2s_compress_ssse3)
> -#endif /* CONFIG_AS_SSSE3 */
>
>  #ifdef CONFIG_AS_AVX512
>  SYM_FUNC_START(blake2s_compress_avx512)
> diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
> index bf1b4765c8f6..df08664d3432 100644
> --- a/lib/raid6/algos.c
> +++ b/lib/raid6/algos.c
> @@ -97,13 +97,13 @@ void (*raid6_datap_recov)(int, size_t, int, void **);
>  EXPORT_SYMBOL_GPL(raid6_datap_recov);
>
>  const struct raid6_recov_calls *const raid6_recov_algos[] = {
> +#ifdef CONFIG_X86
>  #ifdef CONFIG_AS_AVX512
>         &raid6_recov_avx512,
>  #endif
>  #ifdef CONFIG_AS_AVX2
>         &raid6_recov_avx2,
>  #endif
> -#ifdef CONFIG_AS_SSSE3
>         &raid6_recov_ssse3,
>  #endif
>  #ifdef CONFIG_S390
> diff --git a/lib/raid6/recov_ssse3.c b/lib/raid6/recov_ssse3.c
> index 1de97d2405d0..4bfa3c6b60de 100644
> --- a/lib/raid6/recov_ssse3.c
> +++ b/lib/raid6/recov_ssse3.c
> @@ -3,8 +3,6 @@
>   * Copyright (C) 2012 Intel Corporation
>   */
>
> -#ifdef CONFIG_AS_SSSE3
> -
>  #include <linux/raid/pq.h>
>  #include "x86.h"
>
> @@ -328,7 +326,3 @@ const struct raid6_recov_calls raid6_recov_ssse3 = {
>  #endif
>         .priority = 1,
>  };
> -
> -#else
> -#warning "your version of binutils lacks SSSE3 support"
> -#endif
> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
> index b9e6c3648be1..60021319ac78 100644
> --- a/lib/raid6/test/Makefile
> +++ b/lib/raid6/test/Makefile
> @@ -34,9 +34,7 @@ endif
>
>  ifeq ($(IS_X86),yes)
>          OBJS   += mmx.o sse1.o sse2.o avx2.o recov_ssse3.o recov_avx2.o avx512.o recov_avx512.o
> -        CFLAGS += $(shell echo "pshufb %xmm0, %xmm0" |         \
> -                    gcc -c -x assembler - >/dev/null 2>&1 &&   \
> -                    rm ./-.o && echo -DCONFIG_AS_SSSE3=1)
> +        CFLAGS += -DCONFIG_X86
>          CFLAGS += $(shell echo "vpbroadcastb %xmm0, %ymm1" |   \
>                      gcc -c -x assembler - >/dev/null 2>&1 &&   \
>                      rm ./-.o && echo -DCONFIG_AS_AVX2=1)
> --
> 2.17.1
>
> --

-- 
Thanks,
~Nick Desaulniers
