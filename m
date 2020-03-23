Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4A18FDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCWTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 15:46:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43748 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:46:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so7727239pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtqwWatKpD7SofVT0EoTqpDu0ZUD5i4Sz54oEJu3/Dw=;
        b=vgXynoJTySUcoHgVdDm+LazyPhMM1Y197xQjVT9YozDU8bvD3JlxvxI5QtTeUoOVmR
         PQ0ygD2K5NGp67x0Rc4Lyeb9ZhnN5yxMpTgnjXiRqoVLScrYlM+VDqc3WE9uQveI/1P8
         2znax2dxzmK1WFcFCb3ZvCGcY9chG6Xi5JyzXjHypU3WGqqp/J9WpSOmbxcYLBxsZJ8e
         FmRbscZdwxmnn1DfXwA6mTR5ywoEQwAacX608dJoUQKc7k/WBAbu/6b6EUd9pqt0iLjl
         i9sym3PfZv7MXeAKD/8/XGfqPg1atQkXVky/ji8FG2SkwmN+VBr6I7aJoqRXqB0mhvtM
         tj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtqwWatKpD7SofVT0EoTqpDu0ZUD5i4Sz54oEJu3/Dw=;
        b=WUvbQJ0emfrd1/peactjK6FwjMWNWPqrUBHJlp7cEbFwm8gUpnS17xb7VgW0ff8oCo
         56TCO62bsIz+YNfP/TY0h6p+tTzA4VC4xP0hlUh4yil/foiz+Jo69yeymnl5yFlMLSwx
         cgHMpmkA0GVZCR6CRzhHUbxhuEd4yg8v+aeOfiIcbX1uX8ANJ0LM/iTcIuIlkcL/hCtg
         7fn0b7ZQMkE4iHHuM07TQ9+yeyIU3kCL+VoOj4rYtyEZAFEvf0wcGw6BEKV2lS5Mr6F4
         +9kwoxhKSWqu0MtmRvPsLKg+KGnDvl2UWoeJtQy10IRRSPhObrzCfK7mB3aoZSWJWoa/
         gj6g==
X-Gm-Message-State: ANhLgQ1g/fW1V5Tpc2rvLSZcfTOl8xlzD2B7NejIFhX0zuvwfveEQyXs
        jvUvf7RHX/3OLf1deFLN+KGzeZB4LBL1sm5fyWRIZg==
X-Google-Smtp-Source: ADFU+vshC7+kzkmu2zUDZAt4WA6bUsvpCEOCvNCXQOT/vtxbuGNUMhtlqdiIfBnsJCSlpdv8McZrNQlT5LxKHpC0owo=
X-Received: by 2002:a63:4453:: with SMTP id t19mr22402443pgk.381.1584992768425;
 Mon, 23 Mar 2020 12:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200323020844.17064-1-masahiroy@kernel.org>
In-Reply-To: <20200323020844.17064-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 12:45:56 -0700
Message-ID: <CAKwvOdm1B=Wc6zcxpapcbeReX0_2V3AiqxGUgikL4ypztZkUEg@mail.gmail.com>
Subject: Re: [PATCH 0/7] x86: remove always-defined CONFIG_AS_* options
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Song Liu <songliubraving@fb.com>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 7:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> arch/x86/Makefile tests instruction code by $(call as-instr, ...)
>
> Some of them are very old.
> For example, the check for CONFIG_AS_CFI dates back to 2006.
>
> We raise GCC versions from time to time, and we clean old code away.
> The same policy applied to binutils.
>
> The current minimal supported version of binutils is 2.21
>
> This is new enough to recognize the instruction in most of
> as-instr calls.

I'm quite happy to see this series; a few weekends ago I was playing
around with adding dwarf-5 support to the Linux kernel, and was
looking at these noticing there was quite a bit of cruft.
Unfortunately, I got detoured filing bugs against GNU as for dwarf-5
bugs, but the developers were very responsive and fixed them all.  I
should go find and dust off that patchset.  In the meantime, I'll try
to help review these patches. Thank you for sending them.

>
>
>
> Masahiro Yamada (7):
>   x86: remove unneeded defined(__ASSEMBLY__) check from asm/dwarf2.h
>   x86: remove always-defined CONFIG_AS_CFI
>   x86: remove always-defined CONFIG_AS_CFI_SIGNAL_FRAME
>   x86: remove always-defined CONFIG_AS_CFI_SECTIONS
>   x86: remove always-defined CONFIG_AS_SSSE3
>   x86: remove always-defined CONFIG_AS_AVX
>   x86: add comments about the binutils version to support code in
>     as-instr
>
>  arch/x86/Makefile                             | 21 +++------
>  arch/x86/crypto/Makefile                      | 32 ++++++--------
>  arch/x86/crypto/aesni-intel_avx-x86_64.S      |  3 --
>  arch/x86/crypto/aesni-intel_glue.c            | 14 +-----
>  arch/x86/crypto/blake2s-core.S                |  2 -
>  arch/x86/crypto/poly1305-x86_64-cryptogams.pl |  8 ----
>  arch/x86/crypto/poly1305_glue.c               |  6 +--
>  arch/x86/crypto/sha1_ssse3_asm.S              |  4 --
>  arch/x86/crypto/sha1_ssse3_glue.c             |  9 +---
>  arch/x86/crypto/sha256-avx-asm.S              |  3 --
>  arch/x86/crypto/sha256_ssse3_glue.c           |  8 +---
>  arch/x86/crypto/sha512-avx-asm.S              |  2 -
>  arch/x86/crypto/sha512_ssse3_glue.c           |  7 +--
>  arch/x86/include/asm/dwarf2.h                 | 43 -------------------
>  arch/x86/include/asm/xor_avx.h                |  9 ----
>  lib/raid6/algos.c                             |  2 -
>  lib/raid6/recov_ssse3.c                       |  6 ---
>  lib/raid6/test/Makefile                       |  3 --
>  18 files changed, 26 insertions(+), 156 deletions(-)
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200323020844.17064-1-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
