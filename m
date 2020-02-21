Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22DE16892B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBUVXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:23:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38389 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBUVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:23:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id p23so4080121edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0UtmZPeT56XfWRuDUA7oBTkz9ZjiDJ1oBCH4qpkMQ0=;
        b=c9HY3eS5WKljqU/p0tZYMuxAzdtRfJ6HN3lf2Wth3vfg4DT06ipl3CpoYJRP77uD7r
         ZrtMXzZHQgfyam/bMlnj2W60j8GclkUygHSQjUADqT946pzosXTD1dJh82qL+LTOw1Fi
         dP6IFmFaje/wVpl/eCfKFYB08Chn0tSAtcWvx6jDL9j5NW5hDR+VjWNtm2Lg5dWPRQVg
         h8G89ykiTz67ZWe+fGESVdqaOOvVJSDQagR267ej413Uo3+0Qs81VhF8M1kKr5mZnxQd
         577ztcTKhVNda4GZSR2F0mssWbccIPQ7xR94If4FnjrwlB6c76NDY0FWu700lk566xAb
         kQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0UtmZPeT56XfWRuDUA7oBTkz9ZjiDJ1oBCH4qpkMQ0=;
        b=fW2SSHsph0qxzE/m1APyBGeIYpGFikpxzjcUrFvgDrDWFTCrzhMOnf7HT7r7VctEYU
         D8lJP6wC6N0V+wKr3xRjwSkhi/Xuf3Bv/+9u+HNs4Q9Cql0z8C/SXr8pIc7pBW9gwzQ1
         LJW3IwqkvnMnKyboUmv4ws5vua6elv/ggOy0IsaqLlxiqwz267HBMcKvHF+HDFY94XoE
         FXPrJNR41ij+zN3ZWdwYrJQHSRuhsEAknLj7HvY/UlJRB2ElWWivSZmEP2K/Ofr++nUB
         //K7KG+7jdiZ6c9RaKGnw3dQIvs0e+TJJe3lohpHbEiR46FGTtf65VJfCVNvK0wfFhH1
         4UgQ==
X-Gm-Message-State: APjAAAXaGC5V2Vkn3ssYiBhfbNJvpg/DcUP+CjSflD3/muKQ23WPprVW
        wlB7ocUemj+0WXYsK2k+0uGdvh24VecTBjT2BRw24A==
X-Google-Smtp-Source: APXvYqwRQIBcr5CH9sUElhkH/yr2SEu6/zsQCZ+7UgJu6FAczAr934WWIgw2zSXEAOYZfchsJ1JQoY8Ls4xd3TR7g3s=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr35541410eds.12.1582320219090;
 Fri, 21 Feb 2020 13:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20200218005659.91318-1-lrizzo@google.com> <20200218165529.39e761c4be828285cc060279@kernel.org>
 <CAMOZA0L14CjA97UHj7V1tPuOtesrUykYPj3_vgbF3JQWS3bcaw@mail.gmail.com> <20200218205025.4047cf0506f56b18f9a989c4@kernel.org>
In-Reply-To: <20200218205025.4047cf0506f56b18f9a989c4@kernel.org>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Fri, 21 Feb 2020 13:23:28 -0800
Message-ID: <CAMOZA0LyOUsByh02ue=NH0g=UCtLVC9EX4OGx+9MbWeLOHm34A@mail.gmail.com>
Subject: Re: [PATCH v3] kretprobe: percpu support
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:50 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 18 Feb 2020 01:39:40 -0800
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> > On Mon, Feb 17, 2020 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi Luigi,
> > >
> > > On Mon, 17 Feb 2020 16:56:59 -0800
> > > Luigi Rizzo <lrizzo@google.com> wrote:
> > >
> > > > kretprobe uses a list protected by a single lock to allocate a
> > > > kretprobe_instance in pre_handler_kretprobe(). This works poorly with
> > > > concurrent calls.
> > >
> > > Yes, there are several potential performance issue and the recycle
> > > instance is one of them. However, I think this spinlock is not so racy,
> > > but noisy (especially on many core machine) right?
> >
> > correct, it is especially painful on 2+ sockets and many-core systems
> > when attaching kretprobes on otherwise uncontended paths.
> >
> > >
> > > Racy lock is the kretprobe_hash_lock(), I would like to replace it
> > > with ftrace's per-task shadow stack. But that will be available
> > > only if CONFIG_FUNCTION_GRAPH_TRACER=y (and instance has no own
> > > payload).
> > >
> > > > This patch offers a simplified fix: the percpu_instance flag indicates
> > > > that we allocate one instance per CPU, and the allocation is contention
> > > > free, but we allow only have one pending entry per CPU (this could be
> > > > extended to a small constant number without much trouble).
> > >
> > > OK, the percpu instance idea is good to me, and I think it should be
> > > default option. Unless user specifies the number of instances, it should
> > > choose percpu instance by default.
> >
> > That was my initial implementation, which would not even need the
> > percpu_instance
> > flag in struct kretprobe. However, I felt that changing the default
> > would have subtle
> > side effects (e.g., only one outstanding call per CPU) so I thought it
> > would be better
> > to leave the default unchanged and make the flag explicit.
> >
> > > Moreover, this makes things a bit complicated, can you add per-cpu
> > > instance array? If it is there, we can remove the old recycle rp insn
> > > code.
> >
> > Can you clarify what you mean by "per-cpu instance array" ?
> > Do you mean allowing multiple outstanding entries per cpu?
>
> Yes, either allocating it on percpu area or allocating arraies
> on percpu pointer is OK. e.g.
>
>         instance_size = sizeof(*rp->pcpu) + rp->data_size;
>         rp->pcpu = __alloc_percpu(instance_size * array_size,
>                                   __alignof__(*rp->pcpu));
>
> And we will search free ri on the percpu array by checking ri->rp == NULL.

I have posted a v4 patch with the refactoring you suggested, but
still defaulting to non percpu allocation, and only one entry per cpu.
The former to avoid potential regressions, the latter because I worry
that the search in the array may incur several cache misses especially
if the traced function is allowed to block or the caller can migrate.
(Maybe I am over cautious, but I want to measure that cost first;
once that is clear perhaps we can move forward with another patch
that defaults to percpu and removes the reclaim code).

cheers
luigi
