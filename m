Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A6F0665
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfKETzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 14:55:03 -0500
Received: from foss.arm.com ([217.140.110.172]:57992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfKETy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:54:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFB87AD;
        Tue,  5 Nov 2019 11:54:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFF33FBB1;
        Tue,  5 Nov 2019 01:17:25 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:17:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: Re: [PATCH v4 07/17] scs: add support for stack usage debugging
Message-ID: <20191105091723.GC4743@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-8-samitolvanen@google.com>
 <20191104124017.GD45140@lakrids.cambridge.arm.com>
 <CABCJKueoJs7hS7VrVoz6CY_oAjTGcV-W61v9GAdwg+zk0W5ErA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKueoJs7hS7VrVoz6CY_oAjTGcV-W61v9GAdwg+zk0W5ErA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 01:35:28PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 4, 2019 at 4:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > +#ifdef CONFIG_DEBUG_STACK_USAGE
> > > +static inline unsigned long scs_used(struct task_struct *tsk)
> > > +{
> > > +     unsigned long *p = __scs_base(tsk);
> > > +     unsigned long *end = scs_magic(tsk);
> > > +     uintptr_t s = (uintptr_t)p;
> >
> > As previously, please use unsigned long for consistency.
> 
> Ack.
> 
> > > +     while (p < end && *p)
> > > +             p++;
> >
> > I think this is the only place where we legtimately access the shadow
> > call stack directly.
> 
> There's also scs_corrupted, which checks that the end magic is intact.

Ah, true. I missed that.

> > When using SCS and KASAN, are the
> > compiler-generated accesses to the SCS instrumented?
> >
> > If not, it might make sense to make this:
> >
> >         while (p < end && READ_ONCE_NOCKECK(*p))
> >
> > ... and poison the allocation from KASAN's PoV, so that we can find
> > unintentional accesses more easily.
> 
> Sure, that makes sense. I can poison the allocation for the
> non-vmalloc case, I'll just need to refactor scs_set_magic to happen
> before the poisoning.

Sounds good!

Mark.
