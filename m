Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB158849
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfF0R05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:26:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42423 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0R05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:26:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so1560727pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b41Zg7AcRgIfnE7desbBE7oLP4gVuMPOYlUuaPb0ZqE=;
        b=l3DnlVM520BOXP9II9KHtBcCrusLLhzRzU30RmNqYIfgYRLwC8xLSVeZejIryxWcq4
         1v8CLD2i8cSeJ7IC20xUUgz3mW+1S7/CKvJmCVkMvoKTqsed6IPnjDAVVbe/mkAcFGKi
         bgJkqe03+foOQ+hVvyGVDtwh7I3RBzuR9Zzlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b41Zg7AcRgIfnE7desbBE7oLP4gVuMPOYlUuaPb0ZqE=;
        b=c3LwvGY333DjiRhdU78BgOc+nVVImcAoW+Q3UVXxKeiefPIYOMlyL28a+Lbp69Z3os
         oKwCnuIqDxL0OcIX/bL9aSvPCNImC2Tj7kAhabiRdIj3kVwdIbMZU5r2ZKP4dTg3XzUK
         OXNaAQvSMds+iIJ7T4iVRgo8aZMM0/r0x1OVRSFZSzaVpR8rc9z/J+gMwaKfutxmgOhC
         lB3nIK3Cx+FIFqeBelDScyW1WaBTr3BExt7ZJ5cCGR9YQ+ffC3bGbyh7UqYKEBFY1fHW
         1YNRv8431t1hU7fkvFQ6Mbr8yY2TsNPcOeqibXzbKOvISOOF6xrm80sOLo/72dW9Ei6h
         HnmQ==
X-Gm-Message-State: APjAAAUWW93dquUeC/m+jsT8niDk6X6FF9zVsO2aygmHJ51K3nGX6xoz
        TmfM3p528/AFIylbw8DIsuUQlA==
X-Google-Smtp-Source: APXvYqwl8QAvtmd2cJEyfj/4gdo7V2tfQp4unY368+VCH1Zsy6Rf6jX7aQ5BXZbzSscNQiCM5onnjg==
X-Received: by 2002:a17:90a:350c:: with SMTP id q12mr7442599pjb.46.1561656416693;
        Thu, 27 Jun 2019 10:26:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a21sm4985951pgd.45.2019.06.27.10.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:26:55 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:26:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/8] x86/vsyscall: Add a new vsyscall=xonly mode
Message-ID: <201906271026.383D4F5@keescook>
References: <cover.1561610354.git.luto@kernel.org>
 <d17655777c21bc09a7af1bbcf74e6f2b69a51152.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17655777c21bc09a7af1bbcf74e6f2b69a51152.1561610354.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:45:03PM -0700, Andy Lutomirski wrote:
