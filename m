Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAFDCBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408895AbfJRQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:43:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfJRQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:43:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so3100269pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itPDN3uOMullCrqvdWp4VHOtEiVy99lUJjyxqObTixM=;
        b=a4KqHH64Syi3Jkb+d0eVgCpN+31SnDYFhDKhObeeBYgIxsVpB28MK9tNghzsFxuX+N
         VbAKU58UasFmej23pHOk0QrDLH7oKDm4M3dk3bgCtTUWOgQmltwfMriaPvVLpxp3C0pC
         kYoPXPqJx0ajXSrYjPEgK8592+nVdo/5DSLpSz/Itc5Br1qMc82P+2UjLLk4LyZ199qw
         YdBPa6JePJa0Fd7+ocz3Fs2qom1i2u3DIw3HjxianaEOsPf5x+/L3CFK6vBNgDV9SqT3
         pgNBOC5FZlvErDViSZm4W/P+hr6vWNgjySr+vmQ1yyL5jifp07AxbcGC3bkxHitLbGMK
         lX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itPDN3uOMullCrqvdWp4VHOtEiVy99lUJjyxqObTixM=;
        b=a0gMqMytW5nOPOcaOwkJCKhNJcxJr6c+AKqe/XFlbuNit8mvTi+C1+7OZHljfPuCYs
         Phl7Z1D30CPdfeVbGLSZIFV0FvlguaHmrKh8jsqIA2u5rd+30fHvSHF9neiAiGhACL8+
         +9PlyjuJfrm54nfb7twC0w2GeeStBZ26Y/f97ZWbO0rJodxjqYPA5oQuBDFQlTtsns0H
         nUhZdsZ88qDlKtsm7C1J4XYTOYDDDwtjdvDJMTURAq7ACafNzeojJJh6/qSEg6+DRRLk
         b7wlI1xox1Nz4ltVhwIkHW/gOOPrwWmdC79PPxWKm4W36Y9QyTwryb+3AFVgFADIo2Ik
         DqCA==
X-Gm-Message-State: APjAAAVhB9KFP2ZZi5ZZ5zgsrt4egerajbYE6ASWCTf+B2+FkqXrLLww
        CI/UiTr4Ea5KVXSYi0K7IqUfyY6VYZ959XUUHqnN9g==
X-Google-Smtp-Source: APXvYqxjABHlLirt3mzHAGsgLEpxUZMPZex/FsD7C0vJFW62s876ojGzoWlX6A4J5FwacSy764TFAtK8KXx4Wiz+QQw=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr10710877plp.179.1571417011191;
 Fri, 18 Oct 2019 09:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-2-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-2-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 09:43:20 -0700
Message-ID: <CAKwvOd=rspmzW+v=nG=07H5XZ2OPWVbhDusYEe3k5+mZ79JvwA@mail.gmail.com>
Subject: Re: [PATCH 01/18] arm64: mm: don't use x18 in idmap_kpti_install_ng_mappings
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:10 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> idmap_kpti_install_ng_mappings uses x18 as a temporary register, which
> will result in a conflict when x18 is reserved. Use x16 and x17 instead
> where needed.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

TIL about .req/.unreq.  Seems like a nice way of marking "variable"
lifetime.  Technically, only `pte` needed to be moved to reuse
{w|x}16, but moving most the unreqs together is nicer than splitting
them apart. The usage all looks correct to me.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm64/mm/proc.S | 63 ++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index a1e0592d1fbc..fdabf40a83c8 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -250,15 +250,15 @@ ENTRY(idmap_kpti_install_ng_mappings)
>         /* We're the boot CPU. Wait for the others to catch up */
>         sevl
>  1:     wfe
> -       ldaxr   w18, [flag_ptr]
> -       eor     w18, w18, num_cpus
> -       cbnz    w18, 1b
> +       ldaxr   w17, [flag_ptr]
> +       eor     w17, w17, num_cpus
> +       cbnz    w17, 1b
>
>         /* We need to walk swapper, so turn off the MMU. */
>         pre_disable_mmu_workaround
> -       mrs     x18, sctlr_el1
> -       bic     x18, x18, #SCTLR_ELx_M
> -       msr     sctlr_el1, x18
> +       mrs     x17, sctlr_el1
> +       bic     x17, x17, #SCTLR_ELx_M
> +       msr     sctlr_el1, x17
>         isb
>
>         /* Everybody is enjoying the idmap, so we can rewrite swapper. */
> @@ -281,9 +281,9 @@ skip_pgd:
>         isb
>
>         /* We're done: fire up the MMU again */
> -       mrs     x18, sctlr_el1
> -       orr     x18, x18, #SCTLR_ELx_M
> -       msr     sctlr_el1, x18
> +       mrs     x17, sctlr_el1
> +       orr     x17, x17, #SCTLR_ELx_M
> +       msr     sctlr_el1, x17
>         isb
>
>         /*
> @@ -353,46 +353,47 @@ skip_pte:
>         b.ne    do_pte
>         b       next_pmd
>
> +       .unreq  cpu
> +       .unreq  num_cpus
> +       .unreq  swapper_pa
> +       .unreq  cur_pgdp
> +       .unreq  end_pgdp
> +       .unreq  pgd
> +       .unreq  cur_pudp
> +       .unreq  end_pudp
> +       .unreq  pud
> +       .unreq  cur_pmdp
> +       .unreq  end_pmdp
> +       .unreq  pmd
> +       .unreq  cur_ptep
> +       .unreq  end_ptep
> +       .unreq  pte
> +
>         /* Secondary CPUs end up here */
>  __idmap_kpti_secondary:
>         /* Uninstall swapper before surgery begins */
> -       __idmap_cpu_set_reserved_ttbr1 x18, x17
> +       __idmap_cpu_set_reserved_ttbr1 x16, x17
>
>         /* Increment the flag to let the boot CPU we're ready */
> -1:     ldxr    w18, [flag_ptr]
> -       add     w18, w18, #1
> -       stxr    w17, w18, [flag_ptr]
> +1:     ldxr    w16, [flag_ptr]
> +       add     w16, w16, #1
> +       stxr    w17, w16, [flag_ptr]
>         cbnz    w17, 1b
>
>         /* Wait for the boot CPU to finish messing around with swapper */
>         sevl
>  1:     wfe
> -       ldxr    w18, [flag_ptr]
> -       cbnz    w18, 1b
> +       ldxr    w16, [flag_ptr]
> +       cbnz    w16, 1b
>
>         /* All done, act like nothing happened */
> -       offset_ttbr1 swapper_ttb, x18
> +       offset_ttbr1 swapper_ttb, x16
>         msr     ttbr1_el1, swapper_ttb
>         isb
>         ret
>
> -       .unreq  cpu
> -       .unreq  num_cpus
> -       .unreq  swapper_pa
>         .unreq  swapper_ttb
>         .unreq  flag_ptr
> -       .unreq  cur_pgdp
> -       .unreq  end_pgdp
> -       .unreq  pgd
> -       .unreq  cur_pudp
> -       .unreq  end_pudp
> -       .unreq  pud
> -       .unreq  cur_pmdp
> -       .unreq  end_pmdp
> -       .unreq  pmd
> -       .unreq  cur_ptep
> -       .unreq  end_ptep
> -       .unreq  pte
>  ENDPROC(idmap_kpti_install_ng_mappings)
>         .popsection
>  #endif
> --
> 2.23.0.866.gb869b98d4c-goog
>


-- 
Thanks,
~Nick Desaulniers
