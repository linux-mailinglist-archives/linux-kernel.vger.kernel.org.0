Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EEABD2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395009AbfIFQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:00:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33415 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfIFQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:00:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id o9so6793782edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiD1TwL/Id//xaqpbzs1lfvzt5WvDuUNyjDuGVpOVM8=;
        b=DrtnmIYB0GfZaFo92tmzBcMPxFlqSxYyiLcJ2k29wb15hQ6tGomjNtco6mkGB1/KM2
         x/qlHJWajTbuieX2M+cfvfX55UTgvqs1Uqqdh/zAUvCkhd3+Fcz1NJg3UBYg5aeOo9Tm
         vVJfvpmco/i+W9Z/4qD1zlzKasNjrKFO5/Ho1uvF8kOY5UK6dhzqHE4cS7+V1M0dangv
         rVAfV2UegDXDzUcSB0oZhMswVkxyoHUZWqiANMarBjI4GS1rtAQUam4bqNJQTNMexDIb
         nU3dVhU/T2yurplUf7I30QZKtvs1WwsfVbJb7FR+dt4/8O55yYG2FkuRDk873NvXmwza
         NtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiD1TwL/Id//xaqpbzs1lfvzt5WvDuUNyjDuGVpOVM8=;
        b=G++vUD5/9v2XxywqSJ7JKVpOwxxrTxVPtYsUWbBgG53RwbK4GZLqGX4S3BSU25FdmK
         bvdzlX9jQs5c+GfZTnW7bJpsLI2uMjGtYr9sEEOd4ylFwlODfoCHSF34jeX/Al1mwA4o
         WhMEeswKZSMqfz1NlSco74ckNFfqcKUKxSIr2y8qG/y90uO360fobu9gg5YeE/kY4OAP
         O2oBVV+dLIoHPYs53q97E96bsP/gz0l0P4U6StcBrzWcrt7+ely8z+mD7r4dwK6/Rpxb
         eC1UPJsWg1LjzHD2tqIC9482+1127CQ6sVfVfirON85C9kGWc3vivLKkabBkOqsN2MpO
         /N3A==
X-Gm-Message-State: APjAAAUNjnYAE36GHux/5U/TRDQ3E2GJtc8MgvMexm6J1ekJUvrr5F4Z
        hVVp7Eur6EWXQ7ujzsxpb5KvlnsEbeyxch/G6390aQ==
X-Google-Smtp-Source: APXvYqy09fzh96BWcQzuCXWwESDoCG5MbuNp+4Sq/95dcElSvTDxaCmjYIch+D1tDPc4Btkhhy46Glw06rUTj79kprY=
X-Received: by 2002:aa7:c40c:: with SMTP id j12mr10481211edq.80.1567785630260;
 Fri, 06 Sep 2019 09:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-7-pasha.tatashin@soleen.com> <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
In-Reply-To: <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 12:00:19 -0400
Message-ID: <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > trans_pgd_create_copy() and trans_pgd_map_page() are going to be
> > the basis for public interface of new subsystem that handles page
>
> Please don't call this a subsystem. 'sound' and 'mm' are subsystems, this is just some
> shared code.

Sounds good: just could not find a better term to call trans_pgd_*. I
won't fix log commits.

>
> > tables for cases which are between kernels: kexec, and hibernate.
>
> Even though you've baked the get_safe_page() calls into trans_pgd_map_page()?

It is getting removed later. Just for a cleaner migration to new
place, get_safe_page() is included for now.

>
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 750ecc7f2cbe..2e29d620b56c 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>
> > +int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
> > +                    unsigned long dst_addr,
> > +                    pgprot_t pgprot)
>
> If this thing is going to be exposed, its name should reflect that its creating a set of
> page tables, to map a single page.
>
> A function called 'map_page' with this prototype should 'obviously' map @page at @dst_addr
> in @trans_pgd using the provided @pgprot... but it doesn't.

Answered below...

>
> This is what 'create' was doing in the old name, if that wasn't obvious, its because
> naming things is hard!
> | trans_create_single_page_mapping()?
>
> (might be too verbose)
>
> I think this bites you in patch 8, where you 'generalise' this.

The new naming makes more sense to me. The old code had function named:

create_safe_exec_page()

It was doing four things: 1. creating the actual page via provided
allocator, 2. copying content from the provided page to new page, 3
creating a new page table. 4 mapping it to a new page table at
specified destination address

After, I generalize this the function the prototype looks like this:

int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
                                         void *page, unsigned long
dst_addr, pgprot_t pgprot)

The function only does the "4" from the old code: map the specified
page at dst_addr. The trans_pgd is already created. Of course, and
mapping function will have to allocate missing tables in the page
tables when necessary.

> > +     return 0;
> > +}
> > +
> > +/*
> > + * Copies length bytes, starting at src_start into an new page,
> > + * perform cache maintentance, then maps it at the specified address low
>
> Could you fix the spelling of maintenance as git thinks you've moved it?

I will.

Thank you,
Pasha
