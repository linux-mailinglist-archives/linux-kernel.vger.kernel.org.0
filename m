Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C44EB5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfJaRLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:11:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46368 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJaRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:11:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id q21so2951462plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0X5YfN75r7PDdNJxvGQlnZAXFwdwuMLiQ3l0U13bDg=;
        b=Jy/SacxJhf/Nbsx+JKEbMsxTmi9nTvRx9QrYmlIIdjaRaYWNvdZdUveUzeL7wIBsMZ
         yB8Nz5UMhco8wy0o9k2IWrgIZlOKbDsMBdp3atJjR2eE50+zYjEZBM7mTKuaEMqSUi91
         ueCuaeZ6gpnfO9SKoIhfR/pmAwffakughLyHWB5/OC9EGvGmL4MkTswLiMaKPF11fEWK
         w0yeyTRVppcLDoCs0H8aL/rz2ddY3Gr0oQA89wXCPpwffH+YyILuj3R30CX+hlyoHfZ7
         WFIUgANql15NGTPB5eu58+Vz5mden9xZ/hmIuvN0j6C6tSpO51yEvLSx5eUFDkhOQhtj
         fI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0X5YfN75r7PDdNJxvGQlnZAXFwdwuMLiQ3l0U13bDg=;
        b=YPL6FDp8NDxahcZQpkCpbfL8wsoM1p44Qs73FH/6TlwTLI0181PBsA8qQCSb6hau0l
         BfLyHWhgiA+/TOfT+hXtmJ1dTUhQr8Qx6Yx3d8gXWVq+yCyDtlCZrpm5Wntk6pq/AK9G
         ZM1tqB7bfmdwNLSTa24d8/docGfGTUyuYGaYAQRghekejY36DQVXR4jgd4JuQAsuzm/H
         JD4H/hfBxomi62MiqdRErmkyOdWD4UsmJiQQi6bd835QF0QGQFd9N2TK8fNZdjR7Tevz
         hYBOX4V5JE0nkqJ9JLYMcki3EbtNhMb5dAJqg2LBizZpxupnDZEwxoJ/FASL5HvyOZWv
         yB1A==
X-Gm-Message-State: APjAAAVMMf434gvDkgEqd+a5zv9q98Knk1+awHxnPsToDnawc6pO9tGg
        YM8bHhkv7Bz2/ipK46zm+3jTBqL8d3152pQ3XC3wBw==
X-Google-Smtp-Source: APXvYqyggyEISFvRqnEZ0+/A7Iby9Fs7Q+2KDnPlM3xak8otQQ4zH05zLjAp9ajmSpT131omcbyYgDm2ydz5aTw6/As=
X-Received: by 2002:a17:902:b40f:: with SMTP id x15mr3965837plr.119.1572541887443;
 Thu, 31 Oct 2019 10:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-13-samitolvanen@google.com>
In-Reply-To: <20191031164637.48901-13-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Oct 2019 10:11:16 -0700
Message-ID: <CAKwvOdmBcHuhZZV54-76zY60F0Tvd_0DGCi+5dzFTxk0upOYrQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] arm64: reserve x18 from general allocation with SCS
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 9:47 AM <samitolvanen@google.com> wrote:
>
> Reserve the x18 register from general allocation when SCS is enabled,
> because the compiler uses the register to store the current task's
> shadow stack pointer. Note that all external kernel modules must also be
> compiled with -ffixed-x18 if the kernel has SCS enabled.

Inline/out-of-line assembly will also need to be careful not to
accidentally overwrite the current task's shadow stack pointer.

Without automated checking for that, we'll have to rely on a
"gentlemen's promise" for code reviewers, though we'd likely hit such
a regression with Android+mainline.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2c0238ce0551..ef76101201b2 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
>                                         include/generated/asm-offsets.h))
>  endif
>
> +ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
> +KBUILD_CFLAGS  += -ffixed-x18
> +endif
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
> --
> 2.24.0.rc0.303.g954a862665-goog
>


-- 
Thanks,
~Nick Desaulniers
