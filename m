Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99CBE378F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439741AbfJXQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 12:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439732AbfJXQMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:12:07 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5AA121A4C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571933526;
        bh=BLLHDwROAf93/5MRoMht9A1lnkPiEcUf5wYfxbtqWxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UjxlRqauqd1oPrLF6wvfCI5vlf/DbwgbzgAYwey/swEIg/Rfr34fBH2cSP+PmeuIf
         z6iEn1sirtCTIQESDvvm2jLkaitv4Ve6PXu2PtCzugch8oVQumox5H6z1aPgaku1aF
         Yz8Kopr2w9TnVbZTqYbnLd0ajio/aI2mxHDFKwWA=
Received: by mail-wr1-f50.google.com with SMTP id o28so26728200wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:12:06 -0700 (PDT)
X-Gm-Message-State: APjAAAXERCkfbR4VNQKMo6bVwGxPSyuV9MN80QgoOsvos8at3NikUq9R
        pLmMMdR6Vjo3zyrdG1OScXTPlSH07Dn8PmrKJ+iv1g==
X-Google-Smtp-Source: APXvYqwWZ1XyZeseylBIXNV03ODFkP+QjhC4uOR0zXgYX/4Z31HQ+LXWD4NhDb2q68L752kFVGb0TQYpK1h9egr5uLk=
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr4378059wrt.195.1571933525027;
 Thu, 24 Oct 2019 09:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
In-Reply-To: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 09:11:53 -0700
X-Gmail-Original-Message-ID: <CALCETrWAALF7EgxHGs-rtZwk1Fxttr56QKXeB6QssXbyXDs+kA@mail.gmail.com>
Message-ID: <CALCETrWAALF7EgxHGs-rtZwk1Fxttr56QKXeB6QssXbyXDs+kA@mail.gmail.com>
Subject: Re: [PATCH] x86/stackframe/32: repair 32-bit Xen PV
To:     Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 3:41 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> Once again RPL checks have been introduced which don't account for a
> 32-bit kernel living in ring 1 when running in a PV Xen domain. The
> case in FIXUP_FRAME has been preventing boot; adjust BUG_IF_WRONG_CR3
> as well just in case.

I'm okay with the generated code, but IMO the macro is too indirect
for something that's trivial.

>
> Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -48,6 +48,17 @@
>
>  #include "calling.h"
>
> +#ifndef CONFIG_XEN_PV
> +# define USER_SEGMENT_RPL_MASK SEGMENT_RPL_MASK
> +#else
> +/*
> + * When running paravirtualized on Xen the kernel runs in ring 1, and hence
> + * simple mask based tests (i.e. ones not comparing against USER_RPL) have to
> + * ignore bit 0. See also the C-level get_kernel_rpl().
> + */

How about:

/*
 * When running on Xen PV, the actual %cs register in the kernel is 1, not 0.
 * If we need to distinguish between a %cs from kernel mode and a %cs from
 * user mode, we can do test $2 instead of test $3.
 */
#define USER_SEGMENT_RPL_MASK 2

but...

> +# define USER_SEGMENT_RPL_MASK (SEGMENT_RPL_MASK & ~1)
> +#endif
> +
>         .section .entry.text, "ax"
>
>  /*
> @@ -172,7 +183,7 @@
>         ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>         .if \no_user_check == 0
>         /* coming from usermode? */
> -       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> +       testl   $USER_SEGMENT_RPL_MASK, PT_CS(%esp)

Shouldn't PT_CS(%esp) be 0 if we came from the kernel?  I'm guessing
the actual bug is in whatever code put 1 in here in the first place.

In other words, I'm having trouble understanding why there is any
context in which some value would be 3 for user mode and 1 for kernel
mode.  Obviously if we're manually IRETing to kernel mode, we need to
set CS to 1, but if we're filling in our own PT_CS, we should just
write 0.

The supposedly offending commit (""x86/stackframe/32: Provide
consistent pt_regs") looks correct to me, so I suspect that the
problem is elsewhere.  Or is it intentional that Xen PV's asm
(arch/x86/xen/whatever) sticks 1 into the CS field on the stack?

Also, why are we supporting 32-bit Linux PV guests at all?  Can we
just delete this code instead?
