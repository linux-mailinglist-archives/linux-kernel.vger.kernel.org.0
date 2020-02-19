Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FFE164372
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 12:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgBSLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 06:34:04 -0500
Received: from foss.arm.com ([217.140.110.172]:46970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgBSLeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:34:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CD631B;
        Wed, 19 Feb 2020 03:34:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AF023F6CF;
        Wed, 19 Feb 2020 03:34:01 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:33:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        james.morse@arm.com, Dave Martin <Dave.Martin@arm.com>,
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
Subject: Re: [PATCH v8 04/12] scs: disable when function graph tracing is
 enabled
Message-ID: <20200219113351.GA14462@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com>
 <20200219000817.195049-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219000817.195049-5-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:08:09PM -0800, Sami Tolvanen wrote:
> The graph tracer hooks returns by modifying frame records on the
> (regular) stack, but with SCS the return address is taken from the
> shadow stack, and the value in the frame record has no effect. As we
> don't currently have a mechanism to determine the corresponding slot
> on the shadow stack (and to pass this through the ftrace
> infrastructure), for now let's disable SCS when the graph tracer is
> enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 66b34fd0df54..4102b8e0eea9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -535,6 +535,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  
>  config SHADOW_CALL_STACK
>  	bool "Clang Shadow Call Stack"
> +	depends on !FUNCTION_GRAPH_TRACER

Fangrui Song has implemented `-fpatchable-function-entry` in LLVM (for
10.x onwards), so we can support this when DYNAMIC_FTRACE_WITH_REGS is
selected.

This can be:

	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER

... and we can update the commit message to something like:

| With SCS the return address is taken from the shadow stack and the
| value in the frame record has no effect. The mcount based graph tracer
| hooks returns by modifying frame records on the (regular) stack, and
| thus is not compatible. The patchable-function-entry graph tracer
| used for DYNAMIC_FTRACE_WITH_REGS modifies the LR before it is saved
| to the shadow stack, and is compatible.
|
| Modifying the mcount based graph tracer to work with SCS would require
| a mechanism to determine the corresponding slot on the shadow stack
| (and to pass this through the ftrace infrastructure), and we expect
| that everyone will eventually move to the patchable-function-entry
| based graph tracer anyway, so for now let's disable SCS when the
| mcount-based graph tracer is enabled.
|
| SCS and patchable-function-entry are both supported from LLVM 10.x.

Assuming you're happy with that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
