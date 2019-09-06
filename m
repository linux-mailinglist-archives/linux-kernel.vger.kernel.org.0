Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2DABFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404573AbfIFS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 14:59:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36292 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731167AbfIFS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:59:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id f2so876326edw.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwKD9I42ZtA96hgrie0rs48E8TDE1pPljCC5j67dnFc=;
        b=cjahhPAxgQ3uf4c0lcqljjWP+o4tL5671zeaGZyLsTDBQqUJLkQ5xpNUojAQT9tqU9
         fXX6mtwPWiaMO0xmp/OIRZSB+iSSWXJMTQDVBcTu7Ju2Ikv7WXbUwxXjhCWDdxP7AszO
         GNQ8A0mblqiM9dh/0NDpkaRjtjjKsDF8Sq5CeF1ADqSUcf1afZHBCgr5sGrD+uloth6D
         0q1haUbqHqrMtGO9de13vTSKriRJlAZpDBj6I86jlKEpbnsmUuSoGzZzm6b2jxH5Zr03
         1+qZnC4wNd9YaMOZsosItFMtYNV4v/C07v/Dh+162s0z73aoZmGUD+hKHcaXLwst5WRA
         OXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwKD9I42ZtA96hgrie0rs48E8TDE1pPljCC5j67dnFc=;
        b=mDjVT6ZH3e8s6lBSPlz0y6i9/J/ea+hpNxgkOavVWRSoiCn9hdNFhouyHUUZT8czGU
         1P4k05BW7enH0j+7l5/3FL7fYOnQnghUEsuzFuMrVISiwwQfGbn5WmGFZoZG6Qd5xT+y
         yifiH7XQoBJCLgLalL7ipVIINIxkgDEJyqukoAH37L9R3JxnIVwRkQ3kyFJNixTom6Xl
         S4kU7eTxFdcD7lWqlqzspy5ibCQKOTuvm5YmHytvUcFtKWDCmXYvYPDcqZb1EXLTF1c4
         0dcHMw9oA3SjxrmXpFxZn5DvVWFulCOoNDENQxmhZiS+Iq5Ndy6MzJ3Ubs+aNcsQxczF
         kyOg==
X-Gm-Message-State: APjAAAVPWPgTxMr2kzHV5z1Pus6cRJHhLHPpD2MEEFLauHvhD8dLYGx1
        NTOjaZPM4oCZ/OFxagQSYHKQFX8rhSE71Kz92eythw==
X-Google-Smtp-Source: APXvYqxMyXLPSjPAzIzbl0yYGZXRB20981qusOmB0URaMAGLn+h3GLDQUemZlEGikEUV8qVhpzZanYxRNFgAxg534yg=
X-Received: by 2002:a50:9ea1:: with SMTP id a30mr11517823edf.304.1567796350173;
 Fri, 06 Sep 2019 11:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-9-pasha.tatashin@soleen.com> <62fc9ed9-1740-d40b-bc72-6d1911ef1f24@arm.com>
In-Reply-To: <62fc9ed9-1740-d40b-bc72-6d1911ef1f24@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 14:58:59 -0400
Message-ID: <CA+CK2bAPA=L+KeWve=2PbNEh+B9mXRzTGr1iQqRCkOAs5dU-Qg@mail.gmail.com>
Subject: Re: [PATCH v3 08/17] arm64, trans_pgd: make trans_pgd_map_page generic
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

On Fri, Sep 6, 2019 at 11:20 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Currently, trans_pgd_map_page has assumptions that are relevant to
> > hibernate. But, to make it generic we must allow it to use any allocator
>
> Sounds familiar: you removed this in patch 2.

Yes, will fix it. Thank  you.

>
>
> > and also, can't assume that entries do not exist in the page table
> > already.
>
> This thing creates a set of page tables to map one page: the relocation code.
> This is mapped in TTBR0_EL1.
> It can assume existing entries do not exist, because it creates the single-entry levels as
> it goes. Kexec also needs to map precisely one page for relocation. You don't need to
> generalise this.
>
> 'trans_pgd_create_copy()' is what creates a copy the linear map. This is mapped in TTBR1_EL1.
>
> There is no reason for kexec to behave differently here.

This is again left over from earlier version where I had a flag for
this assumption. But later redesigned kexec to never have conflicting
mapptings.
I will fix this commit log.

