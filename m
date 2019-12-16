Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97712025D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLPK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLPK1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:27:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDADC206CB;
        Mon, 16 Dec 2019 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576492022;
        bh=kUgzQHruAjaFJFDFjIH83xFuk1KBvTCvlgdm112GOkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKrWqvEV9lXn1r3miOVPSITbPPacHp89DGtXxqTYnHvm6TN+1tSGZFivgdvUIN9o7
         cz4Ste93FLYwlxxzWJ603rI4ubx/PnNMo1xyoMJxTyuDz/t6BuQ3a2OcHHCyeXDOKA
         YAmAJhk4Qtwm29VaZCd1Kh4XTwB/LGGWe8oz9g+k=
Date:   Mon, 16 Dec 2019 10:26:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 1/3] ubsan: Add trap instrumentation option
Message-ID: <20191216102655.GA11082@willie-the-truck>
References: <20191121181519.28637-1-keescook@chromium.org>
 <20191121181519.28637-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121181519.28637-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Thu, Nov 21, 2019 at 10:15:17AM -0800, Kees Cook wrote:
> The Undefined Behavior Sanitizer can operate in two modes: warning
> reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
> __builtin_trap() as the handler. Using lib/ubsan.c means the kernel
> image is about 5% larger (due to all the debugging text and reporting
> structures to capture details about the warning conditions). Using the
> trap mode, the image size changes are much smaller, though at the loss
> of the "warning only" mode.
> 
> In order to give greater flexibility to system builders that want
> minimal changes to image size and are prepared to deal with kernel code
> being aborted and potentially destabilizing the system, this introduces
> CONFIG_UBSAN_TRAP. The resulting image sizes comparison:
> 
>    text    data     bss       dec       hex     filename
> 19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
> 19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
> 19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap
> 
> CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
> CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)
> 
> Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and
> removes the mention of non-existing boot param "ubsan_handle".
> 
> Suggested-by: Elena Petrova <lenaptr@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Kconfig.ubsan      | 22 ++++++++++++++++++----
>  lib/Makefile           |  2 ++
>  scripts/Makefile.ubsan |  9 +++++++--
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 0e04fcb3ab3d..9deb655838b0 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -5,11 +5,25 @@ config ARCH_HAS_UBSAN_SANITIZE_ALL
>  config UBSAN
>  	bool "Undefined behaviour sanity checker"
>  	help
> -	  This option enables undefined behaviour sanity checker
> +	  This option enables the Undefined Behaviour sanity checker.
>  	  Compile-time instrumentation is used to detect various undefined
> -	  behaviours in runtime. Various types of checks may be enabled
> -	  via boot parameter ubsan_handle
> -	  (see: Documentation/dev-tools/ubsan.rst).
> +	  behaviours at runtime. For more details, see:
> +	  Documentation/dev-tools/ubsan.rst
> +
> +config UBSAN_TRAP
> +	bool "On Sanitizer warnings, abort the running kernel code"
> +	depends on UBSAN
> +	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> +	help
> +	  Building kernels with Sanitizer features enabled tends to grow
> +	  the kernel size by around 5%, due to adding all the debugging
> +	  text on failure paths. To avoid this, Sanitizer instrumentation
> +	  can just issue a trap. This reduces the kernel size overhead but
> +	  turns all warnings (including potentially harmless conditions)
> +	  into full exceptions that abort the running kernel code
> +	  (regardless of context, locks held, etc), which may destabilize
> +	  the system. For some system builders this is an acceptable
> +	  trade-off.

Slight nit, but I wonder if it would make sense to move all this under a
'menuconfig UBSAN' entry, so the dependencies can be dropped? Then you could
have all of the suboptions default to on and basically choose which
individual compiler options to disable based on your own preferences.

What do you think?

Will
