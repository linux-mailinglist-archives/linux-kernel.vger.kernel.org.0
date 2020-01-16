Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D636913F0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgAPSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbgAPSYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:24:22 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBED20684;
        Thu, 16 Jan 2020 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579199061;
        bh=i3X7g6e5IWVSb2ig5J3pyxSFVme9xcgEpRgpwwyT7y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lKYCD0WLm3yh5hflSvOoz1YmRKTSBKkclTs5ld6unkAjonC1Y+tIkvepq+xbrn9U
         oaYQxLTjOd8a75YAl2ytpep4WZYPqO61mgWrMmzeAeo2d6nDQ1kTKV6vUkVLcBmJnA
         C4B1lWD83B/LjZENzIt/YiRwplWzrI6kKIAiGuDU=
Date:   Thu, 16 Jan 2020 18:24:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/15] arm64: implement Shadow Call Stack
Message-ID: <20200116182414.GC22420@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com>
 <20191206221351.38241-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206221351.38241-15-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:13:50PM -0800, Sami Tolvanen wrote:
> This change implements shadow stack switching, initial SCS set-up,
> and interrupt shadow stacks for arm64.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/Kconfig                   |  5 ++++
>  arch/arm64/include/asm/scs.h         | 37 +++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h |  3 +++
>  arch/arm64/kernel/Makefile           |  1 +
>  arch/arm64/kernel/asm-offsets.c      |  3 +++
>  arch/arm64/kernel/entry.S            | 31 +++++++++++++++++++--
>  arch/arm64/kernel/head.S             |  9 +++++++
>  arch/arm64/kernel/irq.c              |  2 ++
>  arch/arm64/kernel/process.c          |  2 ++
>  arch/arm64/kernel/scs.c              | 40 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/smp.c              |  4 +++
>  11 files changed, 135 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/scs.h
>  create mode 100644 arch/arm64/kernel/scs.c

[...]

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 583f71abbe98..7aa2d366b2df 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -172,6 +172,10 @@ alternative_cb_end
>  
>  	apply_ssbd 1, x22, x23
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	ldr	x18, [tsk, #TSK_TI_SCS]		// Restore shadow call stack
> +	str	xzr, [tsk, #TSK_TI_SCS]		// Limit visibility of saved SCS
> +#endif
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
>  	get_current_task tsk
> @@ -280,6 +284,12 @@ alternative_else_nop_endif
>  	ct_user_enter
>  	.endif
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	.if	\el == 0
> +	str	x18, [tsk, #TSK_TI_SCS]		// Save shadow call stack
> +	.endif
> +#endif
> +
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  	/*
>  	 * Restore access to TTBR0_EL1. If returning to EL0, no need for SPSR
> @@ -385,6 +395,9 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
>  
>  	.macro	irq_stack_entry
>  	mov	x19, sp			// preserve the original sp
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	mov	x20, x18		// preserve the original shadow stack
> +#endif

Hmm, not sure about corrupting x20 here. Doesn't it hold the PMR value from
kernel_entry?

Rest of the patch looks ok, but I'll do a proper review when it's closer to
being merged as we've got a bunch of other entry changes in the pipeline.

Will
