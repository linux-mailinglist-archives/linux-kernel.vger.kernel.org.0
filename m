Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013EA199CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgCaRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 13:32:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57032 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:32:32 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02VHWEbr021936
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 02:32:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02VHWEbr021936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585675935;
        bh=apzVeH3ZSZdTyLs9ucwBXEBHGGEys7AlSqP5ZhodY/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jVD0O/Vz8GNkLQaEWHiA4syrRtVzekwW9C0TQ3uo0gRYQi+4/ErCZWFBUwToaqxcB
         34RDj8076HlqoQCu1gpEblQqyYH5zmvEt7XH0GwXtKWQAxqTPVeqNJwaD3CTXOWLIn
         XF6HTHuxlHjcg0JifijvyALAXi+T/IEu5GfGpkU6q/7F6JKxIjoBrmIE+D1W1dW0Ji
         2r8UPWdSaKXhVMH0AmDYIR8+wAjttSir53hIwwgp6985qwc7UwMJuXeICJ8PyCRuzd
         TGPKLdetGnbu18SJnnIwASpmIQ+MNi846gUUSWLFASp2Q9xchGpClkPBPenbMQRF9N
         s9vMSGhFZOB0A==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id v129so5586570vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:32:15 -0700 (PDT)
X-Gm-Message-State: AGi0PuYogJYupHtQao6mDVUsmj9Xm2t+KBa76v/iX6LoSZLK03McXhJq
        eRrYeo7p6No8cVoHXI61lVr27FPd6GhJ8UEhfN8=
X-Google-Smtp-Source: APiQypLWtcZNBT5k0XdyG6N1qNydV6VOWdeWVVfre24H4CMJHh4qtiwTan0lXaOfWxgS6a+lpjafRPbY4fShNgrYUEY=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr12581684vky.96.1585675934026;
 Tue, 31 Mar 2020 10:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
In-Reply-To: <20200331112637.25047-1-vegard.nossum@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Apr 2020 02:31:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSaTGV926oA7qJGf6n03BaJ2R6fO8ZeZor2j45bqLqSA@mail.gmail.com>
Message-ID: <CAK7LNASSaTGV926oA7qJGf6n03BaJ2R6fO8ZeZor2j45bqLqSA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ian Abbott <abbotti@mev.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 8:28 PM Vegard Nossum <vegard.nossum@oracle.com> wr=
ote:
>
> compiletime_assert() uses __LINE__ to create a unique function name.
> This means that if you have more than one BUILD_BUG_ON() in the same
> source line (which can happen if they appear e.g. in a macro), then
> the error message from the compiler might output the wrong condition.
>
> For this source file:
>
>         #include <linux/build_bug.h>
>
>         #define macro() \
>                 BUILD_BUG_ON(1); \
>                 BUILD_BUG_ON(0);
>
>         void foo()
>         {
>                 macro();
>         }
>
> gcc would output:
>
> ./include/linux/compiler.h:350:38: error: call to =E2=80=98__compiletime_=
assert_9=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>
> However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
> instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
> each BUILD_BUG_ON() gets a different function name and the correct
> condition is printed:
>
> ./include/linux/compiler.h:350:38: error: call to =E2=80=98__compiletime_=
assert_0=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: 1
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>
> Cc: Daniel Santos <daniel.santos@pobox.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




> Cc: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 5e88e7e33abec..034b0a644efcc 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
>   * compiler has support to do so.
>   */
>  #define compiletime_assert(condition, msg) \
> -       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE=
__)
> +       _compiletime_assert(condition, msg, __compiletime_assert_, __COUN=
TER__)
>
>  #define compiletime_assert_atomic_type(t)                              \
>         compiletime_assert(__native_word(t),                            \
> --
> 2.16.1.72.g5be1f00a9.dirty
>


--=20
Best Regards
Masahiro Yamada
