Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C48EB5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfJaRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:18:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42396 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:18:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so4788023pfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+sTelK7MqY9vqwBDqCXPdhr5H6iAxzQESslNr9zDOQ=;
        b=sAYUg0xOdfPTn+R7wNZGdRYPWXJ0IdrBAI1isYFeeATDEGBf/DeF/t/ZC+H3KIMgan
         scNTMCKvOZRUj4tgeq6prlPtSshBDQBCF8nDaSqtG/BB51WfgyTuiGolOBB0Hk97OVfz
         FFZL2/SpGY2l/y2lqqJAw5+jcGGYpBSNf5bJcjlclOWtICbLQxkBTOk8MvT5oITN3pnG
         u+i+4fHB5kQ65haNFrEGLXiuPbYXS6McAD9HBk//2n+3DoaI5W2ndyF8sGSN0/ZerFFI
         3ArURY5RQHp58GR8A9bgodEJWmPTR5znmgAKkcDzIz1L01aQy+rSiF9f4uhSMFQIKuF+
         AFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+sTelK7MqY9vqwBDqCXPdhr5H6iAxzQESslNr9zDOQ=;
        b=SFzEZkp5WnBU/EdM9AaNycvKpIaYyalU6KPrBDcauqFCB6HyqGsvEN2O1JqnwX9H3y
         LEc+uwJqsVWay9M42oQMavwagTrb6p1oKrM7VuMJ22ay28T5PAKUNSw+5c9vuNOV0Mzg
         Ka5vLUmPAA06/ee1xN1rogVAXBDk8m8JxVBms6lMfoYA69icYrzjkjNGrWma7OIfGsbg
         qqe9RfQfhKhQPU1BnSvdrTae/5BfcwrXmGrXqw16PMLylj6nEC7NXZ0P01dvDO+cwIS4
         fMkTPhKHPe74ladnguBJwZmkRuMMKnEBYrg0n3G+upQmg2I1ti8VtihVbISQqheQnO4p
         vJBQ==
X-Gm-Message-State: APjAAAX/fh7nItWOGghob3itnmH6BBSNFM03cZQzvAT2uUYE0t3/fmPJ
        IljJwgEmYA7D3EbMRHrW1cF1+dGpXnd7N634n6Oz8A==
X-Google-Smtp-Source: APXvYqz01CRqRV0ZKEE1VvIGwwKTxW2/uSPOY69zp6ZxsDGHojkbREYW9Biz6FMIeN9w2FNx45LJJlyb3cbOtfyj3Rc=
X-Received: by 2002:aa7:8210:: with SMTP id k16mr7828428pfi.84.1572542325643;
 Thu, 31 Oct 2019 10:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-14-samitolvanen@google.com>
In-Reply-To: <20191031164637.48901-14-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Oct 2019 10:18:34 -0700
Message-ID: <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 9:47 AM <samitolvanen@google.com> wrote:
>
> Don't lose the current task's shadow stack when the CPU is suspended.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/suspend.h | 2 +-
>  arch/arm64/mm/proc.S             | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index 8939c87c4dce..0cde2f473971 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>
> -#define NR_CTX_REGS 12
> +#define NR_CTX_REGS 13
>  #define NR_CALLEE_SAVED_REGS 12
>
>  /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index fdabf40a83c8..0e7c353c9dfd 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -49,6 +49,8 @@
>   * cpu_do_suspend - save CPU registers context
>   *
>   * x0: virtual address of context pointer
> + *
> + * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
>   */
>  ENTRY(cpu_do_suspend)
>         mrs     x2, tpidr_el0
> @@ -73,6 +75,9 @@ alternative_endif
>         stp     x8, x9, [x0, #48]
>         stp     x10, x11, [x0, #64]
>         stp     x12, x13, [x0, #80]
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +       str     x18, [x0, #96]
> +#endif
>         ret
>  ENDPROC(cpu_do_suspend)
>
> @@ -89,6 +94,10 @@ ENTRY(cpu_do_resume)
>         ldp     x9, x10, [x0, #48]
>         ldp     x11, x12, [x0, #64]
>         ldp     x13, x14, [x0, #80]
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +       ldr     x18, [x0, #96]
> +       str     xzr, [x0, #96]

How come we zero out x0+#96, but not for other offsets? Is this str necessary?

> +#endif
>         msr     tpidr_el0, x2
>         msr     tpidrro_el0, x3
>         msr     contextidr_el1, x4
> --
> 2.24.0.rc0.303.g954a862665-goog
>


-- 
Thanks,
~Nick Desaulniers
