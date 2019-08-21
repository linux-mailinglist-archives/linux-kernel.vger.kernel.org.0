Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F91981A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfHURoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 13:44:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43933 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfHURoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:44:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so4029932qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7oJ/OCmlk0Qs0pfRpZmkhAcu01BAL6U4WS47xIOsJo=;
        b=SPCa6SjcPxDoaAGyDJQrUXVo8eHayzWjjb7AwwcGDfVN4yzfCj6z42kaX3n9bdQC30
         HsV5lZ4NxME6ZkF7gyIV6LdUccFv0vNjdVIAYCyFi4sZRRdMrp1uqndl/kwbvxx6idsS
         mWpC8jirLQYtONEK+ZuummyxBr8DnSQXJ4BZokgtaBgVt7In/dUvj86BjFSOxdqAynAq
         YlZIXwfb+UiI0z2OJ0YBto3BC+Q2dnmC9zGZi8PDRJGW0NtapLeYvCI6BSAGEq1cm8kZ
         g1qwMweNkzLtW4sR5Qa9ae0rVHjFbdby2GljlxxGkVgw36KiWz6lKKL/NlMWQASLLhKu
         bc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7oJ/OCmlk0Qs0pfRpZmkhAcu01BAL6U4WS47xIOsJo=;
        b=ZqVMjYHdVEdz9jleAtf4O1HQ2iwqlUQj3Uzx8Dj4QsZd/CpfWHVOANfaenhkxSKF5h
         g7fehA4zgPFUVL+POdW/zyl3Kpc+XANZiZteuZdL0IdcOzk3j22BJhfZrpsv3MSJujou
         qLSXaoB/V2Vev/EROgcPVag0rS4bjwfWvvDFVuFMnPHFSB1mwZKaN2XN5nXm5kpuVDvK
         +dVvpJ7wld+EdzHjIiY00OYQ3E3wWHgupvdVj+oIxk84EaMFer78nNSrCBUiu1dm7Pn6
         0fJeIB3j1tsTETzqg9np0jCOON8ufBtdP+93nZNhxXPuFSCN4g/FXomuQLKH6aYJ7k8g
         jn6g==
X-Gm-Message-State: APjAAAWU2ecmHWAZ4y579VfaBE45amR+85+wTGanjQkoCBfOXe2wewKR
        Pl6PdUlX8dsKTR9/223Y8spSPFi3Rv6bFaDvQTJIY13df2w=
X-Google-Smtp-Source: APXvYqyYr/8HxwPuJgfd9/gpA1tuXbCV5gxP2MdkmTD4Qew8BU73om7YNYHiMKjVsMyHQgGaz/5dtQFB6yUE++r+9R8=
X-Received: by 2002:ac8:23d6:: with SMTP id r22mr2178545qtr.76.1566409437921;
 Wed, 21 Aug 2019 10:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190820194351.107486-1-nhuck@google.com> <CAKwvOdm+sGyKfAMNbL10ME=DrG5=4d5kvzdMxjNC22JLLr1h=g@mail.gmail.com>
