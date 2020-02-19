Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB84164BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBSRZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:25:57 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34576 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:25:56 -0500
Received: by mail-ua1-f68.google.com with SMTP id 1so507299uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOv0TJC8hMcQtpE5VWA57B/HblMF/rVC1OozLuYaMQ4=;
        b=wCVKJi1wPos2aoe3r35P78Z+FSG1LznO9dOxVeXE0xdKHBduJWQSiBquqEYSJJEekN
         yY2L0IZbsj9dlV7LpX0lkR6+uGJXfjz4aR31Qye5jkCHwWzR2UJ7t5Iu7fNK51fnvIq6
         a46RzXx5I6pPrFY8wdnCPQWlVZaXc4VncX69Ar93mXAxIeneFKCcgvUgjkB+8UmaapxX
         C5AxmUjVUKWLDtDoJV5sAMlPxU7Rn2Y66c9nq9icSa1tDUfbTJ8Gnqr5l2RIp6O5lbOG
         1Jdh0a/rKTL7Pv9XiYDRJm7vPCpWne6JU2Zikx7hlaxaGKeNFsDElZMIzoxnGSRJKOMu
         g/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOv0TJC8hMcQtpE5VWA57B/HblMF/rVC1OozLuYaMQ4=;
        b=hPO7W2cFceWuzmhmT0JCTFCZjLuPxCjdME04Q4U44mYIT8BHBhJxEHe6KqoDdQ5uI1
         k1FzvsKT2uSuoYc/+q/CIf5KTc3eNnvL+z59XbUdomk9qHuKp/8acIuhod1ZKalfXaP8
         8M0iuaAw5vTqBzU01nwHxKrEdF7kjEHdvaVVRMz7B5fNh4PHXNariuwAK34LcuyL8Qbc
         u0Z1dN5ja1U4jlHAaEIASzUflaYvKiGB5arrR+30yNCAvV9bcISO5pCJZwfwJ3J0YCvB
         Q9PDcD+RHBQoL6jhOESDa3Q3xRalLuaChfZ8PlViP53cgejHQ2C1m6pYke+jml+bnyGg
         JV7A==
X-Gm-Message-State: APjAAAUMYpHpimSwmxX5nqINfP+kG/xhTdsRf74Ph1/g0DaaBBWZmIGF
        Z/q1z2u254EirVa2q7S3se3mhhsQ1CrDNmo+ace3ug==
X-Google-Smtp-Source: APXvYqwSo6GUilJ/FzOryvH4ZQvh+dOFRIWXmaH6WmAGeZIJvKZZbDWH/ybZ+0IbluDu6CE89M7poWhpL8t0ZLuEzsk=
X-Received: by 2002:ab0:14a2:: with SMTP id d31mr13781595uae.106.1582133154592;
 Wed, 19 Feb 2020 09:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com> <20200219000817.195049-2-samitolvanen@google.com>
 <60ec3a49-7b71-df31-f231-b48ff135b718@infradead.org>
In-Reply-To: <60ec3a49-7b71-df31-f231-b48ff135b718@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 19 Feb 2020 09:25:43 -0800
Message-ID: <CABCJKudVbSMEXWTPw+bzzMuEf_kNsrfYiY53S5ZhWqGB9ynFEA@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] add support for Clang's Shadow Call Stack (SCS)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 8:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Sami,
>
> a couple of minor tweaks:
>
> On 2/18/20 4:08 PM, Sami Tolvanen wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 98de654b79b3..66b34fd0df54 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -526,6 +526,40 @@ config STACKPROTECTOR_STRONG
> >         about 20% of all kernel functions, which increases the kernel code
> >         size by about 2%.
> >
> > +config ARCH_SUPPORTS_SHADOW_CALL_STACK
> > +     bool
> > +     help
> > +       An architecture should select this if it supports Clang's Shadow
> > +       Call Stack, has asm/scs.h, and implements runtime support for shadow
> > +       stack switching.
> > +
> > +config SHADOW_CALL_STACK
> > +     bool "Clang Shadow Call Stack"
> > +     depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > +     help
> > +       This option enables Clang's Shadow Call Stack, which uses a
> > +       shadow stack to protect function return addresses from being
> > +       overwritten by an attacker. More information can be found from
>
>                                                               found in
>
> > +       Clang's documentation:
> > +
> > +         https://clang.llvm.org/docs/ShadowCallStack.html
> > +
> > +       Note that security guarantees in the kernel differ from the ones
> > +       documented for user space. The kernel must store addresses of shadow
> > +       stacks used by other tasks and interrupt handlers in memory, which
> > +       means an attacker capable reading and writing arbitrary memory may
>
>                             capable of

Thanks, Randy! I'll fix these in the next version.

Sami
