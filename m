Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF53BEBCA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 05:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfKAEAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 00:00:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfKAEAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:00:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id x28so2873875pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7vrO+MQB63nPz6FPwTRdUgznbxQobdODcdehGRotvI=;
        b=SoIAx/f+o5ObJpWgtzqlvIdoi9BrVBtR0sORn7UXLhxKD40+Hq5g8o71ljOsCw58Xu
         nV5Xy/0YwVtNd7g4N0HQfZNFqvK0+sr9AAyTxnNs4Qwhx3+vEE4Ynyv8Aid4jjjCxSzD
         BwrcVTfNY0xZuV8VaybEOQY3+plZAuUInWL9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7vrO+MQB63nPz6FPwTRdUgznbxQobdODcdehGRotvI=;
        b=YVzkCu8q4hHtAXr5TLOnw1srSrksswGpZ9iSw/ZPSDYUFePbb4LpgpLQqivvQzDGM9
         ruGs/o83OaicLy0uBofoAVoV4E1886rBFsUaVpM0JdHABnVkWbfFoM5LCeGS1JN18DXu
         d9qiP7Us9I5VUhP+wicbfN5hg0NABrEBgAtNkaCv0g+PRmMet6O3B9w8YvWaHB3pUVQn
         2Xa3TXgOuwX0a9iiLLaGzQ9LFGPjZBUdTNuPxRpW68PNTigBeorGkxFjSbfx/qJGa4CW
         5NNsourNtPucedqtCp72ab1D85v+Aok00FgT0vvF2lfzFVxA2OVzjyMln53YA6Uo+l/D
         TdTg==
X-Gm-Message-State: APjAAAW8vBrL5cxbk0t3JUa5AHcX65SlYa+VQpcFyOmTgvN5YcYJ1CkK
        2wb1Tew4IoZBV1ES4862gtvJpw==
X-Google-Smtp-Source: APXvYqxYKGSK6I8b7hoUIAqJTB3Ku0XRihpPu4nBcAxKCNBJscoqFmYbPUJv9aMkupfl7+/RJ59IiA==
X-Received: by 2002:a63:611:: with SMTP id 17mr10933319pgg.191.1572580800014;
        Thu, 31 Oct 2019 21:00:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v19sm833472pgn.84.2019.10.31.20.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:59:59 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:59:58 -0700
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
Subject: Re: [PATCH v3 12/17] arm64: reserve x18 from general allocation with
 SCS
Message-ID: <201910312059.C43A11D@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-13-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:32AM -0700, samitolvanen@google.com wrote:
> Reserve the x18 register from general allocation when SCS is enabled,
> because the compiler uses the register to store the current task's
> shadow stack pointer. Note that all external kernel modules must also be
> compiled with -ffixed-x18 if the kernel has SCS enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2c0238ce0551..ef76101201b2 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
>  					include/generated/asm-offsets.h))
>  endif
>  
> +ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
> +KBUILD_CFLAGS	+= -ffixed-x18
> +endif
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
