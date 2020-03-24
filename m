Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC43191691
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCXQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:36:50 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38078 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCXQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:36:49 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so1693974pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2pRf2REXURXRcZCaSPd6oM79gOgGyCy4tzXJ0HzXK4=;
        b=nTXRVhVVQK18vJiOI9QEtE3oztRmvsZ9LN7dobmKBlTs3OupSuZ73YBBAa9xL3WWhS
         Kvr7UYcPBU9kyWCLTvjLTO7FaCvTUN0QLLqAfr7ufMcatipA/zxailOgSLjPZcmXLDZr
         5/+xHrqX68BCOwfcjhosi5SQuhv+rEye9CytncdcyOYBypKRlkM8IhuJkSpsZv7HdWpX
         E9TemcTHI+gUqFrwoGgzc7Em5tAimxLyJUsVysYcEKwV05HvkgW/ZBIl+3bfmfKBxsRx
         G7C/O+sbgY7cza0h57lFwdxfvgSxn7+DoDnlE6QtBIV2JUMIG19wiw02c6h0FPHiucIP
         YgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2pRf2REXURXRcZCaSPd6oM79gOgGyCy4tzXJ0HzXK4=;
        b=Ch8kbyOJqjbobZGpQwYq7CGTZqetyCZZOujOPQ7kc9m6EnaG5Vt26aTTsbIVKSYDZQ
         5wAYOjM179SXRxaBoEqhZO7Q5uO7H/0E6o22O6jyqSBNya8KMn/Skvwy69UYLk3dIN94
         a8Xt1PFx1Qq91j1+lwGlIuFqDg1PUFmiUzgxNiv+n+TteN9wAV7bILUHFsqdKu790eud
         gsU4f/PMcCY29Rsnv+NoMRxc8EBpu921E+H5jlpBQNuZaA5u+CGLYOU8h6+rFs9Yqz+J
         SqOGlUAlupsF4pOiFJDhag28c8rwdNI/JGI61IBiW4589rKV9tiX1jrhLhDLHrBrSQlb
         JJVw==
X-Gm-Message-State: ANhLgQ3cusEAcu+dFWfipdhoVz9jqiAOm2XbsKdy/UbyYLFQr/POhXFJ
        HdQ6kAMKWps2D/9HpfiILdmmpl1ygFVmCDt0ZWU+Pg==
X-Google-Smtp-Source: ADFU+vv/DktVGifIcKGtoAhDzxgmq73NqUnSJWt85sMwNnnr/0b3N9ytJ5fnqIuDFYJRWGWtJYaJz+UnMdi66hwgbTw=
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr23585647pln.179.1585067808195;
 Tue, 24 Mar 2020 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200324084821.29944-1-masahiroy@kernel.org> <20200324084821.29944-2-masahiroy@kernel.org>
In-Reply-To: <20200324084821.29944-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 09:36:36 -0700
Message-ID: <CAKwvOd=AXnAjoa0iOhPc4S49ZpDDX9BYB-BZQc=6Z0dygVYLPA@mail.gmail.com>
Subject: Re: [PATCH 01/16] lib/raid6/test: fix build on distros whose /bin/sh
 is not bash
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
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jim Kukunas <james.t.kukunas@linux.intel.com>,
        NeilBrown <neilb@suse.de>,
        Yuanhan Liu <yuanhan.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> You can test raid6 library code from user-space, like this:
>
>   $ cd lib/raid6/test
>   $ make
>
> The command in $(shell ...) function is evaluated by /bin/sh by default.
> (or, you can change the default shell by setting 'SHELL' in Makefile)
>
> Currently '>&/dev/null' is used to sink both stdout and stderr. Because
> this code is bash-ism, it only works when /bin/sh is a symbolic link to
> bash (this is the case on RHEL etc.)
>
> This does not work on Ubuntu where /bin/sh is a symbolic link to dash.
>
> I see lots of
>
>   /bin/sh: 1: Syntax error: Bad fd number
>
> and
>
>   warning "your version of binutils lacks ... support"
>
> Replace it with portable '>/dev/null 2>&1'.
>
> Fixes: 4f8c55c5ad49 ("lib/raid6: build proper files on corresponding arch")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>
>  lib/raid6/test/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
> index 3ab8720aa2f8..b9e6c3648be1 100644
> --- a/lib/raid6/test/Makefile
> +++ b/lib/raid6/test/Makefile
> @@ -35,13 +35,13 @@ endif
>  ifeq ($(IS_X86),yes)
>          OBJS   += mmx.o sse1.o sse2.o avx2.o recov_ssse3.o recov_avx2.o avx512.o recov_avx512.o
>          CFLAGS += $(shell echo "pshufb %xmm0, %xmm0" |         \
> -                    gcc -c -x assembler - >&/dev/null &&       \
> +                    gcc -c -x assembler - >/dev/null 2>&1 &&   \
>                      rm ./-.o && echo -DCONFIG_AS_SSSE3=1)
>          CFLAGS += $(shell echo "vpbroadcastb %xmm0, %ymm1" |   \
> -                    gcc -c -x assembler - >&/dev/null &&       \
> +                    gcc -c -x assembler - >/dev/null 2>&1 &&   \
>                      rm ./-.o && echo -DCONFIG_AS_AVX2=1)
>         CFLAGS += $(shell echo "vpmovm2b %k1, %zmm5" |          \
> -                   gcc -c -x assembler - >&/dev/null &&        \
> +                   gcc -c -x assembler - >/dev/null 2>&1 &&    \

These should all use $(CC) rather than hardcode gcc.

>                     rm ./-.o && echo -DCONFIG_AS_AVX512=1)
>  else ifeq ($(HAS_NEON),yes)
>          OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200324084821.29944-2-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
