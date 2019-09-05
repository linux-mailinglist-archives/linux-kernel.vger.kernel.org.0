Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A44A9D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfIEIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 04:32:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33579 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfIEIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:32:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so96057otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUJk2VTTKC0wN6jcWEhzpQ/cQIMP1HgLM9BleCNY2Mw=;
        b=SuUO2rWqXxXye2UAWa4boZ3MzkhHr1kMRk7hmUEtE/4bTQV09kjQ2Gt0bFfY7jy6Lt
         c/CjUw2y9YZz9PjKOs6ZgbSgAXpr3lfgbrZhxp8su0NVKaaOMe7fOQf9SZi2zc8BBVTM
         vjAL1pS5Xu1dHCg9bPgZfdi6mFDx1NCGTK+hXYe3E1ZoqqhGTi0uwK3Eh55yEdKRDMrB
         +j8i+7EukUgFy0S0lYE0Ohx3Lbh0CpKcUd0dpxx4Ipz7+Vswg0Yj+axiv9QclP7v7FjA
         amXguy+dq916U5xwXOBLDwDqSA0gCjgbyzNwIXY+K6fJFuk0FIByxBUQ0PKhskTuw7/p
         1rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUJk2VTTKC0wN6jcWEhzpQ/cQIMP1HgLM9BleCNY2Mw=;
        b=Fn15J1pFkhX32AzbwFiw+UF06aUZazr75biWREMuYGCOW76AbPIqeIUzPXNuGkepw1
         MXy3lW8HfwAhhK+/nIgQDGkXUHaqkpZNqo3ZdTapRuQi6Q8jOlPRW5hGuVOdez5FCKMG
         pRH+b+n81LWYeb9T0Ajsz67kGyinsdZvjzcS4/vni9NAlnSFbokfEy0bHn9gZN6p4xsI
         IpAXaJ7RHgM4SqaLbdlTwBJXiItBbWOYROrrii90vOunomyEqKA7XZY3oanwJHoGmZyS
         AUD0XtNRrf/IIPzlxqsLiWC4hSYXoUdz9d4ov1eg3l62rYLVOfPWhDkB9r/YzC7Co/Sx
         qSXQ==
X-Gm-Message-State: APjAAAVzANhnlESRUtLgDkcC/E6yswUE0sJTAp7xWlXDJNI2FiMcoIWA
        w4bm9wE8Wr7waWXNYU7UjbzScA8kR0JEStoOlvLRrw==
X-Google-Smtp-Source: APXvYqxC/UAKb7Op1KmsNyTq+/IpTxOo5OnutBYZc/cmcRUJsuSxQX8Ry7sggo5iBT79J9DEW/77PHzMJ2XoCR/yJsY=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr714847oth.232.1567672355504;
 Thu, 05 Sep 2019 01:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180736.29009-1-xypron.glpk@gmx.de> <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com> <20190905082503.GB4320@e113682-lin.lund.arm.com>
In-Reply-To: <20190905082503.GB4320@e113682-lin.lund.arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 5 Sep 2019 09:32:23 +0100
Message-ID: <CAFEAcA-3ne3Z0dwz9C9kJmk36_AdNJRuqgB1jzFJ0WUB2NT_iQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be decoded
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 09:25, Christoffer Dall <christoffer.dall@arm.com> wrote:
>
> On Thu, Sep 05, 2019 at 09:16:54AM +0100, Peter Maydell wrote:
> > This is true, but the problem is that barfing out to userspace
> > makes it harder to debug the guest because it means that
> > the VM is immediately destroyed, whereas AIUI if we
> > inject some kind of exception then (assuming you're set up
> > to do kernel-debug via gdbstub) you can actually examine
> > the offending guest code with a debugger because at least
> > your VM is still around to inspect...
> >
>
> Is it really going to be easier to debug a guest that sees behavior
> which may not be architecturally correct?  For example, seeing a data
> abort on an access to an MMIO region because the guest used a strange
> instruction?

Yeah, a data abort is not ideal. You could UNDEF the insn, which
probably is more likely to result in getting control in the
debugger I suppose.

As for whether it's going to be easier to debug, for the
user who reported this in the first place it certainly was.
(Consider even a simple Linux guest not under a debugger --
if we UNDEF the insn the guest kernel will print a helpful
backtrace so you can tell where the problem is; at the moment
we just print a register dump from the host kernel, which is a
lot less informative.)

> I appreaciate that the current way we handle this is confusing and has
> led many people down a rabbit hole, so we should do better.
>
> Would a better approach not be to return to userspace saying, "we can't
> handle this in the kernel, you decide", without printing the dubious
> kernel error message.

Printing the message in the kernel is the best clue we give
the user at the moment that they've run into this problem;
I would be wary of removing it (even if we decide to also
do something else).

> Then user space could suspend the VM and print a
> lenghty explanation of all the possible problems there could be, or
> re-inject something back into the guest, or whatever, for a particular
> environment.

In theory I guess so. In practice that's not what userspace
currently in the wild does, and injecting an exception from
userspace is a bit awkward (I dunno if kvmtool does it,
QEMU only needs to in really obscure circumstances and
was buggy in how it tried to do it until very recently)...

thanks
-- PMM
