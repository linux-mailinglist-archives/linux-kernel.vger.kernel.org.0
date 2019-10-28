Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F46E75E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfJ1QPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:15:13 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39329 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfJ1QPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:15:13 -0400
Received: by mail-vs1-f66.google.com with SMTP id y129so6706904vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAeDGv4mmTdcJjmFC/Y5EqwPqrlxkNMDKmTxGtNGkZY=;
        b=cRlJ8go8Gwg5sHkB7ZS3FAbbXtnMD/tbE+zSlh/I1r1/OC/G4k2GVu3K4ZQIVtSesK
         qWj5vEzyZr/kwqbQ/BTQz27rlFGtYiadnB4BjwV9Aanq9y6mIcNlZgE0TDCUZmzdfMAK
         pYXldXOHSP6bQqOp2tqseN1pN+uwLR+zn/EQU53d0ejxptXvTV4EloD/dPmL0glR+KIS
         nM5OLYggHmVr1GJPpWaCLHPpHehzf5Xxk2CL48eRGzuTedh2dhf7I58eB/9um9Q2ykj/
         fH8V56DN6X6u8meTksQpmCSDkwZZFwfBU/9m+m5LLJy37fUNh5yE52TZE9xDBcF8G6ck
         eKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAeDGv4mmTdcJjmFC/Y5EqwPqrlxkNMDKmTxGtNGkZY=;
        b=BrKuJHtOFwbymcfpjNKur4M1YpdsklOmA7eaBOmTg/0xzKI4Fj1q3gitgZFEI0UeK5
         uPx9kD3XQXc2nWdRFQO+beN5ZmshhA/mlehqXr8RJSSII9b2i4DRCMIQ2shXKj2JgzfN
         aiDsT96UubTOo2TmcxWi6dlTmCQwRbqXblSgLOMULTYtMkwbfIH+OWOWkeQs0zjmEslu
         k92koOA5xIOw1c8sk7Epq3XbOXIQGi70jervQODv0M2PeWa30hJolcNzgDc7fdeaTR/e
         2PXOlR7Qs0nE+2Xr1b8QbtuIazwy1STv8yfKP4PYv57gTjItyLL0+tTsbMYqGPPFHGZ0
         QHow==
X-Gm-Message-State: APjAAAXn2fPSJQOdjXzLCVnAxtAqLQGEjDwABFIO9GFVeOCnOsjg9Yza
        ZdoaYmp6N95VJxz1Yk64XCzTKp2QR+vs75BCqu/w1g==
X-Google-Smtp-Source: APXvYqyErnDNeReEYHXLOlOQvJxZB1LCeRqzFRFTtzuu+yjPbfij2oddf0msvyrSOjimXhfQmIZ/10I+XmQJOMeVmmI=
X-Received: by 2002:a67:ffc7:: with SMTP id w7mr9278938vsq.15.1572279312128;
 Mon, 28 Oct 2019 09:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-6-samitolvanen@google.com>
 <2c13c39acb55df5dbb0d40c806bb1d7dc4bde2ae.camel@perches.com>
 <CABCJKucUR=reCaOh_n8XGSZixmsckNtFXoaq_NOdB+iw-5UxMA@mail.gmail.com> <CANiq72n4o16TB53s6nLLrLCw6v0Brn8GAhKvdzzN7v1tNontCQ@mail.gmail.com>
In-Reply-To: <CANiq72n4o16TB53s6nLLrLCw6v0Brn8GAhKvdzzN7v1tNontCQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 28 Oct 2019 09:15:00 -0700
Message-ID: <CABCJKuexT3-AMiziJdDjKgW2iBW-aBuBJCTRFLK71wvpBkZ5Qg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 8:31 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> We decided to do it like that when I introduced compiler_attributes.h.
>
> Given it is hidden behind a definition, we don't care about which one we use internally; therefore the idea was to avoid clashes as much as possible with other names/definitions/etc.
>
> The syntax is supported in the compilers we care about (for docs on attributes, the best reference is GCC's by the way).

Got it, thank you for explaining. I'll change this to __no_sanitize__
in v3 since Clang seems to be happy with either version.

Sami
