Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E9B24C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfIMRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 13:54:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55927 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:54:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so3642934wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx2heiDJuyWnETVeBByw/9MqOngkNzT5wlgD9uHKh/M=;
        b=IrQxqXEYIANgLoyXJxw0WSXQ9gjH6IjJ0ACLFh6E7sMVMVe0ceAAFvSbT9UnJXtvzB
         HphZJA1a075enjLZY59sh0LSxhwklmcPv8jj5vEglQLFXa1Tuh5PxH0Vzo1kf9gXGrxm
         NEVJ5DzOO+LURHtVewU6hH+UlXaev34Jl2+2GCoZ9RpfdQhuVcH1WYGPcsZ6SelSLLDM
         wonoOAY+6zvVqQfwBYnLEqp9jEgcud+yQkAHqcSERldYHuc1d72kLZLu68AZrs3W1oBo
         CQc4iA0By+w2K/qGAnakaSj+WD/t0LkFPeRfD53e22ssEf3gUpKgQkBd5UJXVZoeeBQD
         Hy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx2heiDJuyWnETVeBByw/9MqOngkNzT5wlgD9uHKh/M=;
        b=TzStCOdPJF57BUEKMvenewBI32Gd5NSVJYTIzGmADaEK9FUiTT+FWz99ZK1V9u2BLH
         NwPcUSXvzxo+6hwTWjiSQNkMxujJoIAnv8aIyJRdMLgAMneZqvAnOyMSyJzr6XAvHPo3
         s00VuFoE9PUU00NFrxRAVEhEdQD14TfE+41n4FIvD/bGpnbx0fe4jId7niLz3bOXh5Mj
         M9g7FPWXaAxIofCvRXTjs1i0GTG/Ur4IekBVIBjcGIsznEBj1LmnYYy1dj+O8Jq6KTdR
         hpbJHjwGC+tZaEEk0dO/rLEk6mbADiurm27GB7qu9Bg2IXmw4yWCO7VswJtpw/x4Sbtb
         yVbA==
X-Gm-Message-State: APjAAAU3JsxRBnC5gNYXAeI2i8R75NopZZMDjbWYDgTY4qKHN2D69CyJ
        SNI6gaDvngXMOPc0JnLljEMeT88Fj1+W4NDmkbj4ow==
X-Google-Smtp-Source: APXvYqy73pXMfWirl0aFgQt/ZMrNnMPAkwU1c1WWXh1WEaCSb7kmzY1tJt08FEtXp6jRoxIRv0Lww4IGwrZOfS6wrvc=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr4636522wml.10.1568397274180;
 Fri, 13 Sep 2019 10:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995890.1616117.10724047366038926477.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8OOeLyuNwgG1eXM2FGDNrLvigMfR63uWwUB-Jg+WXM7A@mail.gmail.com>
 <CAPcyv4hrEsQ0t1hTT1A5WKFqYhANq15n0ru67SLDfGf1ZG-XWA@mail.gmail.com>
 <CAKv+Gu9ofzdrn8AJkXVkiWM+x8=2_ixnC68Y=Gk5KhEi0X35GA@mail.gmail.com>
 <CAPcyv4jn1UrxodWR77ut9LBGTHa45Q_98kdAhL6wdaHL9V9RsA@mail.gmail.com> <CAKv+Gu9MMt6FuW+ZuLFMMcA6ku173u4D9g66WaoEafY4i8j2TA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9MMt6FuW+ZuLFMMcA6ku173u4D9g66WaoEafY4i8j2TA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 18:54:11 +0100
Message-ID: <CAKv+Gu8fjomG_La8BjybZrOi9UcTya_7zicYXgJeMLvf4Q8nyA@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 at 18:39, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 13 Sep 2019 at 17:39, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Sep 13, 2019 at 9:29 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 13 Sep 2019 at 17:22, Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > On Fri, Sep 13, 2019 at 6:00 AM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> ...
> > > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > > > index 363bb9d00fa5..6d54d5c74347 100644
> > > > > > --- a/drivers/firmware/efi/efi.c
> > > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > > @@ -52,6 +52,9 @@ struct efi __read_mostly efi = {
> > > > > >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> > > > > >         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> > > > > >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > > > > > +#ifdef CONFIG_EFI_SOFT_RESERVE
> > > > > > +       .flags                  = 1UL << EFI_MEM_SOFT_RESERVE,
> > > > > > +#endif
> > > > > >  };
> > > > > >  EXPORT_SYMBOL(efi);
> > > > > >
> > > > >
> > > > > I'd prefer it if we could call this EFI_MEM_NO_SOFT_RESERVE instead,
> > > > > and invert the meaning of the bit.
> > > >
> > > > ...but that would mean repeat occurrences of
> > > > "!efi_enabled(EFI_MEM_NO_SOFT_RESERVE)", doesn't the double negative
> > > > seem less readable to you?
> > > >
> > >
> > > One the one hand, yes. On the other hand, it is the only flag whose
> > > default is 'enabled' which is also less than ideal.
> >
> > Ok, I can get on board with "default 0" being the non exception state
> > of the flags.
> >
>
> In fact, let's just add something like
>
> static inline bool efi_soft_reserve_enabled(void)
> {
>     return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
>            !efi_enabled(EFI_MEM_NO_SOFT_RESERVE);
> }
>
> to linux/efi.h and use that in the code?

Or even better, add just the declaration to linux.efi,h

bool __pure efi_soft_reserve_enabled(void);

and put one implementation in efi-stub-helper.c:

bool __pure efi_soft_reserve_enabled(void)
{
    return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
           !efi_nosoftreserve;
}

and the one above in drivers/firmware/efi/efi.c
