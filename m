Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A173EBC7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 04:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfKADsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 23:48:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfKADsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:48:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so6062049pfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GhXfR7uwF/t0mkUfEqnIPkdytpbCM5CP4Tc8kyPipqM=;
        b=PO/SPgBcR3vsqL2cCZd3TET4ogLQXaHiXZ2hcfCwBHr9u6N+W0TFF4q5qSB2E1alsu
         zp3gjp/pNjLPKVUHsce3pNebyv6+8gDnrezCEDWd8LT/CaF/mmKSpZfBJkCoE7sLooyt
         A/2tgY3lAuTAU+cgxiWQG106tjcOPBH8rTzI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GhXfR7uwF/t0mkUfEqnIPkdytpbCM5CP4Tc8kyPipqM=;
        b=jKNxAzS6cfQnkh2py5b0O+mPUajLX8Fj6RngTkyjRQXk5WrpBa/Y65vbwlXx1sk3Vf
         DeHOt4RsiL8ntv+A0GYuBJh2MUkwz+YCNI0AMzOMa6EhwVw/yvf+ryUsiANGx9xzr41e
         Xvp/1OOHMGodj8pLjAytgKmSRYGt3+EsZzVHNxAJJgbemWh7M0H6ug2pQLTnRZy+vf30
         H52Sf7QO+Z2j+Z/xD60X91nzd32UERMSfn2VTE/MLpXH0cMj8/p8SXiIpQ05bVrZXRWV
         XDL3eTt2cjyYnWhD6jlnvgqEjCQrzwIXpIjX8FaVkuQZjpFXxF4nwMcWPv7d4kr3L0JM
         lVrQ==
X-Gm-Message-State: APjAAAWfxflr8LHMqDnm1rodfB9FiM7YftnqRsJEysqv9MWmAPeqCruA
        R5vXUde4a+XjFcHrmk4IL4W8CA==
X-Google-Smtp-Source: APXvYqzDBnYONi7/0HCkReVgNKcasH/OGtafBYZqbmUFf2iJDoGJ+0/FCmFdlAnNml4k+yVv0pZLkQ==
X-Received: by 2002:a17:90a:6584:: with SMTP id k4mr12615865pjj.43.1572580097650;
        Thu, 31 Oct 2019 20:48:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y144sm4637001pfb.188.2019.10.31.20.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:48:16 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:48:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/17] arm64: kvm: stop treating register x18 as
 caller save
Message-ID: <201910312048.3B34452@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-4-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:23AM -0700, samitolvanen@google.com wrote:
> In preparation of reserving x18, stop treating it as caller save in
> the KVM guest entry/exit code. Currently, the code assumes there is
> no need to preserve it for the host, given that it would have been
> assumed clobbered anyway by the function call to __guest_enter().
> Instead, preserve its value and restore it upon return.
> 
> Link: https://patchwork.kernel.org/patch/9836891/
> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> [ updated commit message, switched from x18 to x29 for the guest context ]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kvm/hyp/entry.S | 41 +++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index e5cc8d66bf53..c3c2d842c609 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -23,6 +23,7 @@
>  	.pushsection	.hyp.text, "ax"
>  
>  .macro save_callee_saved_regs ctxt
> +	str	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>  	stp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
>  	stp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
>  	stp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
> @@ -32,6 +33,8 @@
>  .endm
>  
>  .macro restore_callee_saved_regs ctxt
> +	// We assume \ctxt is not x18-x28
> +	ldr	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>  	ldp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
>  	ldp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
>  	ldp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
> @@ -48,7 +51,7 @@ ENTRY(__guest_enter)
>  	// x0: vcpu
>  	// x1: host context
>  	// x2-x17: clobbered by macros
> -	// x18: guest context
> +	// x29: guest context
>  
>  	// Store the host regs
>  	save_callee_saved_regs x1
> @@ -67,31 +70,28 @@ alternative_else_nop_endif
>  	ret
>  
>  1:
> -	add	x18, x0, #VCPU_CONTEXT
> +	add	x29, x0, #VCPU_CONTEXT
>  
>  	// Macro ptrauth_switch_to_guest format:
>  	// 	ptrauth_switch_to_guest(guest cxt, tmp1, tmp2, tmp3)
>  	// The below macro to restore guest keys is not implemented in C code
>  	// as it may cause Pointer Authentication key signing mismatch errors
>  	// when this feature is enabled for kernel code.
> -	ptrauth_switch_to_guest x18, x0, x1, x2
> +	ptrauth_switch_to_guest x29, x0, x1, x2
>  
>  	// Restore guest regs x0-x17
> -	ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
> -	ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
> -	ldp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
> -	ldp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
> -	ldp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
> -	ldp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
> -	ldp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
> -	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
> -	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
> -
> -	// Restore guest regs x19-x29, lr
> -	restore_callee_saved_regs x18
> -
> -	// Restore guest reg x18
> -	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
> +	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
> +	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
> +	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
> +	ldp	x6, x7,   [x29, #CPU_XREG_OFFSET(6)]
> +	ldp	x8, x9,   [x29, #CPU_XREG_OFFSET(8)]
> +	ldp	x10, x11, [x29, #CPU_XREG_OFFSET(10)]
> +	ldp	x12, x13, [x29, #CPU_XREG_OFFSET(12)]
> +	ldp	x14, x15, [x29, #CPU_XREG_OFFSET(14)]
> +	ldp	x16, x17, [x29, #CPU_XREG_OFFSET(16)]
> +
> +	// Restore guest regs x18-x29, lr
> +	restore_callee_saved_regs x29
>  
>  	// Do not touch any register after this!
>  	eret
> @@ -114,7 +114,7 @@ ENTRY(__guest_exit)
>  	// Retrieve the guest regs x0-x1 from the stack
>  	ldp	x2, x3, [sp], #16	// x0, x1
>  
> -	// Store the guest regs x0-x1 and x4-x18
> +	// Store the guest regs x0-x1 and x4-x17
>  	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(0)]
>  	stp	x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
>  	stp	x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
> @@ -123,9 +123,8 @@ ENTRY(__guest_exit)
>  	stp	x12, x13, [x1, #CPU_XREG_OFFSET(12)]
>  	stp	x14, x15, [x1, #CPU_XREG_OFFSET(14)]
>  	stp	x16, x17, [x1, #CPU_XREG_OFFSET(16)]
> -	str	x18,      [x1, #CPU_XREG_OFFSET(18)]
>  
> -	// Store the guest regs x19-x29, lr
> +	// Store the guest regs x18-x29, lr
>  	save_callee_saved_regs x1
>  
>  	get_host_ctxt	x2, x3
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
