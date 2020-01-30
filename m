Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6D14E3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 21:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgA3UGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 15:06:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35936 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:06:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id g15so4332435otp.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzmr0rCxGWcUXC+WtCSYHcwAxAhm1rZi8aLPGy+zipE=;
        b=SCOXsrrQ2ObFfZaBtqJq0DweOFAu4+39JIJl85RMqvCtoyXm+/S4/HPnc7EFZDh+cW
         eiOqMdPlJG/h6uiagKDOPeyA5N4tOc1XMHpHvFWUHC3QzIvVee2baYUUgtGO6PaqW2rF
         uc8apzSUGKYutdy4d9u9G9Y4FMwp1RtcGzS2uPVxukfjbm1JY87CoaNNQNKgykYV/g94
         O4JgzX5WL9e8fhQpF0wWH1y/+rkyfZc+D0FQXmeu8dvq1/gETW8rLoPRAIZ8SDOgv1GZ
         AhbAwRyNDnYT4HdKQWXG195myoT2MfBqYJXKgUjDD3Q91C1ib+5syKysxHx+P8Y6zDNV
         lkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzmr0rCxGWcUXC+WtCSYHcwAxAhm1rZi8aLPGy+zipE=;
        b=gdmq2Je4XPKnJsu7KrP9o/UJ4w+zkwBQYz5kMnRfZQk0X1cqdEdswFzzo2deLg3sG+
         D9GBnv0MavlRuqY5u2SnWobVhYdDln37zrejOCy9z+b/mzL3oP6+7RvUcVXnCSD3aJDV
         YXpbRWWdYISU1Dqp9lrnHORcgpzSseHIwWTTt9ib8yPnkTHIoX0wMsmwegrjMEfHcUDz
         GnHwkA9aDh5JCOh/1VBR9YhLu0kH0NDoGDHVuT/hBHRjAhj8kng+Xj4FzxDBazuyNH+2
         UiWO4oEi7Zp0RAnm6D9VS8kBZELd0Y5jMjcMUvdLL3W+cvZleuaQrOWKz39nngeCRBpZ
         jkqQ==
X-Gm-Message-State: APjAAAW1htVwxAtJt2nhd7k+ou1g/jEtdyJSD8BvRd7UDRUOot2Abm7y
        3ISdpVDRclZ/KmM3oOUXaduwXzKvZoP09ua7JK0=
X-Google-Smtp-Source: APXvYqwDOXbQ7i2RXELeFvJBGmrWClW+wJQ/ItCOwsSrDcfc14orMFQIqzZvtLfp6JIvIHnB8qauCPnoyidEz6YYb3o=
X-Received: by 2002:a05:6830:1e30:: with SMTP id t16mr5021001otr.220.1580414801839;
 Thu, 30 Jan 2020 12:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20200130180048.2901-1-hjl.tools@gmail.com> <202001301139.F8859A4@keescook>
 <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com> <202001301152.DF108B6CC@keescook>
In-Reply-To: <202001301152.DF108B6CC@keescook>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 12:06:06 -0800
Message-ID: <CAMe9rOp1SJvsjSMtDFi4HWKPpu2eePCDiedTPAndUEL5-HSU1w@mail.gmail.com>
Subject: Re: [PATCH] x86: Don't discard .exit.text and .exit.data at link-time
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:58 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 30, 2020 at 11:45:15AM -0800, H.J. Lu wrote:
> > On Thu, Jan 30, 2020 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Jan 30, 2020 at 10:00:48AM -0800, H.J. Lu wrote:
> > > > Since .exit.text and .exit.data sections are discarded at runtime, we
> > > > should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
> > > > .exit.data sections from default discarded sections.
> > >
> > > This is just a correctness fix, yes? The EXIT_TEXT and EXIT_DATA were
> > > already included before the /DISCARD/ section here, so there's no
> > > behavioral change with this patch, correct?
> >
> > That is correct.  I was confused by EXIT_TEXT and EXIT_DATA in generic
> > DISCARDS.   My patch just makes it more explicit.
>
> Okay, so to that end and because this isn't arch-specific, I'd like to
> see this be a behavioral flag, and then the generic DISCARDS macro can
> be adjusted. This lets all architectures implement this without having
> to scatter undef/define lines in each arch.
>
> Something like this:
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..f242d3b4814d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -894,11 +894,17 @@
>   * section definitions so that such archs put those in earlier section
>   * definitions.
>   */
> -#define DISCARDS                                                       \
> -       /DISCARD/ : {                                                   \
> +#ifdef RUNTIME_DISCARD_EXIT
> +#define EXIT_DISCARDS
> +#else
> +#define EXIT_DISCARDS                                                  \
>         EXIT_TEXT                                                       \
>         EXIT_DATA                                                       \
> -       EXIT_CALL                                                       \
> +       EXIT_CALL
> +#endif
> +#define DISCARDS                                                       \
> +       /DISCARD/ : {                                                   \
> +       EXIT_DISCARDS                                                   \
>         *(.discard)                                                     \
>         *(.discard.*)                                                   \
>         *(.modinfo)                                                     \
>
> Then x86 and all other architectures that do this can just use
> #define RUNTIME_DISCARD_EXIT
> at the top (like EMITS_PT_NOTE, etc).
>

It should work.

Thanks.

-- 
H.J.
