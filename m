Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B921AE4808
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502213AbfJYKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:02:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404388AbfJYKCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:02:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF82128;
        Fri, 25 Oct 2019 03:02:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6EB3F6C4;
        Fri, 25 Oct 2019 03:02:34 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:02:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     samitolvanen@google.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/17] arm64: kernel: avoid x18 as an arbitrary temp
 register
Message-ID: <20191025100232.GC40270@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com>
 <20191024225132.13410-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024225132.13410-5-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit, but could we make the title a bit more specific (and more
uniform across the series)? e.g.

  arm64: kvm: avoid x18 in __cpu_soft_restart

That makes things a bit nicer when trawling through git logs as the
scope of the patch is clearer.

On Thu, Oct 24, 2019 at 03:51:19PM -0700, samitolvanen@google.com wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
> which will shortly be disallowed. So use x8 instead.
> 
> Link: https://patchwork.kernel.org/patch/9836877/
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Either way:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/kernel/cpu-reset.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index 6ea337d464c4..32c7bf858dd9 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -42,11 +42,11 @@ ENTRY(__cpu_soft_restart)
>  	mov	x0, #HVC_SOFT_RESTART
>  	hvc	#0				// no return
>  
> -1:	mov	x18, x1				// entry
> +1:	mov	x8, x1				// entry
>  	mov	x0, x2				// arg0
>  	mov	x1, x3				// arg1
>  	mov	x2, x4				// arg2
> -	br	x18
> +	br	x8
>  ENDPROC(__cpu_soft_restart)
>  
>  .popsection
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 
