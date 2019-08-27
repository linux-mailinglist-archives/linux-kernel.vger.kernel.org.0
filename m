Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF39F6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 01:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH0X3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 19:29:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36680 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfH0X3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:29:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so324421pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yds4L+UJYT1pT6WHSiYBmKMudGdkG8XzlFIeiqJMzEk=;
        b=r6sx7bI3PgBNa6FxFEHKlJPtuDvELAH8de2/OFdvTmIpUrnl9yE6tEMdNBY8AEJdjS
         0PGJ5YGLrTQacEXgvnw6l4fL0Qn126PuDsaYpKEUT8b8on/A5SgC9IJVbqJaruCBkRvz
         VK0HTDQzQ4+spB3DDUcgPRMe4WRJvpTPfgehp37PP+h7Or9MQKrMC0AaltBjUoZgGQ8p
         Hk086oQ6ISZVCHizoiDx+AqYtPgz55NfVEmYa5+rFtlp2LLEdORWbUPM+If09QHLGrDe
         bSfkfKpCRerqWg7NIM3PYqXUyNgdVTmQOrQMvrKEn7/0OaPOjnEHs5o2C5yya3HxxLQg
         DA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yds4L+UJYT1pT6WHSiYBmKMudGdkG8XzlFIeiqJMzEk=;
        b=fvV8PX/dtK5xcaZnxOhN9owTkS5jW9+X9PXE/ht6bpkqqa4GfL9dsJLItKUOpX34O3
         ZwURPtBcQppl7UYo/kYwmXY8ZD4lNvf1PlWon4F1rJyaC7IoFDSVQllMA1SH53r6KrtK
         UMC16iT+hzxvRNeqpW5wdjvl2uGvAM8Xgqq9vEUDjUtEhfsmPJedmRBTkIehNW7EZjZY
         X9b9ONxm9hnnTXJGtxE1ckHRWQNo8G+zS1hM/CK3Ena8RWlfJmii+wXVe4igTySKsGq1
         vikChvSnoy8xiz4i3W0jK7oWygq0HYmryQr3+A1Ale40B2bkf9/mFrgESQbfJWw97/YZ
         P6BQ==
X-Gm-Message-State: APjAAAXcXgZWvPYDTsn2k2aoUw9QpJSoxx3Z4doXrAWVKU7lLbUAF4y0
        f+fDP0NxBM/oq4bLjptz7rY5ExjQUcoQ8Te0kZFPpg==
X-Google-Smtp-Source: APXvYqx6ne4ZoU3BCMk6Y43R3NjGX+2Xnil3HjQOaE1WyLPSLxWdH2x2nH3M9xIn8QTTxUx4sUfEIAFixbKnzTKHFsA=
X-Received: by 2002:a63:60a:: with SMTP id 10mr832395pgg.381.1566948592560;
 Tue, 27 Aug 2019 16:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <1566920867-27453-1-git-send-email-cai@lca.pw> <CAKwvOdmEZ6ADQyquRYmr+uNFXyZ0wpBZxNCrQnn8qaRZADzjRw@mail.gmail.com>
In-Reply-To: <CAKwvOdmEZ6ADQyquRYmr+uNFXyZ0wpBZxNCrQnn8qaRZADzjRw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 16:29:41 -0700
Message-ID: <CAKwvOd=eAzohWEHhQqX8K7LDqYQJvRn=-h2q3me8uUUpyWzEBQ@mail.gmail.com>
Subject: Re: [PATCH] mm: silence -Woverride-init/initializer-overrides
To:     Qian Cai <cai@lca.pw>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 27, 2019 at 8:49 AM Qian Cai <cai@lca.pw> wrote:
> >
> > When compiling a kernel with W=1, there are several of those warnings
> > due to arm64 override a field by purpose. Just disable those warnings
> > for both GCC and Clang of this file, so it will help dig "gems" hidden
> > in the W=1 warnings by reducing some noises.
> >
> > mm/init-mm.c:39:2: warning: initializer overrides prior initialization
> > of this subobject [-Winitializer-overrides]
> >         INIT_MM_CONTEXT(init_mm)
> >         ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./arch/arm64/include/asm/mmu.h:133:9: note: expanded from macro
> > 'INIT_MM_CONTEXT'
> >         .pgd = init_pg_dir,
> >                ^~~~~~~~~~~
> > mm/init-mm.c:30:10: note: previous initialization is here
> >         .pgd            = swapper_pg_dir,
> >                           ^~~~~~~~~~~~~~
> >
> > Note: there is a side project trying to support explicitly allowing
> > specific initializer overrides in Clang, but there is no guarantee it
> > will happen or not.
> >
> > https://github.com/ClangBuiltLinux/linux/issues/639
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  mm/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/Makefile b/mm/Makefile
> > index d0b295c3b764..5a30b8ecdc55 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
>
> Hi Qian, thanks for the patch.
> Rather than disable the warning outright, and bury the disabling in a
> directory specific Makefile, why not move it to W=2 in
> scripts/Makefile.extrawarn?
>
>
> I think even better would be to use pragma's to disable the warning in
> mm/init.c.  Looks like __diag support was never ported for clang yet
> from include/linux/compiler-gcc.h to include/linux/compiler-clang.h.
>
> Then you could do:
>
>  28 struct mm_struct init_mm = {
>  29   .mm_rb    = RB_ROOT,
>  30   .pgd    = swapper_pg_dir,
>  31   .mm_users = ATOMIC_INIT(2),
>  32   .mm_count = ATOMIC_INIT(1),
>  33   .mmap_sem = __RWSEM_INITIALIZER(init_mm.mmap_sem),
>  34   .page_table_lock =
> __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>  35   .arg_lock =  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  36   .mmlist   = LIST_HEAD_INIT(init_mm.mmlist),
>  37   .user_ns  = &init_user_ns,
>  38   .cpu_bitmap = { [BITS_TO_LONGS(NR_CPUS)] = 0},
> __diag_push();
> __diag_ignore(CLANG, 4, "-Winitializer-overrides")
>  39   INIT_MM_CONTEXT(init_mm)
> __diag_pop();
>  40 };
>
>
> I mean, the arm64 case is not a bug, but I worry about turning this
> warning off.  I'd expect it to only warn once during an arm64 build,
> so does the warning really detract from "W=1 gem finding?"
>
> > @@ -21,6 +21,9 @@ KCOV_INSTRUMENT_memcontrol.o := n
> >  KCOV_INSTRUMENT_mmzone.o := n
> >  KCOV_INSTRUMENT_vmstat.o := n
> >
> > +CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
>
> -Woverride-init isn't mentioned in the commit message, so not sure if
> it's meant to ride along?
>
> > +CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)

That said, it's not too bad to disable it for one object file that
contains a single struct definition.

-- 
Thanks,
~Nick Desaulniers
