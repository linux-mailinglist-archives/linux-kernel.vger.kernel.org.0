Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B690167ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBUNlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:41:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37583 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgBUNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:41:34 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so2398776ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSKO1I3J8u4PED9xsWOVY1usxpEpUW0ahQemP6DdxxI=;
        b=rvJIlx2N7gz+Yjaibh7a778aPGsgTGzHjVgX3Yy/ttvlC68iHyUFzaQjjB7z7oOLrN
         5mI5gIxe77P7+vGisHdLQ/RBAUSlqRTKA3yO23zOzwQboA2TK5v3KtQYx2v8JOwmBhcs
         Ko4ZjNaKDs6JNLJ3IFvp/uTsOH1Fu4CSxxBcOu4kT769SRXrg77mYsbT0ZtnkDmblYGL
         PypqpjkWhQdciLDnPigraUZpezG24Wvc6Rxajjh7XjoCwwu9+V3JzROs/6P8F6+x8Vhr
         oNI4ocq4K+ZU/ayH/C82GNWTBrTfcN8K6KZEgN/WaIAiU0W4t/8OcypD8tQ9+hVqSVvN
         Na3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSKO1I3J8u4PED9xsWOVY1usxpEpUW0ahQemP6DdxxI=;
        b=cXLeIn4ypZY9LE9WjlsTs27guJaog27i1hpFge/UwkJ478RnVFiQ7EgFHy1Q60zKLB
         cDkjOJQSoC1medWylv4U4GQer5YlaK2NfzbiwXSu2ntpbwrVj54jHcDgHSeXoDpQfCet
         s80xQY92apunCDfSD2CzHBpZ8E4OgnIen7Ym7MFQ6XDL6gZPB8JJwWvDNMcZ+XLZ0GRf
         t0moSBuOKU5zS0HzPRl/cIh0YowcaiuIt8QvkLZLE+raqcXrsmVkziKlPFLUA1SNIXEt
         lGGO+2B5cCEuoIrLKdHO4ZbFvmEEcwFW+qb8sJ0VGNX0bKxP3JxpetzMDI7AxC+yWAa8
         SMfw==
X-Gm-Message-State: APjAAAVWidqVJB1U4vRyFQUCyB8JtuPp6uL5TnSkELN/LXT/etDDFhs0
        JtEy1j+BmBp1tweciX5pJYkOilL+u8VJea+U3A==
X-Google-Smtp-Source: APXvYqz/qSrL6QBxpsETxKTK/IocLUif3N5rMDEFXByJx3KTErL5aVyQvlDuKFJHKSScmslacqVP/eU/PJzTiXO8Lxw=
X-Received: by 2002:a6b:7d01:: with SMTP id c1mr31219001ioq.172.1582292494105;
 Fri, 21 Feb 2020 05:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20200221050934.719152-1-brgerst@gmail.com> <20200221050934.719152-3-brgerst@gmail.com>
 <20200221070704.GF3368@light.dominikbrodowski.net>
In-Reply-To: <20200221070704.GF3368@light.dominikbrodowski.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 21 Feb 2020 08:41:23 -0500
Message-ID: <CAMzpN2hL=K9GVg91esHQwm+3LdG00X164k4qFn=HOwSev56DUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86: Move 32-bit compat syscalls to common location
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Fri, Feb 21, 2020 at 12:09:31AM -0500, Brian Gerst wrote:
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -57,6 +57,8 @@ obj-y                       += setup.o x86_init.o i8259.o irqinit.o
> >  obj-$(CONFIG_JUMP_LABEL)     += jump_label.o
> >  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
> >  obj-y                        += probe_roms.o
> > +obj-$(CONFIG_X86_32) += sys_ia32.o
> > +obj-$(CONFIG_IA32_EMULATION) += sys_ia32.o
>
> That doesn't look nicely...

Do you have a better suggestion?  That's similar to how tls.o is
already handled.

--
Brian Gerst
