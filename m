Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22423112939
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 11:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLDKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 05:24:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45665 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfLDKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:24:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so7805681wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuqJKgxzORWixv+ONGuRvuIb4W1dExSeU86nj2DCsb0=;
        b=MYMcpF0NBpya3Dp0QUs8IhS2XLN5hBn3Y74n2Fpg/00W933ktGY5gQuF5wGqC7dYf/
         09qiEy92KfIgQgS+Zmo0DpX7rURPfWDBgRkP3d/r9p6HsYExqQAgaV/iRhlwDbZGw98L
         uPjFZBSTofPNVxyjqtBh6MdbKRYzbm8MSmaMbsCVuthOUDjBMC7fGMTpxrA33vLEM/Ir
         4cFfh+nlygb67h7WLQ083u+1eogyQ1SvUA71LYknaaooRX/9P/7kQU54UYf1oMm1qMi6
         PE25lcUp+E2amWLAZt0AbC10mzYJ6McnJbJKCA3Ann6D5MibCmobitoldmtdRSxAcjvV
         y9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuqJKgxzORWixv+ONGuRvuIb4W1dExSeU86nj2DCsb0=;
        b=WFsh6d+rXgd5Q0ROwPU9XMfvlGwLzPYK6aIG6ND9DRijXiIjJgt5ABsyzcFhusJtt/
         /SM3cJRsA7OSl9Fgkr0N7cDETHdjnuIsB3v45mmvcStV9iTWx1laejd4tDTj5DteOLe/
         OEtg9bi68D7H6KG4d3GHqHhF0bLj14DaREeI+qxta6lNkVvl5nRyLJF/4xLJWFVzmLTs
         36EbsvJZv9cdP1nJitftNhw9cJDwbQqGa/TdRTJ20mF6gJV5N5GWvjFlWvCilCSaOK1g
         RM6SUgGUb4IGWSqQl6VrTT1cnGqjNccx7xlecOnLMIKeFPQWviAz8psSyctDHKnBgMmz
         hqfg==
X-Gm-Message-State: APjAAAXGHL6CiNzh0nuxvFKw0cvqaXFJv7yuC1M14q59fUJi5ohSDwQl
        LExer5pqr8M3wojLazzJ3Qk7tDpp5OZR4bCXcAlwSw==
X-Google-Smtp-Source: APXvYqxWwFndRJgAqjBJu+iNimNvB0sXaYF2yRdMmBK9Aw4qj7i6zYf8yApxP+lwHCYRcybjgFLsPwfMKMGRGGwlg9Y=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr3249867wrw.246.1575455044775;
 Wed, 04 Dec 2019 02:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com> <20191204101412.GD114697@gmail.com>
In-Reply-To: <20191204101412.GD114697@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 10:24:01 +0000
Message-ID: <CAKv+Gu8TcF69QNhqRJGh+A8AJ=91dfTJhRmV=J4V3ML9vQWoXA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 10:14, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dave Young <dyoung@redhat.com> wrote:
>
> > On 12/04/19 at 03:52pm, Dave Young wrote:
> > > Michael Weiser reported he got below error during a kexec rebooting:
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > is to reuse the EFI boot services data across kexec reboot. For example
> > > the BGRT image data and some ESRT memory like Michael reported.
> > >
> > > But although the memory is reserved it is not updated in X86 e820 table.
> > > And kexec_file_load iterate system ram in io resource list to find places
> > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > initramfs overwritten the ESRT memory and then the failure happened.
> >
> > s/overwritten/overwrote :)  If need a repost please let me know..
> >
> > >
> > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > by updating the reserved EFI boot services memory as reserved type in e820.
> > >
> > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > bypassed in the reservation code path because they are assumed as reserved.
> > > But the reservation is still needed for multiple kexec reboot.
> > > And it is the only possible case we come here thus just drop the code
> > > chunk then everything works without side effects.
> > >
> > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > not trigger the problem, but I successfully tested with BGRT instead.
> > > both kexec_load and kexec_file_load work and kdump works as well.
> > >
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
>
>
> So I edited this to:
>
>  From: Dave Young <dyoung@redhat.com>
>
>  Michael Weiser reported he got this error during a kexec rebooting:
>
>    esrt: Unsupported ESRT version 2904149718861218184.
>
>  The ESRT memory stays in EFI boot services data, and it was reserved
>  in kernel via efi_mem_reserve().  The initial purpose of the reservation
>  is to reuse the EFI boot services data across kexec reboot. For example
>  the BGRT image data and some ESRT memory like Michael reported.
>
>  But although the memory is reserved it is not updated in the X86 E820 table,
>  and kexec_file_load() iterates system RAM in the IO resource list to find places
>  for kernel, initramfs and other stuff. In Michael's case the kexec loaded
>  initramfs overwrote the ESRT memory and then the failure happened.
>
>  Since kexec_file_load() depends on the E820 table being updated, just fix this
>  by updating the reserved EFI boot services memory as reserved type in E820.
>
>  Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
>  bypassed in the reservation code path because they are assumed as reserved.
>
>  But the reservation is still needed for multiple kexec reboots,
>  and it is the only possible case we come here thus just drop the code
>  chunk, then everything works without side effects.
>
>  On my machine the ESRT memory sits in an EFI runtime data range, it does
>  not trigger the problem, but I successfully tested with BGRT instead.
>  both kexec_load() and kexec_file_load() work and kdump works as well.
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
