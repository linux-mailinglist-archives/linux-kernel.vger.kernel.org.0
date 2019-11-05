Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785FCEF19F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfKEACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 19:02:33 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46205 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfKEACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:02:33 -0500
Received: by mail-ua1-f66.google.com with SMTP id i31so4095892uae.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgpWA2jEqJlvczDoO9RtXFfmusK0XNDziQd8UVfs11k=;
        b=A/SrpqmEvJhiTvT76G/tSSPqak6qEdOAyAD0F4wbDPWu94/+f0jv3efhmZsUUXe6qq
         CybWZB2b/qOXaj/r1Nbyes7WY8VgUjIelgdCzOnhxzWtIMGBD3T63FRfkZ2BE6eRGZIr
         i+vb47qqghQKbHOImu5dkJFEY1uT2BH1eHjRTifgfw5MuC7sgilYydbBLxES9g+KuSIL
         L1WK07dG7pk4sigbooRRP48Y+8xvQtnMOXhJZ3I7J9ghmadqrbCv75YuBU7BR9vJzSEx
         yswAlaOaltIuwCoBGp+vRv4vjVT08L2K0P3ry0DuYv+zs81b3l/ZkUjrhpODm7ydYXfj
         xzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgpWA2jEqJlvczDoO9RtXFfmusK0XNDziQd8UVfs11k=;
        b=cuS+wOu7t7L+G9z8O6dCzwVf89BXY9VO2gY6V8iONTWMsgcIc0u2NrSUUW8ijzDOxQ
         aFnFOvv28bo78z/n0ieEIxXdRY9BTgrVzn+CKu8cNwD7R0GMrVheozFqlRXCrBNAb2Po
         SQcmmBfPmDBlr9mKbQuUox7dWtZgeE+ZS5YTpWUq0egiUJpJ4KMi7/SoPMoHM+DfEHA/
         b14Rgq3E4Y3DyL1ASoU06F1avcoAZhgebxFTavbUjlhLCpjxZeWpT3MyY7v6eHTXIvvf
         YOuI6Dy8ge0KEvK5jngspTPwydZuXYTl+5x67xMNr0JxvIgUc+Af4hDgH3SlehgxNlde
         ot9g==
X-Gm-Message-State: APjAAAViUa4YJeUjcTD18YGEvum22H2Jjm7cFsOYsvNJ/xPX9AMKqTaE
        Jm4/ci2LO2Z2hVSba8BG37MgD1GxEXKryRYvg8KI+g==
X-Google-Smtp-Source: APXvYqxDpgmQ9n/cnDstvJ7riCGFej5xZ9eZp7xC3KSVKRHhU1yTfVmSiCTnVQNCB9cZ2N32DJmU1C4HUXLbveOO274=
X-Received: by 2002:a9f:3772:: with SMTP id a47mr13452102uae.53.1572912151471;
 Mon, 04 Nov 2019 16:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-14-samitolvanen@google.com>
 <02c56a5273f94e9d832182f1b3cb5097@www.loen.fr> <CABCJKucVON6uUMH6hVP7RODqH8u63AP3SgTCBWirrS30yDOmdA@mail.gmail.com>
 <CAKwvOdkDbX4zLChH_DKrnOah1sJjTA-e3uZOXUP6nUs-EaJreg@mail.gmail.com>
In-Reply-To: <CAKwvOdkDbX4zLChH_DKrnOah1sJjTA-e3uZOXUP6nUs-EaJreg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 16:02:16 -0800
Message-ID: <CABCJKueN+Op8xm+L3aSFgCL9BLC8b-WHj3oBYhf1W=OcX2aqCg@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] arm64: preserve x18 when CPU is suspended
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Mon, Nov 4, 2019 at 1:59 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Nov 4, 2019 at 1:38 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Mon, Nov 4, 2019 at 5:20 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >  ENTRY(cpu_do_suspend)
> > > >       mrs     x2, tpidr_el0
> > > > @@ -73,6 +75,9 @@ alternative_endif
> > > >       stp     x8, x9, [x0, #48]
> > > >       stp     x10, x11, [x0, #64]
> > > >       stp     x12, x13, [x0, #80]
> > > > +#ifdef CONFIG_SHADOW_CALL_STACK
> > > > +     str     x18, [x0, #96]
> > > > +#endif
> > >
> > > Do we need the #ifdefery here? We didn't add that to the KVM path,
> > > and I'd feel better having a single behaviour, specially when
> > > NR_CTX_REGS is unconditionally sized to hold 13 regs.
> >
> > I'm fine with dropping the ifdefs here in v5 unless someone objects to this.
>
> Oh, yeah I guess it would be good to be consistent.  Rather than drop
> the ifdefs, would you (Marc) be ok with conditionally setting
> NR_CTX_REGS based on CONFIG_SHADOW_CALL_STACK, and doing so in KVM?
> (So 3 ifdefs, rather than 0)?
>
> Without any conditionals or comments, it's not clear why x18 is being
> saved and restored (unless git blame survives, or a comment is added
> in place of the ifdefs in v6).

True. Clearing the sleep state buffer in cpu_do_resume is also
pointless without CONFIG_SHADOW_CALL_STACK, so if the ifdefs are
removed, some kind of an explanation is needed there.

Sami
