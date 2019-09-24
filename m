Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33409BD1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 20:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405308AbfIXScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 14:32:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37928 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbfIXScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:32:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so1863206pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFxAZD1w5UhTlzLtE5TmBr2XeUa2P0bLYhndFfGu00E=;
        b=LLxllnZjxLQEkI7TInx636+7EuAGGhGvR+v/4upvBsIM7hSokgnlBB57aHaRGs7QWZ
         PocntCahXvUaEtsgonPtApkdgyww6jOnWuCjqiZnjxTx1sJipnFIEUHrNz4MaxzpHOcK
         YjVaIFRWF5YLLylu9FJzwhydqJEvuzfS9pEhlSz6DO/e21R1An8C4uwbBVDoaZOT/XYv
         wZUZKP10+AI/5+C+9JqHlicDRYp9lXogUipxxQzyjjCJY5wdZDDWVr4A9kqYDCIWUym9
         QzHhIxcNleqRWPWoRrcJ3qHOUJXe7LZ3EC3HZGEecMR4hFLPeI3x9ywGT6UEymh3zwqx
         Ud5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFxAZD1w5UhTlzLtE5TmBr2XeUa2P0bLYhndFfGu00E=;
        b=ME2x9QCuQEkORp24hmxad+U3EMyNnDelp8l209u2VmNoSDMhg3pZiqWkV798lcGbZW
         qLtUP4AWf0t+z1pxxTQotHGHJpKU0vGIRN9RIcBvMoIwKAv9GA2CF/fLsdhUCV+0FORg
         rSrBDmsh4fEKRsaFU4eEU5AWBYkcSjqE7gvrKsJUc3pGpsC5o0XijvkdhWjFWNGx092P
         YtudpV1+bEnSp+KZZp47IpoKv1RADoM7Wf/xGiyJMXvW0T5MUOZaMi9Le3WHNN3CDWZh
         4Tx2vtDjU4eRtB3tLTmbonj/xB1xZLxT7CoRVrBJEGDZeqcrncXQ6p+aMzkM7+EYSxuA
         cfRw==
X-Gm-Message-State: APjAAAUMF2yu5HMEe0b1MxsbTD3c6mDsEEh2ZizmDWYmd/YePgSPt5u2
        7FWfVc9IXSDe85J8mI8mt7eUuX1vFWnnRsGRg3hAsQ==
X-Google-Smtp-Source: APXvYqxQV005fHF+HvaEruj1ZJoqo8PtGXpIj9Fq/xsRTZaI4vzVDhfvWzJdU/SymbK4kv1dKZ8aH8kfkI086k8A0ic=
X-Received: by 2002:a63:d908:: with SMTP id r8mr4509167pgg.263.1569349937836;
 Tue, 24 Sep 2019 11:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923222403.22956-1-ndesaulniers@google.com> <20190924182417.GA2714282@archlinux-threadripper>
In-Reply-To: <20190924182417.GA2714282@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Sep 2019 11:32:06 -0700
Message-ID: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
Subject: Re: [PATCH] x86, realmode: explicitly set ENTRY in linker script
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:24 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Sep 23, 2019 at 03:24:02PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Linking with ld.lld via $ make LD=ld.lld produces the warning:
> > ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000
> >
> > Linking with ld.bfd shows the default entry is 0x1000:
> > $ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
> >   Entry point address:               0x1000
> >
> > While ld.lld is being pedantic, just set the entry point explicitly,
> > instead of depending on the implicit default.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/216
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/x86/realmode/rm/realmode.lds.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
> > index 3bb980800c58..2034f5f79bff 100644
> > --- a/arch/x86/realmode/rm/realmode.lds.S
> > +++ b/arch/x86/realmode/rm/realmode.lds.S
> > @@ -11,6 +11,7 @@
> >
> >  OUTPUT_FORMAT("elf32-i386")
> >  OUTPUT_ARCH(i386)
> > +ENTRY(0x1000)
> >
> >  SECTIONS
> >  {
> > --
> > 2.23.0.351.gc4317032e6-goog
> >
>
> This appears to break ld.bfd?
>
> ld:arch/x86/realmode/rm/realmode.lds:131: syntax error
> make[5]: *** [../arch/x86/realmode/rm/Makefile:54: arch/x86/realmode/rm/realmode.elf] Error 1
> make[4]: *** [../arch/x86/realmode/Makefile:20: arch/x86/realmode/rm/realmode.bin] Error 2
> make[3]: *** [../scripts/Makefile.build:509: arch/x86/realmode] Error 2

Thanks for testing.  Strange, it seems that ld.bfd doesn't like it as
an ENTRY in the linker script, but will accept `-e <addr>`.  Not sure
if that's a bug in ld.bfd, or if ld.lld should error as well?
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Using_ld_the_GNU_Linker/simple-commands.html
v2 inbound.
-- 
Thanks,
~Nick Desaulniers
