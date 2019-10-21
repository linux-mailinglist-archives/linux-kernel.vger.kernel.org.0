Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C59DE7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfJUJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJUJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:15:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC7C20873;
        Mon, 21 Oct 2019 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571649340;
        bh=u7f4Jzabn9wcp0GNP0aGJ8DQeoDFxKaLNe/XQiZCh3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhQih9usCWZFyrqRYHSlhFjhOzTd6Wskq7PvLRgeauFSlUAkOb9TjhVjGtywqv+TS
         uKESoqrQxNZATz+pnxmw/nrASmiA1G+0A1g5ydaZznLD8x5PPdC3hgLEcGiiZ8fgsI
         gz8KGed6lyCT5vhLpEHmLLOxU3dFyX7GelMJ6vXM=
Date:   Mon, 21 Oct 2019 18:15:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 11/18] kprobes: disable kretprobes with SCS
Message-Id: <20191021181534.4d8edb330e6fb19cd7f7e39f@kernel.org>
In-Reply-To: <20191018130429.5df61f6b@gandalf.local.home>
References: <20191018161033.261971-1-samitolvanen@google.com>
        <20191018161033.261971-12-samitolvanen@google.com>
        <20191018130429.5df61f6b@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 13:04:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Added Masami ]
> 
> On Fri, 18 Oct 2019 09:10:26 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
> 
> > With CONFIG_KRETPROBES, function return addresses are modified to
> > redirect control flow to kretprobe_trampoline. This is incompatible with
> > return address protection.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index a222adda8130..4646e3b34925 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -171,7 +171,7 @@ config ARCH_USE_BUILTIN_BSWAP
> >  
> >  config KRETPROBES
> >  	def_bool y
> > -	depends on KPROBES && HAVE_KRETPROBES
> > +	depends on KPROBES && HAVE_KRETPROBES && ROP_PROTECTION_NONE
> 
> Again, this belongs in the arch code.

+1, below patch (from Steve) looks good to me.

Thank you,

> 
> -- Steve
> 
> >  
> >  config USER_RETURN_NOTIFIER
> >  	bool
> 
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 41a9b4257b72..65557d7e6b5e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -166,7 +166,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> -	select HAVE_KRETPROBES
> +	select HAVE_KRETPROBES if ROP_PROTECTION_NONE
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
>  	select IRQ_DOMAIN


-- 
Masami Hiramatsu <mhiramat@kernel.org>
