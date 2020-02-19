Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E470E163BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 05:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSEUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 23:20:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgBSEUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=w1v42JIbxbTQaj+IwxBJakhg/k+j4nNZQJZ/BeGoer0=; b=MTrRstBOnZxCNBLpVqArac2zI8
        ZRetyXVcg2qmFGkwhf9hvQWNslqjh/oAAitsy1+jMz53ikunqAwVlwMaeK7TcENEcJIYL/l0QGCu/
        6ev7PfkAFxCp2mWpw+t5vQUez2oMrhh1H48QMRf0Izn7mrv4NsxRSZydBhENC5MBgcjyB09N+twpr
        ZSZBaVElmIt4rCHc+D97/8V7RvU2aD5qvXjVm2aNwmda0HqwSVTZpRsU/20Z6xVP7fx3nhgJ7BfNZ
        6K4uCdk7Op/UDWyhUlRMFMxfC2kUkb/+ou7Sg4o1Fg+/bUmrNjML9RkRUmykXGkaG7AvFe1ss+rHL
        AI/pl1xA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Gq7-0003eb-PE; Wed, 19 Feb 2020 04:19:59 +0000
Subject: Re: [PATCH v8 01/12] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
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
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com>
 <20200219000817.195049-2-samitolvanen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60ec3a49-7b71-df31-f231-b48ff135b718@infradead.org>
Date:   Tue, 18 Feb 2020 20:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219000817.195049-2-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

a couple of minor tweaks:

On 2/18/20 4:08 PM, Sami Tolvanen wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 98de654b79b3..66b34fd0df54 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -526,6 +526,40 @@ config STACKPROTECTOR_STRONG
>  	  about 20% of all kernel functions, which increases the kernel code
>  	  size by about 2%.
>  
> +config ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	bool
> +	help
> +	  An architecture should select this if it supports Clang's Shadow
> +	  Call Stack, has asm/scs.h, and implements runtime support for shadow
> +	  stack switching.
> +
> +config SHADOW_CALL_STACK
> +	bool "Clang Shadow Call Stack"
> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	help
> +	  This option enables Clang's Shadow Call Stack, which uses a
> +	  shadow stack to protect function return addresses from being
> +	  overwritten by an attacker. More information can be found from

	                                                      found in

> +	  Clang's documentation:
> +
> +	    https://clang.llvm.org/docs/ShadowCallStack.html
> +
> +	  Note that security guarantees in the kernel differ from the ones
> +	  documented for user space. The kernel must store addresses of shadow
> +	  stacks used by other tasks and interrupt handlers in memory, which
> +	  means an attacker capable reading and writing arbitrary memory may

	                    capable of

> +	  be able to locate them and hijack control flow by modifying shadow
> +	  stacks that are not currently in use.
> +
> +config SHADOW_CALL_STACK_VMAP
> +	bool "Use virtually mapped shadow call stacks"
> +	depends on SHADOW_CALL_STACK
> +	help
> +	  Use virtually mapped shadow call stacks. Selecting this option
> +	  provides better stack exhaustion protection, but increases per-thread
> +	  memory consumption as a full page is allocated for each shadow stack.
> +
> +
>  config HAVE_ARCH_WITHIN_STACK_FRAMES
>  	bool
>  	help


thanks.
-- 
~Randy

