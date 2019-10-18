Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E4DD053
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbfJRUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 16:33:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfJRUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:33:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so3385378plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5h/GhSdlUicoMowUqjyBoWS/+duNMzdyCGodDdcTtc=;
        b=KQhoMvQgSY1S7JFuJAFTC9HRZeQ5mdpO9TvuIKoj0v5SvnSQNuvf8amINPFUPzI8nY
         7ZIM6uhg5mZL7guVvq0mSjr6gr+NtNERf4pjkYKL/atuXVKYh6ehfKZIXGRfpXFMwBUC
         ThYtEebG3W5YCny4jaBcl/Q0epyHh1RHZdFHsBm9kE9ybU6tBqxynDXHqthx+xaibjMa
         95n/a/SX8ULgLGxFbhmjkRP3CjI5ClIpGsJpW9IT2pdvvEpsvlxPiNChvpjefs0l29Vq
         fQGmX4cDpEBIZ/Jt5jFZrqKpbzygKQM8pdWXq7Ks30lBud8WR8HSBUqDptTm7GHM8fiq
         R4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5h/GhSdlUicoMowUqjyBoWS/+duNMzdyCGodDdcTtc=;
        b=FpUsJxCpkn97OqnomDxv5/YlnLzEzdHbSXBrxFukr4bydpj1j/0CJCEPL1fnwK4Hd0
         ToJhqvd9ta9wMpEqYU/C97RU2CXhF8ruR66mYTftb5ZNqfdW3IjRy0PJH/YkgIcWVrFQ
         jmsosgQQHgEDqNmrIVa4+HX/ZNE+luEdRVZpGFnQn5q9ucT8bYk9NOFItQmE5ZSpSanG
         Lbh+DUWocWxJOes8oND06d0AyLp4IAsb+xumUUiDIT4BJ5p5xXlVI6AKwRhb7k7xHus6
         t4wZz2TK2x935fRglO89sEc6UxpTjxV1yRCaQ6g4lHVlnL8eINMl5G75ZX+Hv0qDSfP1
         0QIQ==
X-Gm-Message-State: APjAAAVB2b14CJeiXJ5GxueZxUdRTHG+MHuGOAn/EgG01jJx3u461ziR
        5mTvmCUBV+kNMcrcSCp+1UOV6NdDI6GpH6xEaA4Ayg==
X-Google-Smtp-Source: APXvYqyNa4FKOObSpxuU4QFrkn4kv2RtplqwVoFiBNyGX9dC4x3R93/WFE745QDJwjnJLdnYdKd+pE8O7U/JRiSJhZU=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr11637082plp.179.1571430819228;
 Fri, 18 Oct 2019 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
 <CABCJKud6+F=yhTo6xTXkHhtLWcSE99K=NcfKW_5E4swS4seKMw@mail.gmail.com> <CANiq72=PSzufQkW+2fikdDfZ5ZR1sw2epvxv--mytWZkTZQ9sg@mail.gmail.com>
In-Reply-To: <CANiq72=PSzufQkW+2fikdDfZ5ZR1sw2epvxv--mytWZkTZQ9sg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 13:33:27 -0700
Message-ID: <CAKwvOdkqfbXVQ8dwoT5RVza6bZw3cBQUEGcuRHu0-LhObkg--w@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:33 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 7:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 10:08 AM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > > > index 333a6695a918..9af08391f205 100644
> > > > --- a/include/linux/compiler-clang.h
> > > > +++ b/include/linux/compiler-clang.h
> > > > @@ -42,3 +42,5 @@
> > > >   * compilers, like ICC.
> > > >   */
> > > >  #define barrier() __asm__ __volatile__("" : : : "memory")
> > > > +
> > > > +#define __noscs                __attribute__((no_sanitize("shadow-call-stack")))
> > >
> > > It looks like this attribute, (and thus a requirement to use this
> > > feature), didn't exist until Clang 7.0: https://godbolt.org/z/p9u1we
> > > (as noted above)
> > >
> > > I think it's better to put __noscs behind a __has_attribute guard in
> > > include/linux/compiler_attributes.h.  Otherwise, what will happen when
> > > Clang 6.0 sees __noscs, for example? (-Wunknown-sanitizers will
> > > happen).
> >
> > Good point, I'll fix this in v2. Thanks.
>
> +1, please CC whenever you send it!

Sami pointed out to me off thread that __has_attribute would only
check `no_sanitize`, not `shadow-call-stack`.  So maybe best to keep
the definition here (include/linux/compiler-clang.h), but wrapped in a
`__has_feature` check so that Clang 6.0 doesn't start complaining.
-- 
Thanks,
~Nick Desaulniers