>
>
> > Also, we can't use init_mm here.
>
> Why not? arm64's pgd_populate() doesn't use the mm. It's only there to make it obvious
> this is an EL1 mapping we are creating. We use the kernel-asid with the new mapping.

I understand, and we can use "mm" pointer here, but the problem of
doing so in trans_pdg_* is that it makes the design look ugly. We are
creating page tables for context that runs "mm" because it is between
kernels when everything is overwritten. Yet, relying on "mm" to create
these page tables is odd.

>
> The __ version is a lot less readable.

The only __version of macros I am using is for "populate" calls: for
example, __pmd_populate  instead of pmd_populate etc. I will use non
'__' variants with NULL argument instead of mm.

> Please don't use the page tables as an array: this is what the offset helpers are for.

Sure, I can use:

pte_offset_kernel()
pmd_offset()
pud_offset()
pgd_offset_raw()

The code becomes a little less efficient, because offsets return
pointer to the entry after READ_ONCE, and we need to use another
READ_ONCE() to read its content to parse its value in for example
pud_table(), pud_none() etc . In my case we use READ_ONCE() only one
time  per entry and operate on the content multiple times. Also,
because of unfortunate differences in macro names, the code become a
little less symmetric. Still, I can change the code to use _offsets
here. Please let me know if you still think it is better to use them
here.

>
>
> > Also, add "flags" for trans_pgd_info, they are going to be used
> > in copy functions once they are generalized.
>
> You don't need to 'generalize' this to support hypothetical users.
> There are only two: hibernate and kexec, both of which are very specialised. Making these
> things top-level marionette strings will tangle the logic.

Will do that (see reply below)

>
> The copy_p?d() functions should decide if they should manipulate _this_ entry based on
> _this_ entry and the kernel configuration. This is only really done in _copy_pte(), which
> is where it should stay.

I am sorry, I do not understand this comment. Could you please
elaborate what would you like me to change.

>
>
> > diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> > index c7b5402b7d87..e3d022b1b526 100644
> > --- a/arch/arm64/include/asm/trans_pgd.h
> > +++ b/arch/arm64/include/asm/trans_pgd.h
> > @@ -11,10 +11,45 @@
> >  #include <linux/bits.h>
> >  #include <asm/pgtable-types.h>
> >
> > +/*
> > + * trans_alloc_page
> > + *   - Allocator that should return exactly one uninitilaized page, if this
> > + *    allocator fails, trans_pgd returns -ENOMEM error.
> > + *
> > + * trans_alloc_arg
> > + *   - Passed to trans_alloc_page as an argument
>
> This is very familiar.

Sorry, What do you mean?

>
>
> > + * trans_flags
> > + *   - bitmap with flags that control how page table is filled.
> > + *     TRANS_MKWRITE: during page table copy make PTE, PME, and PUD page
> > + *                    writeable by removing RDONLY flag from PTE.
>
> Why would you ever keep the read-only flags in a set of page tables that exist to let you
> overwrite memory?

It meant to take care of this comment, and keep it in hibernate specific code:
329                 /*
330                  * Resume will overwrite areas that may be marked read only
331                  * (code, rodata). Clear the RDONLY bit from the temporary
332                  * mappings we use during restore.
333                  */
334                 .trans_flags            = TRANS_MKWRITE,
335         };

But, sure, this makes sense I will remove this flag, and will do
RDONLY unconditionally.

I re-evaluated "flags", and figured that they are indeed not needed.
So, I will embed them into the code directly.

>
>
> > + *     TRANS_MKVALID: during page table copy, if PTE present, but not valid,
> > + *                    make it valid.
>
> Please keep this logic together with the !pte_none(pte) and debug_pagealloc_enabled()
> check, where it is today.
>
> Making an entry valid without those checks should never be necessary.

Yes, will do that.

>
>
> > + *     TRANS_CHECKPFN: During page table copy, for every PTE entry check that
> > + *                     PFN that this PTE points to is valid. Otherwise return
> > + *                     -ENXIO
>
> Hibernate does this when inventing a new mapping. This is how we check the kernel
> should be able to read/write this page. If !pfn_valid(), the page should not be mapped.
>
> Why do you need to turn this off?
>
> It us only necessary at the leaf level, and only if debug-pagealloc is in use. Please keep
> all these bits together, as its much harder to understand why this entry needs inventing
> when its split up like this.
>
>
>

> > diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> > index 00b62d8640c2..dbabccd78cc4 100644
> > --- a/arch/arm64/mm/trans_pgd.c
> > +++ b/arch/arm64/mm/trans_pgd.c
> > @@ -17,6 +17,16 @@
> >  #include <asm/pgtable.h>
> >  #include <linux/suspend.h>
> >
> > +static void *trans_alloc(struct trans_pgd_info *info)
> > +{
> > +     void *page = info->trans_alloc_page(info->trans_alloc_arg);
> > +
> > +     if (page)
> > +             clear_page(page);
>
> The hibernate allocator already does this. As your reason for doing this is to make this
> faster, it seems odd we do this twice.
>
> If zeroed pages are necessary, the allocator should do it. (It already needs to be a
> use-case specific allocator)

Makes sense, I will change the requirement for allocator to return
zeroed memory.

>
>
> > +
> > +     return page;
> > +}
> > +
> >  static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
> >  {
> >       pte_t pte = READ_ONCE(*src_ptep);
> > @@ -172,40 +182,64 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> >       return rc;
> >  }
> >
> > -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> > -                    pgprot_t pgprot)
> > +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> > +                    void *page, unsigned long dst_addr, pgprot_t pgprot)
> >  {
> > -     pgd_t *pgdp;
> > -     pud_t *pudp;
> > -     pmd_t *pmdp;
> > -     pte_t *ptep;
> > -
> > -     pgdp = pgd_offset_raw(trans_pgd, dst_addr);
> > -     if (pgd_none(READ_ONCE(*pgdp))) {
> > -             pudp = (void *)get_safe_page(GFP_ATOMIC);
> > -             if (!pudp)
> > +     int pgd_idx = pgd_index(dst_addr);
> > +     int pud_idx = pud_index(dst_addr);
> > +     int pmd_idx = pmd_index(dst_addr);
> > +     int pte_idx = pte_index(dst_addr);
>
> Yuck.
>

What's wrong with pre-calculating indices? :)

>
>
> > +     pgd_t *pgdp = trans_pgd;
> > +     pgd_t pgd = READ_ONCE(pgdp[pgd_idx]);
> > +     pud_t *pudp, pud;
> > +     pmd_t *pmdp, pmd;
> > +     pte_t *ptep, pte;
> > +
> > +     if (pgd_none(pgd)) {
> > +             pud_t *t = trans_alloc(info);
> > +
> > +             if (!t)
> >                       return -ENOMEM;
>
> > -             pgd_populate(&init_mm, pgdp, pudp);
> > +
> > +             __pgd_populate(&pgdp[pgd_idx], __pa(t), PUD_TYPE_TABLE);
> > +             pgd = READ_ONCE(pgdp[pgd_idx]);
>
>
> Please keep the pgd_populate() call. If there is some reason we can't pass init_mm, we can
> pass NULL, or a fake mm pointer instead.\\

Hm, we could use NULL instead of "mm", I will do that, thanks.

>
> Going behind the page table helpers back to play with the table directly is a maintenance
> headache.
>
>
> >       }
> >
>
>
> > -     pudp = pud_offset(pgdp, dst_addr);
> > -     if (pud_none(READ_ONCE(*pudp))) {
> > -             pmdp = (void *)get_safe_page(GFP_ATOMIC);
> > -             if (!pmdp)
> > +     pudp = __va(pgd_page_paddr(pgd));
> > +     pud = READ_ONCE(pudp[pud_idx]);
> > +     if (pud_sect(pud)) {
> > +             return -ENXIO;
> > +     } else if (pud_none(pud) || pud_sect(pud)) {
> > +             pmd_t *t = trans_alloc(info);
> > +
> > +             if (!t)
> >                       return -ENOMEM;
>
> Choke on block mappings? This should never happen because this function should only create
> the tables necessary to map one page. Not a block mapping in sight.
>
> (see my comments on patch 6)

I can remove this, but what should I replace it with BUG() or silently
ignore, and assume no huge page hre? I thought the idea is not to use
BUG() calls in kernel code, and return errors instead. If, in the
future PUD size mappings are added, how is that going to be detected?

Thank you,
Pasha