In-Reply-To: <CAKwvOdm+sGyKfAMNbL10ME=DrG5=4d5kvzdMxjNC22JLLr1h=g@mail.gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 21 Aug 2019 10:43:47 -0700
Message-ID: <CAJkfWY4cHz+i8kYg2i1Krs-32nh7-WQU+psT=DRGYnTje6yj4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>, Tri Vo <trong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 2:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 20, 2019 at 12:44 PM Nathan Huckleberry <nhuck@google.com> wrote:
> >
> > The stackframe setup when compiled with clang is different.
> > Since the stack unwinder expects the gcc stackframe setup it
> > fails to print backtraces. This patch adds support for the
> > clang stackframe setup.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Tri Vo <trong@google.com>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> > Changes from RFC
> > * Push extra register to satisfy 8 byte alignment requirement
> > * Add clarifying comments
> > * Separate code into its own file
>
> Thanks for the patch! The added comments and moving the implementation
> to its own file make it easier to review.
>
> >
> >  arch/arm/Kconfig.debug         |   4 +-
> >  arch/arm/Makefile              |   5 +-
> >  arch/arm/lib/Makefile          |   8 +-
> >  arch/arm/lib/backtrace-clang.S | 224 +++++++++++++++++++++++++++++++++
> >  4 files changed, 237 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/arm/lib/backtrace-clang.S
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 85710e078afb..92fca7463e21 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -56,7 +56,7 @@ choice
> >
> >  config UNWINDER_FRAME_POINTER
> >         bool "Frame pointer unwinder"
> > -       depends on !THUMB2_KERNEL && !CC_IS_CLANG
> > +       depends on !THUMB2_KERNEL
> >         select ARCH_WANT_FRAME_POINTERS
> >         select FRAME_POINTER
> >         help
> > @@ -1872,7 +1872,7 @@ config DEBUG_UNCOMPRESS
> >           When this option is set, the selected DEBUG_LL output method
> >           will be re-used for normal decompressor output on multiplatform
> >           kernels.
> > -
> > +
>
> Probably can drop the added newline?
>
> >
> >  config UNCOMPRESS_INCLUDE
> >         string
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index c3624ca6c0bc..729e223b83fe 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -36,7 +36,10 @@ KBUILD_CFLAGS        += $(call cc-option,-mno-unaligned-access)
> >  endif
> >
> >  ifeq ($(CONFIG_FRAME_POINTER),y)
> > -KBUILD_CFLAGS  +=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
> > +KBUILD_CFLAGS  +=-fno-omit-frame-pointer
> > +  ifeq ($(CONFIG_CC_IS_GCC),y)
> > +  KBUILD_CFLAGS += -mapcs -mno-sched-prolog
> > +  endif
>
> While I can appreciate the indentation, it's unusual to indent
> additional depths of kernel Makefiles.  At least the rest of this file
> does not do so.  Of course, the other Makefile you touch below does
> two spaces.  At least try to keep the file internally consistent, even
> if the kernel itself is inconsistent.
>
> >  endif
> >
> >  ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index b25c54585048..e10a769c72ec 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -5,7 +5,7 @@
> >  # Copyright (C) 1995-2000 Russell King
> >  #
> >
> > -lib-y          := backtrace.o changebit.o csumipv6.o csumpartial.o   \
> > +lib-y          := changebit.o csumipv6.o csumpartial.o               \
> >                    csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
> >                    delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
> >                    memmove.o memset.o setbit.o                        \
> > @@ -19,6 +19,12 @@ lib-y                := backtrace.o changebit.o csumipv6.o csumpartial.o   \
> >  mmu-y          := clear_user.o copy_page.o getuser.o putuser.o       \
> >                    copy_from_user.o copy_to_user.o
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +  lib-y += backtrace-clang.o
> > +else
> > +  lib-y += backtrace.o
> > +endif
>
> The indentation should match the above (from this file).  Looks like 1
> tab after lib-y.  See L34(CONFIG_CPU_32v3) for what I would have
> expected.
>
> > +
> >  # using lib_ here won't override already available weak symbols
> >  obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
> >
> > diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
> > new file mode 100644
> > index 000000000000..2b02014dbdd1
> > --- /dev/null
> > +++ b/arch/arm/lib/backtrace-clang.S
> > @@ -0,0 +1,224 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + *  linux/arch/arm/lib/backtrace-clang.S
> > + *
> > + *  Copyright (C) 2019 Nathan Huckleberry
> > + *
> > + */
> > +#include <linux/kern_levels.h>
> > +#include <linux/linkage.h>
> > +#include <asm/assembler.h>
> > +               .text
> > +
> > +/* fp is 0 or stack frame */
>
> ah, I see that the reference implementation uses an assembly comment
> here. Ok (sorry for the noise).
>
> > +
> > +#define frame  r4
> > +#define sv_fp  r5
> > +#define sv_pc  r6
> > +#define mask   r7
> > +#define sv_lr   r8
> > +
> > +ENTRY(c_backtrace)
> > +
> > +#if !defined(CONFIG_FRAME_POINTER) || !defined(CONFIG_PRINTK)
> > +               ret     lr
> > +ENDPROC(c_backtrace)
> > +#else
> > +
> > +
> > +/*
> > + * Clang does not store pc or sp in function prologues
> > + *             so we don't know exactly where the function
> > + *             starts.
> > + * We can treat the current frame's lr as the saved pc and the
> > + *             preceding frame's lr as the lr, but we can't
>
> preceding frame's lr as the current frame's lr, ...
>
> > + *             trace the most recent call.
> > + * Inserting a false stack frame allows us to reference the
> > + *             function called last in the stacktrace.
> > + * If the call instruction was a bl we can look at the callers
> > + *             branch instruction to calculate the saved pc.
> > + * We can recover the pc in most cases, but in cases such as
> > + *             calling function pointers we cannot. In this
> > + *             case, default to using the lr. This will be
> > + *             some address in the function, but will not
> > + *             be the function start.
> > + * Unfortunately due to the stack frame layout we can't dump
> > + *              r0 - r3, but these are less frequently saved.
>
> The use of tabs vs spaces in these comments is inconsistent.  Not that
> I can see whitespace, but:
> https://github.com/nickdesaulniers/dotfiles/blob/37359525f5a403b4ed2d3f9d1bbbee2da8ec8115/.vimrc#L35-L41
> Also, I don't think you need to tab indent every line after the first.
> Where did that format come from?
>
> > + *
> > + * Stack frame layout:
> > + *             <larger addresses>
> > + *             saved lr
> > + *    frame => saved fp
> > + *             optionally saved caller registers (r4 - r10)
> > + *             optionally saved arguments (r0 - r3)
> > + *             <top of stack frame>
> > + *             <smaller addresses>
> > + *
> > + * Functions start with the following code sequence:
> > + * corrected pc =>  stmfd sp!, {..., fp, lr}
> > + *                 add fp, sp, #x
> > + *                 stmfd sp!, {r0 - r3} (optional)
> > + *
> > + *
> > + *
> > + *
> > + *
> > + *
> > + * The diagram below shows an example stack setup
> > + *     for dump_stack.
> > + *
> > + * The frame for c_backtrace has pointers to the
> > + *     code of dump_stack. This is why the frame of
> > + *     c_backtrace is used to for the pc calculation
> > + *     of dump_stack. This is why we must move back
> > + *     a frame to print dump_stack.
> > + *
> > + * The stored locals for dump_stack are in dump_stack's
> > + *     frame. This means that to fully print dump_stack's frame
> > + *     we need the both the frame for dump_stack (for locals) and the
>
> we need both the ...
> (There's an extra `the` in the sentence).
>
> > + *     frame that was called by dump_stack (for pc).
> > + *
> > + * To print locals we must know where the function start is. If
> > + *     we read the function prologue opcodes we can determine
> > + *     which variables are stored in the stack frame.
> > + *
> > + * To find the function start of dump_stack we can look at the
> > + *     stored LR of show_stack. It points at the instruction
> > + *     directly after the bl dump_stack. We can then read the
> > + *     offset from the bl opcode to determine where the branch takes us.
> > + *     The address calculated must be the start of dump_stack.
> > + *
> > + * c_backtrace frame           dump_stack:
> > + * {[LR]    }  ============|   ...
> > + * {[FP]    }  =======|    |   bl c_backtrace
> > + *                    |    |=> ...
> > + * {[R4-R10]}         |
> > + * {[R0-R3] }         |        show_stack:
> > + * dump_stack frame   |        ...
> > + * {[LR]    } =============|   bl dump_stack
> > + * {[FP]    } <=======|    |=> ...
> > + * {[R4-R10]}
> > + * {[R0-R3] }
> > + */
> > +
> > +stmfd   sp!, {r4 - r9, fp, lr} @ Save an extra register
> > +                               @ to ensure 8 byte alignment
> > +movs   frame, r0               @ if frame pointer is zero
> > +beq    no_frame                @ we have no stack frames
> > +
> > +tst    r1, #0x10               @ 26 or 32-bit mode?
> > +moveq  mask, #0xfc000003
>
> Should we be using different masks for ARM vs THUMB as per the
> reference implementation?
The change that introduces the arm/thumb code looked like a script
that was run over all arm in the kernel. Neither this code nor the
reference solution is compatible with arm, so there's no need for the
change.
>
> > +movne  mask, #0                @ mask for 32-bit
> > +
> > +/*
> > + * Switches the current frame to be the frame for dump_stack.
> > + */
> > +               add     frame, sp, #24          @ switch to false frame
> > +for_each_frame:        tst     frame, mask             @ Check for address exceptions
> > +               bne     no_frame
> > +
> > +/*
> > + * sv_fp is the stack frame with the locals for the current considered
> > + *     function.
> > + * sv_pc is the saved lr frame the frame above. This is a pointer to a
> > + *     code address within the current considered function, but
> > + *     it is not the function start. This value gets updated to be
> > + *     the function start later if it is possible.
> > + */
> > +1001:          ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> > +1002:          ldr     sv_fp, [frame, #0]      @ get saved fp
>
> The reference implementation applies the mask to sv_pc and sv_fp.  I
> assume we want to, too?
The mask is already applied to both. See for_each_frame:
>
> > +
> > +               teq     sv_fp, #0               @ make sure next frame exists
> > +               beq     no_frame
> > +
> > +/*
> > + * sv_lr is the lr from the function that called the current function. This
> > + *     is a pointer to a code address in the current function's caller.
> > + *     sv_lr-4 is the instruction used to call the current function.
> > + * This sv_lr can be used to calculate the function start if the function
> > + *     was called using a bl instruction. If the function start
> > + *     can be recovered sv_pc is overwritten with the function start.
> > + * If the current function was called using a function pointer we cannot
> > + *     recover the function start and instead continue with sv_pc as
> > + *     an arbitrary value within the current function. If this is the case
> > + *     we cannot print registers for the current function, but the stacktrace
> > + *     is still printed properly.
> > + */
> > +1003:          ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> > +
> > +               ldr     r0, [sv_lr, #-4]        @ get call instruction
> > +               ldr     r3, .Ldsi+8
>
> I wonder what `dsi` stands for, it could use a better name.  Maybe put
> that mask in a more descriptively named section and use that instead
> of `.Ldsi+8`?
>
> > +               and     r2, r3, r0              @ is this a bl call
> > +               teq     r2, r3
> > +               bne     finished_setup          @ give up if it's not
> > +               and     r0, #0xffffff           @ get call offset 24-bit int
> > +               lsl     r0, r0, #8              @ sign extend offset
> > +               asr     r0, r0, #8
>
> It's too bad this should work for older ARM versions, v6 added
> dedicated instructions for this:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489c/Cihfifdd.html
>
> > +               ldr     sv_pc, [sv_fp, #4]      @ get lr address
> > +               add     sv_pc, sv_pc, #-4       @ get call instruction address
> > +               add     sv_pc, sv_pc, #8        @ take care of prefetch
> > +               add     sv_pc, sv_pc, r0, lsl #2 @ find function start
> > +
> > +finished_setup:
> > +
> > +               bic     sv_pc, sv_pc, mask      @ mask PC/LR for the mode
> > +
> > +/*
> > + * Print the function (sv_pc) and where it was called
> > + *     from (sv_lr).
> > + */
> > +1004:          mov     r0, sv_pc
> > +
> > +               mov     r1, sv_lr
> > +               mov     r2, frame
> > +               bic     r1, r1, mask            @ mask PC/LR for the mode
> > +               bl      dump_backtrace_entry
> > +
> > +/*
> > + * Test if the function start is a stmfd instruction
> > + *     to determine which registers were stored in the function
> > + *     prologue.
> > + * If we could not recover the sv_pc because we were called through
> > + *     a function pointer the comparison will fail and no registers
> > + *     will print.
> > + */
> > +1005:          ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> > +               ldr     r3, .Ldsi               @ instruction exists,
> > +               teq     r3, r1, lsr #11
> > +               ldr     r0, [frame]             @ locals are stored in
> > +                                               @ the preceding frame
> > +               subeq   r0, r0, #4
> > +               bleq    dump_backtrace_stm      @ dump saved registers
>
> Do we need to do anything to test .Ldsi+4? Otherwise looks like we
> define it but don't use it?
>
> > +
> > +/*
> > + * If we are out of frames or if the next frame
> > + *     is invalid.
> > + */
> > +               teq     sv_fp, #0               @ zero saved fp means
> > +               beq     no_frame                @ no further frames
> > +
> > +               cmp     sv_fp, frame            @ next frame must be
> > +               mov     frame, sv_fp            @ above the current frame
> > +               bhi     for_each_frame
> > +
> > +1006:          adr     r0, .Lbad
> > +               mov     r1, frame
> > +               bl      printk
> > +no_frame:      ldmfd   sp!, {r4 - r9, fp, pc}
> > +ENDPROC(c_backtrace)
> > +               .pushsection __ex_table,"a"
> > +               .align  3
> > +               .long   1001b, 1006b
> > +               .long   1002b, 1006b
> > +               .long   1003b, 1006b
> > +               .long   1004b, 1006b
> > +               .long   1005b, 1006b
> > +               .popsection
> > +
> > +.Lbad:         .asciz  "Backtrace aborted due to bad frame pointer <%p>\n"
> > +               .align
> > +.Ldsi:         .word   0xe92d4800 >> 11        @ stmfd sp!, {... fp, lr}
> > +               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> > +               .word   0x0b000000              @ bl if these bits are set
> > +
> > +#endif
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
Thanks for the review, will send a v2 with your suggestions.
