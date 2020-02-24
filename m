Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2689E16B33B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgBXVxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 16:53:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32917 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBXVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:53:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id h4so10159279qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oh8DgJY+ghrUGFSaCOcqO7JdsvvWMKpOwz7kUfngxiA=;
        b=s+riR0kjynNOcpmJzcpRRAC82J0KHzMa3m4Dx/MKE+/lYxGbWiw95DcP2oYkunDzq7
         /35hf4KjVrh/sGqoXIXpkot4E1S0vAWiXNS7WHhGBrg8fXcN0SS0VmSGgjujyCVjHCxy
         vuxzeQDGHqO+8KYZbjb9rZG358d8T/ldz/k1ZAMVUJClwoVm/uwKGH0LkcPObHyqwTJ/
         pdT5SmImZolkaS3HPNu9CARp5sUujn6lFv6YD0FZUiH0VCr7mxII/sSuXIOxa+HWne0i
         JHWwEwHk0WBbm8e37/56d+d/qw32IePK1K3QjUVKsVmFhzaTpRo0Z+/J9xJX8BBlN2Im
         CRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oh8DgJY+ghrUGFSaCOcqO7JdsvvWMKpOwz7kUfngxiA=;
        b=IFe+xkQ3E2y3HERnlqpcGBacEsDZj8bSZYyzk6Iw1e2CMt8n74ewxQFnqwODiLg2vd
         ggIUskp2NjaiICbW7cDmD3iX9jePKxH7Y/Sk3rdr6NoY7b0vr1YAVvTUAGJHMSrDpfX1
         CBLVZThU2L6t9hmWqhjyLSF2Kl9cSd4ObFNXqWClZzLYKFKhZ2C4UxMSCK2gbJ5GBcuT
         aHp2Ncg9o+nJLDpa25CoUxixoZ62RepiWuTChV/5nqb200c5mm78i6EXKj+NtbBGXsgg
         j3ZfvcWgqdocdXt8LB32ZQKMT6Np+M0RwSDqpU52CTEcawm3f7F2UnZ4AEHsqGO9u1NN
         6H4A==
X-Gm-Message-State: APjAAAWGKHHkBEwLfUyAgk4yJdyBnR3GkQaPvy8KoxOQfCcXPoEVNot7
        kCfsHd4hSkjC1/0NurGiXas5I38yWwk=
X-Google-Smtp-Source: APXvYqzgXJz66NRWJXvIb70aGJhRCLaL+ZakD7e8xuTWliPFXqx8yqKGtLuvV8nvtYptZkMMhhciVg==
X-Received: by 2002:a05:620a:1235:: with SMTP id v21mr18803375qkj.44.1582581213287;
        Mon, 24 Feb 2020 13:53:33 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g26sm6425975qkk.68.2020.02.24.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:53:32 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 16:53:31 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] Stop generating .eh_frame sections
Message-ID: <20200224215330.GA560533@rani.riverdale.lan>
References: <20200222235709.GA3786197@rani.riverdale.lan>
 <20200223193715.83729-1-nivedita@alum.mit.edu>
 <CAKwvOd=qVmb7UEzUSQ5-MUhpRA9Jpu3fMmmMLGdmydLoJV-kkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=qVmb7UEzUSQ5-MUhpRA9Jpu3fMmmMLGdmydLoJV-kkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:49:03PM -0800, Nick Desaulniers wrote:
> On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > In three places in the x86 kernel we are currently generating .eh_frame
> > sections only to discard them later via linker script. This is in the
> > boot code (setup.elf), the realmode trampoline (realmode.elf) and the
> > compressed kernel.
> >
> > Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
> > adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
> > sections in the first place, rather than discarding it in the linker
> > script.
> >
> > Arvind Sankar (2):
> >   arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
> >   arch/x86: Drop unneeded linker script discard of .eh_frame
> 
> Thanks for the series! I've left some feedback for a v2. Would you
> mind please including a revert of ("x86/boot/compressed: Remove
> unnecessary sections from bzImage") in a v2 series?  Our CI being red
> through the weekend is no bueno.

Sorry about that. Boris already updated tip:x86/boot to only discard
eh_frame, so your CI should be ok at least now.

> 
> >
> >  arch/x86/boot/Makefile                | 1 +
> >  arch/x86/boot/compressed/Makefile     | 1 +
> >  arch/x86/boot/setup.ld                | 1 -
> >  arch/x86/kernel/vmlinux.lds.S         | 3 ---
> >  arch/x86/realmode/rm/Makefile         | 1 +
> >  arch/x86/realmode/rm/realmode.lds.S   | 1 -
> >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> >  7 files changed, 5 insertions(+), 6 deletions(-)
> >
> > --
> > 2.24.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
