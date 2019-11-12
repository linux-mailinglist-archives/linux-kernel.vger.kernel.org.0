Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED3F957F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKLQXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 11:23:50 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37192 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:23:50 -0500
Received: by mail-yw1-f66.google.com with SMTP id v84so6618881ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q1cQSXXccuUTN1Ss9zMJqdgVizhYDIhjY92yJUaC6I=;
        b=O3piHuow5ELlk8jDb5ZoGxiSQ5RhIR/9v5R0S9tcVkF625c5F2WV4F0L4GHHgmeuQX
         Dm/0PuHlzjay/3EnbTB9HSxsYCV7Y2DFFhRqoItbnp6Ri8b/o1S2+kGiv4RoYFqiuA+w
         daYR3Rdl48LwhuyDQaE6i/GQq4kiXnFbOJAJcFhU69XFgtntpty6+29BfM9yTPc53OGB
         bMWqXc7+OqQFhkXWaewAHJ1GkKeyRvLDYptaf+LgAqGmtiyX97tsjlE5rOStoGLeBbUg
         RDn3Z1j147Et2O3iPQ1h+aK6IR1ESrYQhHSJvQxT59Ay0ToeqJ3vPxV585mKB6RV77zI
         MioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q1cQSXXccuUTN1Ss9zMJqdgVizhYDIhjY92yJUaC6I=;
        b=X5anxE/4bqWyBGPUoCX0St2sT1/8JjDxoyJR1lh1Gvb2YAIsQqVeVP+6EvMb7FsxPq
         9pxw9kcIwn1nZLQWTcqVuPDbn8NM5a+7neIu2mASvDqm9qDWrjQM95a47tdKLGSlQPcx
         6vyu7FMSBhZ+CDZYOUIq18TLCg5sXsT162EwpZr7TSqG1sc4DElJ2EPXbb/5mphze8+f
         1W7nn6i+SjgaF8jpx5MW0QpoDlxZOJ0PtfFlfxeesl3XM/nhGuZnBn5F6a3vFBry25Zo
         +ZNfFX49eRLQ++Nd6CTClqGcaQHhRg8YWiIVIVbamodXxG8glRNmG1nlvOixI4R515Yd
         T2gQ==
X-Gm-Message-State: APjAAAWrTyhMGdYfOTu6hYM7xrDIYuJIPCyBqyNkxAAiiKf1ZD077wFL
        e/rBZRKo4SnuXn04aO67GBTDhkTdq7+jUPcXhHA=
X-Google-Smtp-Source: APXvYqzHQVZzOwk+ZXxtjpuNnuKivOPZNwCB1YjbeiRnIyYtvIT4zVdcLGWSNiSNBM0w0xEsxpb1ewBn8T3ZRtc31rA=
X-Received: by 2002:a81:ad60:: with SMTP id l32mr21343115ywk.388.1573575829291;
 Tue, 12 Nov 2019 08:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20191108004448.5386-1-jcmvbkbc@gmail.com> <20191112094917.fl57dhtennwo2tlz@pathway.suse.cz>
In-Reply-To: <20191112094917.fl57dhtennwo2tlz@pathway.suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 12 Nov 2019 08:23:38 -0800
Message-ID: <CAMo8Bf+Q5-8qBJSkvwa9xoh07eDUDD45suD+uZObuxDJ3uPLWg@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: improve stack dumping
To:     Petr Mladek <pmladek@suse.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:49 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2019-11-07 16:44:48, Max Filippov wrote:
> > Calculate printable stack size and use print_hex_dump instead of
> > opencoding it.
> > Make size of stack dump configurable.
> > Drop extra newline output in show_trace as its output format does not
> > depend on CONFIG_KALLSYMS.
>
> > diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
> > index 39de98e20018..83cc8d12fa0e 100644
> > --- a/arch/xtensa/Kconfig.debug
> > +++ b/arch/xtensa/Kconfig.debug
> > @@ -31,3 +31,10 @@ config S32C1I_SELFTEST
> >         It is easy to make wrong hardware configuration, this test should catch it early.
> >
> >         Say 'N' on stable hardware.
> > +
> > +config PRINT_STACK_DEPTH
> > +     int "Stack depth to print" if DEBUG_KERNEL
> > +     default 64
> > +     help
> > +       This option allows you to set the stack depth that the kernel
> > +       prints in stack traces.
>
> I would split this into separate patch.

Sure, I'll split it out.

> > diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> > index 4a6c495ce9b6..fe090ab1cab8 100644
> > --- a/arch/xtensa/kernel/traps.c
> > +++ b/arch/xtensa/kernel/traps.c
> > @@ -491,32 +491,24 @@ void show_trace(struct task_struct *task, unsigned long *sp)
> >
> >       pr_info("Call Trace:\n");
> >       walk_stackframe(sp, show_trace_cb, NULL);
> > -#ifndef CONFIG_KALLSYMS
> > -     pr_cont("\n");
> > -#endif
> >  }
> >
> > -static int kstack_depth_to_print = 24;
> > +static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
> >
> >  void show_stack(struct task_struct *task, unsigned long *sp)
> >  {
> > -     int i = 0;
> > -     unsigned long *stack;
> > +     size_t len;
> >
> >       if (!sp)
> >               sp = stack_pointer(task);
> > -     stack = sp;
> >
> > -     pr_info("Stack:\n");
> > +     len = min((-(unsigned long)sp) & (THREAD_SIZE - 4),
> > +               kstack_depth_to_print * 4ul);
>
> I would replace the hardcoded 4 with sizeof(void *).

It's not necessarily pointers, more like register-wide entries
on the stack. Ok, I guess I'll give it a name.

> > -     for (i = 0; i < kstack_depth_to_print; i++) {
> > -             if (kstack_end(sp))
> > -                     break;
> > -             pr_cont(" %08lx", *sp++);
> > -             if (i % 8 == 7)
> > -                     pr_cont("\n");
> > -     }
> > -     show_trace(task, stack);
> > +     pr_info("Stack:\n");
> > +     print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE, 32, 4,
> > +                    sp, len, false);
> > +     show_trace(task, sp);
> >  }
>
> The conversion looks fine to me. It is up to you (as a maintainer)
> what you do with the above proposal for two cosmetic changes ;-)
> Either way, feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for the review.

-- Max
