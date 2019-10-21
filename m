Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA418DE45A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfJUGPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 02:15:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:15:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so1837640wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyeF1rMaUaHqm01fq+szlG0Q/Q/37dlLkcs/fhKj+JU=;
        b=NLXY6TdHG8Tz04qn7XKMcvdLN/OzoqTYvrB+JSqGhbSGr3rCzaBbRYQdR4no1EY5NL
         Nh9rCiOB9Og08f19wRWClJFDu0/sS1HKtgYeD23z9WavaGd4NE1QQCGW8pgaYugjj5k8
         2ETtuu2xsV6k3V2UW5rEbo/g5/Ro5F6Dfiu6pP5pMD+QaVJORHRrHwe8sIvzyRQ7nyDP
         jeq1vxJ7pypdSO3Ec2jWIw0zBRJyOT5DrUa7sOW2tzW0AmKLRJNb5sdKiVl76Mfb6VFf
         1fntrhgs76bfmwfvZZGpT+tBafmH1AcMK2MVAeBXgJj+RUvSklAClZI5m15AK4a0NKmO
         Z0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyeF1rMaUaHqm01fq+szlG0Q/Q/37dlLkcs/fhKj+JU=;
        b=NYHfNQMz19bIa8p6tK0XsIsJcokEdv+qyTG44qYii7Wprkle/OUHYnIh4CMOj2X+bE
         Y3TEYrWchJJGdBjU1eObizOIgZUSIFjptheYfnUjH9iexB8JV2KP4Nz+pZ47X5WHcJBy
         tr4fjK/9U4xhX2P/TlfsiXG1p1TF0NX9SKPIO0+V6PBPuA+z7PaRLQjNC35zyZ5OXftC
         2f2GUs8QcSSI/66Xu/mhzz6yu4ex2VmamZCepU3lNS4fbRArrttI767MhQuYV3gFS+Iw
         Qwww2j+8O1RGCPcGVcBmA8qs6mumy//pvxkOkoeL0moX6o4RZIf2PNR0b67aLef4KmdU
         d3LA==
X-Gm-Message-State: APjAAAUFxGyZATSbpHcJe7jTum8x6xMOHu2PatyKFdtwSK6ivUImF06Y
        TCCoFWiUoNXfiQSvGFuVgmtnjSHs7TvEAVyQKlcrPw==
X-Google-Smtp-Source: APXvYqwy6S1XLT1tP+FIkDZSJy0h8vZRZeJmoRt5dOcKFryQnLOFQp/4bIpH+FqX5564F137wX49Gmx6/y/bSuaFgAQ=
X-Received: by 2002:a7b:c925:: with SMTP id h5mr1828158wml.61.1571638529717;
 Sun, 20 Oct 2019 23:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-10-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-10-samitolvanen@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Oct 2019 08:15:18 +0200
Message-ID: <CAKv+Gu_bYk8oudqfxmN5GUYSrTNeCPmz19BNnBn_TqATFPK11g@mail.gmail.com>
Subject: Re: [PATCH 09/18] trace: disable function graph tracing with SCS
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 18:11, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_FUNCTION_GRAPH_TRACER, function return addresses are
> modified in ftrace_graph_caller and prepare_ftrace_return to redirect
> control flow to ftrace_return_to_handler. This is incompatible with
> return address protection.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

How difficult would it be to update the return address on the shadow
call stack along with the normal one? Not having to disable
infrastructure that is widely used by the distros would make this a
lot more palatable in the general case (even if it is Clang only at
the moment)


> ---
>  kernel/trace/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e08527f50d2a..b7e5e3bfa0f4 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -161,6 +161,7 @@ config FUNCTION_GRAPH_TRACER
>         depends on HAVE_FUNCTION_GRAPH_TRACER
>         depends on FUNCTION_TRACER
>         depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
> +       depends on ROP_PROTECTION_NONE
>         default y
>         help
>           Enable the kernel to trace a function at both its return
> --
> 2.23.0.866.gb869b98d4c-goog
>
