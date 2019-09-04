Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD8A9668
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 00:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfIDW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 18:28:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34152 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:28:14 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so200122ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=126flrf1A3cL3mz+nUSHlYojF+EVKVDxSC6U82okBVY=;
        b=j45t4WouLX5NDL22pWBGeIDHoUkIf57zOrKuKTrDdXFkdhudfHr4rKqTyrdi9CCmIS
         co7xFmgjIgHRqewrmO/UxS3Pe5F4UICZt3Gpz++LSvHF24mMe0y+zVVhRG0B1pEbtG7R
         APuSG5h3M7zYSsNXNK1r7iTFCJIOGpQeaTw8GkmvDGWe/2q7O5Ngzey49dzjK3A/MPiw
         lyueua7ePwhicylVYuL84W2ooF874zW1YHUj1AdlbVymi1tbFQuA1T+h59OJp5sMG33G
         tRE0Tybv0voiNCbGI0QyPexlDQiCxnYmOCvTOPWJjAT9kimUrXGcXKl8JTRL1zNtbaPl
         cPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=126flrf1A3cL3mz+nUSHlYojF+EVKVDxSC6U82okBVY=;
        b=tL6zn/+UjQzs7WykH4a3Cid6204ChWO+7bsCBT5f/018aUqXYCzUbumcqukGmh3OWm
         RI+RFP/fHwkMnjl+xlFXs4dFwQvJhAM1Ny9yp6johx6+nIXRUl5IQm/xDuZuLlQYRpWe
         M3sPgX4spW2yeR7917987qkYRAUZpvCQjgZm6I4lN+OWbWnD30baO+bL288T6YiqSC6F
         FzxtJcXjYe7nnc9Q0pv6aM8Ud1CGTrxhW4JCq5h75mjXvl26AfN74vw169uqxgdQFo7g
         lKkVuONQcp6Rs7vobsYB8vCJ+BhjbMp+VI6mrAqh/SWUbXduT9thUwB7AqFoe6M3UwQf
         D8NA==
X-Gm-Message-State: APjAAAXJRX8L4ucQwWtRju22cfea0kJ2t9lS9iZQqmPFHJCYrVqHqc0p
        xYH81S/q8A38TtXZ4aK5//jprBDhsQhA5GeFNSvSMQ==
X-Google-Smtp-Source: APXvYqyUB21xkViFEt8SKBxm/JQUeSbWb1SQPBt2RmoEHfwOq5hImo+XL0pA+sUuTuQC5+BwsIUxlPsoP7y1VeffMmY=
X-Received: by 2002:a02:93e5:: with SMTP id z92mr672371jah.8.1567636093257;
 Wed, 04 Sep 2019 15:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
In-Reply-To: <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
Date:   Wed, 4 Sep 2019 15:28:01 -0700
Message-ID: <CAMVonLiOB4PnbnLGo9gP8MK8kGd_e9vW_t+GOPuHMO_RqmkKNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> + (folks recommended by ./scripts/get_maintainer.pl <patchfile>)
> (See also, step 7:
> https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/)
>
> On Wed, Sep 4, 2019 at 2:45 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > The last change to this Makefile caused relocation errors when loading
>
> It's good to add a fixes tag like below when a patch fixes a
> regression, so that stable backports the fix as far back as the
> regression:
> Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS")
>
> > a kdump kernel.  This change restores the appropriate flags, without
> > reverting to the former practice of resetting KBUILD_CFLAGS.
> >
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  arch/x86/purgatory/Makefile | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index 8901a1f89cf5..9f0bfef1f5db 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -18,37 +18,40 @@ targets += purgatory.ro
> >  KASAN_SANITIZE := n
> >  KCOV_INSTRUMENT := n
> >
> > +# These are adjustments to the compiler flags used for objects that
> > +# make up the standalone porgatory.ro
> > +
> > +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> > +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
>
> Thanks for confirming the fix.  While it sounds like -mcmodel=large is
> the only necessary change, I don't object to -ffreestanding of
> -fno-zero-initialized-in-bss being readded, especially since I think
> what you've done with PURGATORY_CFLAGS_REMOVE is more concise.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Vaibhav, do you still have an environment setup to quickly test this
> again w/ Clang builds?

I will setup the environment and will try the changes.

> Tglx, we'll likely want to get this into 5.3 if it's not too late (I
> saw Miguel Ojeda mention there might be an -rc8)?
>
> > +
> >  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
> >  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> >  # sure how to relocate those.
> >  ifdef CONFIG_FUNCTION_TRACER
> > -CFLAGS_REMOVE_sha256.o         += $(CC_FLAGS_FTRACE)
> > -CFLAGS_REMOVE_purgatory.o      += $(CC_FLAGS_FTRACE)
> > -CFLAGS_REMOVE_string.o         += $(CC_FLAGS_FTRACE)
> > -CFLAGS_REMOVE_kexec-purgatory.o        += $(CC_FLAGS_FTRACE)
> > +PURGATORY_CFLAGS_REMOVE                += $(CC_FLAGS_FTRACE)
> >  endif
> >
> >  ifdef CONFIG_STACKPROTECTOR
> > -CFLAGS_REMOVE_sha256.o         += -fstack-protector
> > -CFLAGS_REMOVE_purgatory.o      += -fstack-protector
> > -CFLAGS_REMOVE_string.o         += -fstack-protector
> > -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector
> > +PURGATORY_CFLAGS_REMOVE                += -fstack-protector
> >  endif
> >
> >  ifdef CONFIG_STACKPROTECTOR_STRONG
> > -CFLAGS_REMOVE_sha256.o         += -fstack-protector-strong
> > -CFLAGS_REMOVE_purgatory.o      += -fstack-protector-strong
> > -CFLAGS_REMOVE_string.o         += -fstack-protector-strong
> > -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector-strong
> > +PURGATORY_CFLAGS_REMOVE                += -fstack-protector-strong
> >  endif
> >
> >  ifdef CONFIG_RETPOLINE
> > -CFLAGS_REMOVE_sha256.o         += $(RETPOLINE_CFLAGS)
> > -CFLAGS_REMOVE_purgatory.o      += $(RETPOLINE_CFLAGS)
> > -CFLAGS_REMOVE_string.o         += $(RETPOLINE_CFLAGS)
> > -CFLAGS_REMOVE_kexec-purgatory.o        += $(RETPOLINE_CFLAGS)
> > +PURGATORY_CFLAGS_REMOVE                += $(RETPOLINE_CFLAGS)
> >  endif
> >
> > +CFLAGS_REMOVE_purgatory.o      += $(PURGATORY_CFLAGS_REMOVE)
> > +CFLAGS_purgatory.o             += $(PURGATORY_CFLAGS)
> > +
> > +CFLAGS_REMOVE_sha256.o         += $(PURGATORY_CFLAGS_REMOVE)
> > +CFLAGS_sha256.o                        += $(PURGATORY_CFLAGS)
> > +
> > +CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
> > +CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
> > +
> >  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> >                 $(call if_changed,ld)
> >
> > --
> > 2.12.3
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
