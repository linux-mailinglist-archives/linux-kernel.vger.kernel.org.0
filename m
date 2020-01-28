Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9214C326
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 23:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgA1WuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 17:50:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36828 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1WuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:50:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so7788095pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHEMtu7LgfkFmyO7oGGN1Lq9IQ3mukp2v1f/r5o0L0s=;
        b=T1hFsGEO0/ylAav9HFUtgqeRhLCk+8mN4axKzOMQw6onWhdziR92MjVxq99AAlFqvU
         kku1dM+53W1OlgPVvAdZpJUQQFRFZXSDYoFSRxG+GgXnjw7uLYw9w3Uwi+5GnyvWh7Zr
         AS8uPHr3/+DROwe5Czh3qwOMmnX6Zh6aNF314=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHEMtu7LgfkFmyO7oGGN1Lq9IQ3mukp2v1f/r5o0L0s=;
        b=ncI5bsomA9TmXzkJbTvOx+DImXrMl0oc3SQHebPyYw0bnyIBvAzTVbBes+irpm+ejc
         kUZs9wQ7uJ1lxY+1McBWShDI9QRcKNYr4LPdiqrVO8SPvCIJrUk0/FgB+FWjIKlu/l9X
         b4+mkmiy/pPSrgSfcgLJVI7YNI8eV9SC0urqv5mr2HUCXUsk4Pwngx8KM7AmkMUZ5Fts
         aVOXdkksMp7LnHObBoqyTC0+qlZRe8o9kYGaaIhIH9LwzVUUlON/h7G3I4MDvfl99ym8
         HkmiLCHU+1EojjSIiUwYIUjQczhmJGnCdPwcX2+i1jpWzNOiAUvlKMZZ5ac1c8y/aHx9
         uAbQ==
X-Gm-Message-State: APjAAAWvefbQMDMd/qVfZRNygiO7Bpm392hkL/XRGWFwWkzsxHvlwShv
        ugLikM6gZAYQyrDHpqTbQquMmw==
X-Google-Smtp-Source: APXvYqx9wzHAeZmTEPl0AGnf9TAiBUX0F1ZcpzaNR4O6MA9xWbzMW0w2pC5Y4TVfo8+2jVMqh5iIHw==
X-Received: by 2002:a65:5786:: with SMTP id b6mr27614437pgr.316.1580251802779;
        Tue, 28 Jan 2020 14:50:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s23sm2178658pjq.17.2020.01.28.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 14:50:02 -0800 (PST)
Date:   Tue, 28 Jan 2020 14:50:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/11] scs: disable when function graph tracing is
 enabled
Message-ID: <202001281449.FB1671805E@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128184934.77625-5-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:49:27AM -0800, Sami Tolvanen wrote:
> The graph tracer hooks returns by modifying frame records on the
> (regular) stack, but with SCS the return address is taken from the
> shadow stack, and the value in the frame record has no effect. As we
> don't currently have a mechanism to determine the corresponding slot
> on the shadow stack (and to pass this through the ftrace
> infrastructure), for now let's disable SCS when the graph tracer is
> enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1b16aa9a3fe5..0d746373c52e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -530,6 +530,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  
>  config SHADOW_CALL_STACK
>  	bool "Clang Shadow Call Stack"
> +	depends on !FUNCTION_GRAPH_TRACER
>  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	help
>  	  This option enables Clang's Shadow Call Stack, which uses a
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

-- 
Kees Cook
