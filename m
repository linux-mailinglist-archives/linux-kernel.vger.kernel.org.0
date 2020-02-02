Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17C814FCCB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgBBLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 06:07:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45006 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBBLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 06:07:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so11606309ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ap1iT7SLhLil8Jw+Ki2RQaJZCtXHtNEHLUsGTg71AVg=;
        b=dcWdUf6Ve1Iyamlavd+vB1+W/HWa87sxZS70lJNeguTYxtcYz9kbcdXy8BLIYGbLw9
         OGCJeYyhbEs5mNiJFzOSP0r14U8xW/Io+hJxUYx6lcQ5nWLz/taEapFvyHer9zGKAD6y
         CYAuakkaXI/syFc5G+abwykfV7TwLd4QfHvHHfrJsJa7BCYVueirSOSqe04c1hb3CeBf
         dqW/ahPVKGVCrLC+PPDFv89Lba6gm6yfLote5URFft0bkGXWCdAp8u9LlRCAE4bgX1PR
         6Zuyg4jgd3vyGe66Sw/R0ffBkETlCPGlzVfTN0ZzEL1b2bRUxUqdfJQoGdm6ynOb0C5X
         10PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ap1iT7SLhLil8Jw+Ki2RQaJZCtXHtNEHLUsGTg71AVg=;
        b=NWMHrg7gjwyELRyJnJCtMgtB+KHpeuyYwonY+EpWEx1aCq3O2hOQ+lG9VXLxLX/KL1
         CbfzHwOnWWVdmvELNoND6GBkUdZgdzXK0W+WBgl69pLk0UWwpurjFnYgYtwA2Gw3bmVS
         8wWDpkFZbPv4s/jJvNACLGPxLx7tK8Qk85Z636HCcBwwJjPu3q+Ey7nc8ejckVHs+UnF
         bCqt2j9gX0KeF5+CYxM9E9NELiprkInXxBvtQgryTTFCB4X970HXvAi4YdH0hym6DkhL
         VF/+NtRDEOkLEdUSoZJU7cCAFZl7UOsX3lAB4fO+ZHuAF1l0GuJOyUHeIg/ly7fvJdoF
         ib4w==
X-Gm-Message-State: APjAAAU7V0/5yozRUdUPuM2a7IOBAevzEaSIq12M/wNbKTEr6UGUEM9F
        A/m7dLrh7m9KTttv6HQTsWpjU/U72nD/Uyu3/ZqY
X-Google-Smtp-Source: APXvYqzbvmdRj73nXyO8buikoCIq8+kOxj41t7YwSIxjw8/CoklrW1ljkpZGIzMWoqnG08rXnoha4EIQCGx7HfE6vRU=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr11107177ljj.191.1580641651453;
 Sun, 02 Feb 2020 03:07:31 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
 <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com> <20200202092255.GA72728@gmail.com>
In-Reply-To: <20200202092255.GA72728@gmail.com>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Sun, 2 Feb 2020 12:07:20 +0100
Message-ID: <CADDKRnAo9B=+cNO-_VbH4yADVsQqaTb61ithqxohYCwgAm6pvg@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 2. Feb. 2020 um 10:22 Uhr schrieb Ingo Molnar <mingo@kernel.org>:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > Hello J=C3=B6rg,
> >
> > Could you please try whether the change below fixes the issue?
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 59f7f6d60cf6..ae923ee8e2b4 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
> >                         .phys_map =3D efi.memmap.phys_map,
> >                         .desc_version =3D efi.memmap.desc_version,
> >                         .desc_size =3D efi.memmap.desc_size,
> > -                       .size =3D data.desc_size * (efi.memmap.nr_map -=
 n_removal),
> > +                       .size =3D efi.memmap.desc_size * (efi.memmap.nr=
_map - n_removal),
> >                         .flags =3D 0,
>
> Oh, I actually noticed this one, but convinced myself that it's correct,
> because GCC didn't warn about uninitialized data.
>
> But maybe in this weird case data.desc_size as used within its own
> initializer is zero?
>
Patch makes my kernel booting again :)

Thanks, J=C3=B6rg