> With vsyscall emulation on, we still expose a readable vsyscall page
> that contains syscall instructions that validly implement the
> vsyscalls.  We need this because certain dynamic binary
> instrumentation tools attempt to read the call targets of call
> instructions in the instrumented code.  If the instrumented code
> uses vsyscalls, then the vsyscal page needs to contain readable
> code.
> 
> Unfortunately, leaving readable memory at a deterministic address
> can be used to help various ASLR bypasses, so we gain some hardening
> value if we disallow vsyscall reads.
> 
> Given how rarely the vsyscall page needs to be readable, add a
> mechanism to make the vsyscall page be execute only.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../admin-guide/kernel-parameters.txt         |  7 +++-
>  arch/x86/Kconfig                              | 33 ++++++++++++++-----
>  arch/x86/entry/vsyscall/vsyscall_64.c         | 16 +++++++--
>  3 files changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0082d1e56999..be8c3a680afa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5100,7 +5100,12 @@
>  			targets for exploits that can control RIP.
>  
>  			emulate     [default] Vsyscalls turn into traps and are
> -			            emulated reasonably safely.
> +			            emulated reasonably safely.  The vsyscall
> +				    page is readable.
> +
> +			xonly       Vsyscalls turn into traps and are
> +			            emulated reasonably safely.  The vsyscall
> +				    page is not readable.
>  
>  			none        Vsyscalls don't work at all.  This makes
>  			            them quite hard to use for exploits but
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2bbbd4d1ba31..0182d2c67590 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2293,23 +2293,38 @@ choice
>  	  it can be used to assist security vulnerability exploitation.
>  
>  	  This setting can be changed at boot time via the kernel command
> -	  line parameter vsyscall=[emulate|none].
> +	  line parameter vsyscall=[emulate|xonly|none].
>  
>  	  On a system with recent enough glibc (2.14 or newer) and no
>  	  static binaries, you can say None without a performance penalty
>  	  to improve security.
>  
> -	  If unsure, select "Emulate".
> +	  If unsure, select "Emulate execution only".
>  
>  	config LEGACY_VSYSCALL_EMULATE
> -		bool "Emulate"
> +		bool "Full emulation"
>  		help
> -		  The kernel traps and emulates calls into the fixed
> -		  vsyscall address mapping. This makes the mapping
> -		  non-executable, but it still contains known contents,
> -		  which could be used in certain rare security vulnerability
> -		  exploits. This configuration is recommended when userspace
> -		  still uses the vsyscall area.
> +		  The kernel traps and emulates calls into the fixed vsyscall
> +		  address mapping. This makes the mapping non-executable, but
> +		  it still contains readable known contents, which could be
> +		  used in certain rare security vulnerability exploits. This
> +		  configuration is recommended when using legacy userspace
> +		  that still uses vsyscalls along with legacy binary
> +		  instrumentation tools that require code to be readable.
> +
> +		  An example of this type of legacy userspace is running
> +		  Pin on an old binary that still uses vsyscalls.
> +
> +	config LEGACY_VSYSCALL_XONLY
> +		bool "Emulate execution only"
> +		help
> +		  The kernel traps and emulates calls into the fixed vsyscall
> +		  address mapping and does not allow reads.  This
> +		  configuration is recommended when userspace might use the
> +		  legacy vsyscall area but support for legacy binary
> +		  instrumentation of legacy code is not needed.  It mitigates
> +		  certain uses of the vsyscall area as an ASLR-bypassing
> +		  buffer.
>  
>  	config LEGACY_VSYSCALL_NONE
>  		bool "None"
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index d9d81ad7a400..fedd7628f3a6 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -42,9 +42,11 @@
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
>  
> -static enum { EMULATE, NONE } vsyscall_mode =
> +static enum { EMULATE, XONLY, NONE } vsyscall_mode =
>  #ifdef CONFIG_LEGACY_VSYSCALL_NONE
>  	NONE;
> +#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
> +	XONLY;
>  #else
>  	EMULATE;
>  #endif
> @@ -54,6 +56,8 @@ static int __init vsyscall_setup(char *str)
>  	if (str) {
>  		if (!strcmp("emulate", str))
>  			vsyscall_mode = EMULATE;
> +		else if (!strcmp("xonly", str))
> +			vsyscall_mode = XONLY;
>  		else if (!strcmp("none", str))
>  			vsyscall_mode = NONE;
>  		else
> @@ -357,12 +361,20 @@ void __init map_vsyscall(void)
>  	extern char __vsyscall_page;
>  	unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
>  
> -	if (vsyscall_mode != NONE) {
> +	/*
> +	 * For full emulation, the page needs to exist for real.  In
> +	 * execute-only mode, there is no PTE at all backing the vsyscall
> +	 * page.
> +	 */
> +	if (vsyscall_mode == EMULATE) {
>  		__set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
>  			     PAGE_KERNEL_VVAR);
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>  	}
>  
> +	if (vsyscall_mode == XONLY)
> +		gate_vma.vm_flags = VM_EXEC;
> +
>  	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
>  		     (unsigned long)VSYSCALL_ADDR);
>  }
> -- 
> 2.21.0
> 

-- 
Kees Cook
