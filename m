Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63D5D6E89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfJOFYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 01:24:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfJOFYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:24:01 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6217859FC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 05:24:00 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id t11so30212967ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GX8bC+LvWnJ5dJICeG2nAc0CD2f9tU+0Yk6RVJKRFtA=;
        b=gld90+XXU0shoZy+JcaLmfQx4IgZUBHkdD4We2sGNgzELATok5db6lpviae34lGkw2
         IxhwzJ8ido4hCxMAl2Ld8KFygCYe4GWytRcHYkjmBeu0A4oTrJUQV01Dk8K2EIIA4fnE
         bOaRgJpqjxsaLH4GgSrD3bYeUm1nlPUBZpl3wKVRzdPZVv8RE/naMHDFvnMQWu4h3yf/
         d/+tcXkZasww2yXBO6Y8mPesUYsuCv8YOSVbHRl7Zi7SI0bio6J6gub9baDVoQZtcsZN
         iyxOW0O6wNFnjiQ82I9dUd09iig7QQnxECqOPzIGrPOodHCpzFBKsSvDwTVDB6mlKzOI
         RKhw==
X-Gm-Message-State: APjAAAWmYmSU7TRMEDcA3e7bKyQzsyBKPGGNevIcjb5EOvFvVLeZg3wG
        kxqDX+P86vpAvnbcFJzl5S7jEdWp6BVCrNlimWzL9Tk4fA78yZRqjBkc5VgLKnH1ga0X53PjbJ/
        pPHUH0QQuSAZk02EvyShtZmLTVVQS1SiyVLvsXk/I
X-Received: by 2002:a6b:d104:: with SMTP id l4mr6603812iob.50.1571117039945;
        Mon, 14 Oct 2019 22:23:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqww5YfFPBA4nCSFpjo/cQDUXxSK3cOo8C1EDzKG3a48BASQG3eqI/WCzxReb0tvQtzyFwx3u5yJVlqH0eDl4Ms=
X-Received: by 2002:a6b:d104:: with SMTP id l4mr6603788iob.50.1571117039602;
 Mon, 14 Oct 2019 22:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191012034421.25027-1-kasong@redhat.com> <20191014101419.GA4715@zn.tnic>
In-Reply-To: <20191014101419.GA4715@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 15 Oct 2019 13:23:48 +0800
Message-ID: <CACPcB9f6i_PvxDz9aLpAiakmnEOu-o5N_ZvP5dGe73yyS-KvjA@mail.gmail.com>
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 6:14 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Oct 12, 2019 at 11:44:21AM +0800, Kairui Song wrote:
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
> >
> > Efi stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, efi stub can't relocate kernel to the preferred
> > address, so it fallback to query and alloc from EFI firmware for lowest
>
> Your spelling of "EFI" is like a random number generator in this
> paragraph: "Efi", "efi" and "EFI". Can you please be more careful when
> writing your commit messages? They're not some random text you hurriedly
> jot down before sending the patch but a most important description of
> why a change is being done.

Sorry I just ignored the acronym usage problems, I did double check the text but
didn't realize this is a problem... Will correct them.

>
> And if you don't see their importance now, just try doing some git
> archeology, trying to understand why a change has been done in the past
> and then encounter a commit message two-liner which doesn't say sh*t.
> Then you'll start appreciating properly written commit messages.
>
> > usable memory region.
> >
> > It's incorrect to use the lowest memory address. In later stage, kernel
> > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > but efi stub will end up relocating kernel below it.
>
> Why don't you simply explain what
> choose_random_location()->find_random_virt_addr() does? That's the
> problem you're solving, right? KASLR using LOAD_PHYSICAL_ADDR as the
> minimum...
>
> > The later kernel decompressing code will forcefully correct the wrong
> > kernel load location,
>
> ... or do you mean by that the dance in
> arch/x86/boot/compressed/head_64.S where we move the kernel temporarily
> to LOAD_PHYSICAL_ADDR for the decompression?

The kernel move in arch/x86/boot/compressed/head_64.S is the problem
I'm saying here.

I thought it's a bad idea to include too much details about codes and details in
the commit message, so tried to describe it without mentioning the
implementation details.
It's making things confusing indeed.

I'll rethink about how the commit message should be composed...

>
> You can simply say that here...
>

OK, then I'll do so. Will update the commit message.

--
Best Regards,
Kairui Song
