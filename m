Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3320174134
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB1UvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 15:51:22 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35051 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1UvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:51:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id u26so2845717vsg.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SitQuWaYJYljvcCrYj4fkHHkPc4o0vcrOMkYmOvH+dg=;
        b=WsM/fb6y5CGtFjZacOBZZYlUzkSwNVN+lgzwRpeO7kE0e/83uZ2+K3ZTNKkv0Q8dSI
         a+Cugxv8TY/rUcQjCqy8r8gHFh1GeAOUAEhTpt/68gti4/raIjNU9nV6YsuYTnE1pQg4
         BjR09FkgavjN4CagxM8NdJbh77wJU1R5zT8YKoCpeYzhTXcpH67QL/XNAng5pvrnCqzW
         IlpTQwrR9LWfOP5fofMezihxVEIAGD6q+96J1skrj6gfpRAHBApVND96QkQOppRbBXCs
         AIgan+ocDu8aj28mHw/t5DZ9jenFbfBChKOdPnSbMKWlknHeyCJ9J8SDvVmB2tsmDd2F
         ZnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SitQuWaYJYljvcCrYj4fkHHkPc4o0vcrOMkYmOvH+dg=;
        b=o9pUW2Tr4b1b4bPCz0kl/oOBavj6vWWUqKBrjkjNQOnJTFz1Dj4HX/bHa5oyu/QRbN
         hAgkqHxl6vVxL2+sFHZGIESTP1nPE0Zl30LAzilJf39jnwSZNWb6Xm+fZ17AEuevK4s4
         FhPBen/qZOfD9ZNOddrW9YH2f/s2HB+4R+TahHw4neEfaayBpD9b9U2LOA/EoCIhlmmU
         dlIRREopjBJBW1fWilZHLOEHcHQyqMLmN+Os6/TYivJDXpbY9Z6b6ElFbPjnUTkDxosu
         o/OBcYML/TTYVMO6JtQ5r3SaLPTuTQFO1z/qXZNZlv5yG8IGttJyvgXOV8QXu4LWyTP5
         LYEQ==
X-Gm-Message-State: ANhLgQ1ngeqwQFtdZVKap/o7G7b85pMyn3Mri9hhnI6G14XXRO/xzhyE
        JrsQe5l5ZlBi3Ojf5h3EnzyK910kwDe3HWwY/PfqRQ==
X-Google-Smtp-Source: ADFU+vvQxOaGGrHRtQqNZNl73QRM6vi1YBVrsU8i6+lpeaELnBsJ5FIiG7kODI7N1KIXUtRDUGM7/idkISnluUIb4h8=
X-Received: by 2002:a67:fb8d:: with SMTP id n13mr309624vsr.15.1582923080404;
 Fri, 28 Feb 2020 12:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200225173933.74818-1-samitolvanen@google.com> <20200225173933.74818-11-samitolvanen@google.com>
 <56b82a54-044a-75ec-64e5-6ba25b19571f@arm.com>
In-Reply-To: <56b82a54-044a-75ec-64e5-6ba25b19571f@arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 28 Feb 2020 12:51:09 -0800
Message-ID: <CABCJKufFp=7+18-XSY3U3745FifmRNXqBWk9TeZxgZ-aWmhfHQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/12] arm64: implement Shadow Call Stack
To:     James Morse <james.morse@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Fri, Feb 28, 2020 at 8:31 AM James Morse <james.morse@arm.com> wrote:
> > +#ifndef __ASSEMBLY__
>
> As the whole file is guarded by this, why do you need to include it in assembly files at all?

True, the include in head.S is not needed. I'll remove it in the next version.

> > +static inline void scs_overflow_check(struct task_struct *tsk)
> > +{
> > +     if (unlikely(scs_corrupted(tsk)))
> > +             panic("corrupted shadow stack detected inside scheduler\n");
>
> Could this ever catch anything with CONFIG_SHADOW_CALL_STACK_VMAP?
> Wouldn't we have hit the vmalloc guard page at the point of overflow?

With CONFIG_SHADOW_CALL_STACK_VMAP, even though we allocate a full
page, SCS_SIZE is still 1k, so we should catch overflows here well
before we hit the guard page.

> It would be nice to have a per-cpu stack that we switch to when on the overflow stack.

It shouldn't be a problem to add an overflow shadow stack if you think
one is needed.

> I can't work out why this needs to be before before idle_task_exit()...
> It needs to run before init_idle(), which calls scs_task_reset(), but all that is on the
> cpu_up() path. (if it is to pair those up, any reason core code can't do both?)

At this point, the idle task's shadow stack pointer is only stored in
x18, so we need to save it again to thread_info before the CPU shuts
down, or we'll lose the pointer.

Sami
