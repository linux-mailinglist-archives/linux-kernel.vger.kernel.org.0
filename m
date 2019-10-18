Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D66DCC8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410595AbfJRRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 13:23:43 -0400
Received: from [217.140.110.172] ([217.140.110.172]:46774 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbfJRRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:23:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C971D1042;
        Fri, 18 Oct 2019 10:23:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 084393F718;
        Fri, 18 Oct 2019 10:23:11 -0700 (PDT)
Date:   Fri, 18 Oct 2019 18:23:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/18] arm64: implement Shadow Call Stack
Message-ID: <20191018172309.GB18838@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-19-samitolvanen@google.com>
 <CAG48ez2Z8=0__eoQ+Ekp=EApawZXR4ec_xd2TVPQExLoyMwtRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2Z8=0__eoQ+Ekp=EApawZXR4ec_xd2TVPQExLoyMwtRQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 07:12:52PM +0200, Jann Horn wrote:
> On Fri, Oct 18, 2019 at 6:16 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > This change implements shadow stack switching, initial SCS set-up,
> > and interrupt shadow stacks for arm64.
> [...]
> > +static inline void scs_save(struct task_struct *tsk)
> > +{
> > +       void *s;
> > +
> > +       asm volatile("mov %0, x18" : "=r" (s));
> > +       task_set_scs(tsk, s);
> > +}
> > +
> > +static inline void scs_load(struct task_struct *tsk)
> > +{
> > +       asm volatile("mov x18, %0" : : "r" (task_scs(tsk)));
> > +       task_set_scs(tsk, NULL);
> > +}
> 
> These things should probably be __always_inline or something like
> that? If the compiler decides not to inline them (e.g. when called
> from scs_thread_switch()), stuff will blow up, right?

I think scs_save() would better live in assembly in cpu_switch_to(),
where we switch the stack and current. It shouldn't matter whether
scs_load() is inlined or not, since the x18 value _should_ be invariant
from the PoV of the task.

We just need to add a TSK_TI_SCS to asm-offsets.c, and then insert a
single LDR at the end:

	mov	sp, x9
	msr	sp_el0, x1
#ifdef CONFIG_SHADOW_CALL_STACK
	ldr	x18, [x1, TSK_TI_SCS]
#endif
	ret

Thanks,
Mark.
