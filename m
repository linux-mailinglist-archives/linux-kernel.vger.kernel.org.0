Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F263EB64F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfJaRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:42:31 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34346 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfJaRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:42:30 -0400
Received: by mail-vs1-f68.google.com with SMTP id 127so1725399vsn.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpMt9swBFV/X7pJxY11yJxvoU/jl5TYZqkYEwxVo1zk=;
        b=vyAZGLuQJaP6UmPU/5OivZeIeCWgYHlNvqLsuh7U3yYJqNwBg3VduUAZbxG7Wh6UWt
         vR9hiusZOPdTKmpPzcbCdthcVtfAuVWCA/M8pStelbzfHpRETEdtgYoVIO74pLVcS5Aj
         PDux1c/zr+9UcdqYc/u8vkoVsM0YeYHd9+PtmsdPd6I9nLItOy76IJT1irNZ7ZvnLPOp
         Awz0G6XV3jDbzYKy0ICsWxla4idyK6XrPywrZoHibV+ewA3guRirwYmw7BYI3lR697k/
         6y0spqBrB465HxukOz7+BvekqO5c7tmGdGe9sOFhPb3/TuqkcTuslnkiueSXTjL7kZ2a
         Exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpMt9swBFV/X7pJxY11yJxvoU/jl5TYZqkYEwxVo1zk=;
        b=IT8QDTP1e0YpjKxRed1LY2jCSrvX63CvVZWqhTzDgYqSnVnSFjpkk9rKwT5xB6+HC+
         RT9m6VzwegNqSho1574q1vN6dC9gXyAItLzIqa4OMtgkpcidNlDNkHZPKoXA6VGYx1rt
         JPv9z/oVFDxsJDdaqLpUIZPQADSetGUizEgAaeu7sCKH0tWO9OlE/fjV4Yr2tZEpsYKX
         GUAvcIwvzJx4ENlDZiT9waM+iXfomRaDTFXcQVM/3+27bU+4m9OOC/1j1YDHFOrZopS+
         UxOmuwm0VEopqkkVLVZnGYo4jxm7Cb04efq67TlhKBhGZQecWA9CmoXlzKsU4BNNst60
         HpXw==
X-Gm-Message-State: APjAAAWg2rL4Atr29D+WNwX6faGyEdCDnDkH4GeFI8chbmwy4kUv2nlA
        HmWmRU0v5TI0n0rH5RItYW+I6+hkyPQqagWXUkQy0Q==
X-Google-Smtp-Source: APXvYqw74Dsa5tbwvZVY6ubm3mq6Ol0GpZBf3HyKWvRWHEbC8fAxc8l0X7gBK5dChGcDSWL/yjwxE6D5ZDxmwT29ntI=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr3309159vsp.104.1572543748924;
 Thu, 31 Oct 2019 10:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-14-samitolvanen@google.com>
 <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com>
 <CABCJKudb2_OH5CRFm64rxv-VVnuOrO-ZOrXRHg8hR98Vj+BzVw@mail.gmail.com> <CAKwvOd=dO2QjiRWegjCtnMmVguaJ2YHacJRP3SbVVy9jhx-BWw@mail.gmail.com>
In-Reply-To: <CAKwvOd=dO2QjiRWegjCtnMmVguaJ2YHacJRP3SbVVy9jhx-BWw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 31 Oct 2019 10:42:17 -0700
Message-ID: <CABCJKueVVJNV2MibRkQGPbmpenK_b007kkHOoxfBHf1Wen2ENw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Oct 31, 2019 at 10:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Oct 31, 2019 at 10:27 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Thu, Oct 31, 2019 at 10:18 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > > +#ifdef CONFIG_SHADOW_CALL_STACK
> > > > +       ldr     x18, [x0, #96]
> > > > +       str     xzr, [x0, #96]
> > >
> > > How come we zero out x0+#96, but not for other offsets? Is this str necessary?
> >
> > It clears the shadow stack pointer from the sleep state buffer, which
> > is not strictly speaking necessary, but leaves one fewer place to find
> > it.
>
> That sounds like a good idea.  Consider adding comments or to the
> commit message so that the str doesn't get removed accidentally in the
> future.

Sure, I'll add a comment in the next version.

Sami
