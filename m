Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7566FDCC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634479AbfJRRL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 13:11:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37498 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbfJRRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:11:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so4517290vsr.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XATsmiiQ65kT4ODqJ8G67gOZ75F3gzeYi1y9XLQaIlM=;
        b=NFaKn8K/6s2O1InStTL9sLz1AskGb0puzLhWcn2tdgY8ZmCLY7XOJRYveX8vbFZU0f
         AivKBQvkf/pODzLL5A4lcri/koO4kVh6iykeyqn4iKMkTaY1LVSs0gwEl9DJOigy8q8Q
         WPtHpYV0+uIe6amcTjkQLuADzSGPUx4rs/QmPrhO0WC+aS/VPjA8tDxGnOE6xkLGpQLv
         lTimTCE/K9U0RF4C039OIDi0j2iIowkJYeW6TPrBZBYFSBCJ9uXp+uP1gTWL63kz/VIn
         F7pEhz3ucREkKYmQDI91cCQ4B4+VGr1SMl0Byq8KA2sUVL6ZDahv6K/J2fUilePUK8ER
         3UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XATsmiiQ65kT4ODqJ8G67gOZ75F3gzeYi1y9XLQaIlM=;
        b=aBvhGhxhayJKoDW5nVybNwjFCyrrYc6NlX8VK+9k7jXEqETGC2fLnRZ1UWWpTIicXf
         8RuK2Q8sWeAiKkeLPtre13Onrv+lvG2aHXSaXflK4oCn+hko69NYYvZB3Le5klBf44dC
         6Ts8XzhgUS7+S6PYphK0f+2OpGTEMNYF1SKxx/xabzic/hRW0Ki3HMrFA+kVDQK6zXAP
         pG00JBl/nfnylgqeQiLq4iy7gpKiWYuDZiO/K1Z94isFAvS0BV0jlsPTxcOb2JpNo5bF
         farkBAGvAhrkWKpY/DSnu/Qwhvo2YJsIdT+1Fbq6Ne7HtSYz3phPruHCGdCsZKjVJIhI
         WcHw==
X-Gm-Message-State: APjAAAUoZWMoxuOJTv56Wgo90c6J3IKfmJPihlQOODzJzpg6DrC+Gger
        y8ZRoDMNOvOiJwUJP9HrwR/CQj0d2y37ivMWGuwg7Q==
X-Google-Smtp-Source: APXvYqxbFqx52fMmsudugE6XC0yz5SmZysXaFv9YWU7egAQ4sBR35UABj4n5x4ayDTqcJ+9yTIIHMtatlqnJPxGnKEw=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr6025118vsp.104.1571418687239;
 Fri, 18 Oct 2019 10:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
In-Reply-To: <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 10:11:16 -0700
Message-ID: <CABCJKud6+F=yhTo6xTXkHhtLWcSE99K=NcfKW_5E4swS4seKMw@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:08 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index 333a6695a918..9af08391f205 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -42,3 +42,5 @@
> >   * compilers, like ICC.
> >   */
> >  #define barrier() __asm__ __volatile__("" : : : "memory")
> > +
> > +#define __noscs                __attribute__((no_sanitize("shadow-call-stack")))
>
> It looks like this attribute, (and thus a requirement to use this
> feature), didn't exist until Clang 7.0: https://godbolt.org/z/p9u1we
> (as noted above)
>
> I think it's better to put __noscs behind a __has_attribute guard in
> include/linux/compiler_attributes.h.  Otherwise, what will happen when
> Clang 6.0 sees __noscs, for example? (-Wunknown-sanitizers will
> happen).

Good point, I'll fix this in v2. Thanks.

Sami
