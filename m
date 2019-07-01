Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6242874
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfFLOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 10:10:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40424 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFLOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:10:24 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so10747819itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjjCY66dcOIAwrppTn005I91OQxD4XKkvl7VcngFu58=;
        b=I3ynIIRBv5j5ZxLm6Hqet1vceV8wypAGaB8rtd67Z5X6g7XSzeyxDtbDjNYBNQbrty
         QO6uqDL6Ky6815R1wmss1Zf5VrRG2LlKo09gByaxBfHksUxMp2sLoEtMnAu75o55jwlA
         U4XOwtKYBolu3JHXGhPf5ByqHf/VC0ey2DzFcdKqyM4M8e5EC/dBn/ISqCWeTBPBaG68
         1OwD5DAF9HKkUI1nqAVEx116koyduNaAoXMYby8ywZQyq1FSDGWnQEfS/Bx4A8KscvlN
         iu0wZzQDEV4Z7mdR/PQOdJbgTNEovvcwZZKNn75TphH24AtaJn1GTT1DN/8MxEDz1Ghl
         W9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjjCY66dcOIAwrppTn005I91OQxD4XKkvl7VcngFu58=;
        b=ALuZziPF+md1l70ZSofXu12CkuFVao9bS7YV3OeVDNTHLOHTf2mQPYVZQr3JWx8mZf
         GqDWzPdSTLsjbji6FGdAkNTYVpRb9xW8+4fdP46yOuGkBtZXMM1Zih2amRHH7NPqA/oE
         sR45DPPIeKbzPjhCHTh10DQxa3GIopXlZRWMunA9oCXfHW9wkgUtCxE3Y8IkmqwmDohL
         pIRXxiYp6IguAlBKTpQFW87va7BAuogkDqgE62P9A2tIboLOsN0EJhpcPluqrFbLepZw
         9wa2VLhvi4PDqzF539zbgEkWj42/EtXw6omDk9D3jR76+Jr+7/ryRJ3MeZ+omF//b0l5
         yrjA==
X-Gm-Message-State: APjAAAXm1EInn9WQGj8ekhd9hMWepoMzA2PBtUZEL91LTEIlnZ+7g9QO
        PK+0BmPjsBNlzX5ptdd9lLQqa4sOoOgZqdqWfw==
X-Google-Smtp-Source: APXvYqzMwFcv3c1X1V0OlC6XalQIW3p0WyYba8hSLfuOZEqphjN7uIuOSEZtG6jMIfuZHq+8o8ICtv02BKLo7CTzi0E=
X-Received: by 2002:a24:7cd8:: with SMTP id a207mr22042016itd.68.1560348623628;
 Wed, 12 Jun 2019 07:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
 <CAFgQCTur5ReVHm6NHdbD3wWM5WOiAzhfEXdLnBGRdZtf7q1HFw@mail.gmail.com>
 <2b0a65ec-4fb0-430e-3e6a-b713fb5bb28f@nvidia.com> <CAFgQCTtS7qOByXBnGzCW-Rm9fiNsVmhQTgqmNU920m77XyAwZQ@mail.gmail.com>
 <20190611122935.GA9919@dhcp-128-55.nay.redhat.com> <20190611164733.GA14336@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190611164733.GA14336@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 12 Jun 2019 22:10:12 +0800
Message-ID: <CAFgQCTvaoOgzkei6vSNUAfs2D0un3ypuoEM02C9gWB7SnNy5Gw@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:46 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, Jun 11, 2019 at 08:29:35PM +0800, Pingfan Liu wrote:
> > On Fri, Jun 07, 2019 at 02:10:15PM +0800, Pingfan Liu wrote:
> > > On Fri, Jun 7, 2019 at 5:17 AM John Hubbard <jhubbard@nvidia.com> wrote:
> > > >
> > > > On 6/5/19 7:19 PM, Pingfan Liu wrote:
> > > > > On Thu, Jun 6, 2019 at 5:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > ...
> > > > >>> --- a/mm/gup.c
> > > > >>> +++ b/mm/gup.c
> > > > >>> @@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> > > > >>>       return ret;
> > > > >>>  }
> > > > >>>
> > > > >>> +#ifdef CONFIG_CMA
> > > > >>> +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> > > > >>> +{
> > > > >>> +     int i;
> > > > >>> +
> > > > >>> +     for (i = 0; i < nr_pinned; i++)
> > > > >>> +             if (is_migrate_cma_page(pages[i])) {
> > > > >>> +                     put_user_pages(pages + i, nr_pinned - i);
> > > > >>> +                     return i;
> > > > >>> +             }
> > > > >>> +
> > > > >>> +     return nr_pinned;
> > > > >>> +}
> > > > >>
> > > > >> There's no point in inlining this.
> > > > > OK, will drop it in V4.
> > > > >
> > > > >>
> > > > >> The code seems inefficient.  If it encounters a single CMA page it can
> > > > >> end up discarding a possibly significant number of non-CMA pages.  I
> > > > > The trick is the page is not be discarded, in fact, they are still be
> > > > > referrenced by pte. We just leave the slow path to pick up the non-CMA
> > > > > pages again.
> > > > >
> > > > >> guess that doesn't matter much, as get_user_pages(FOLL_LONGTERM) is
> > > > >> rare.  But could we avoid this (and the second pass across pages[]) by
> > > > >> checking for a CMA page within gup_pte_range()?
> > > > > It will spread the same logic to hugetlb pte and normal pte. And no
> > > > > improvement in performance due to slow path. So I think maybe it is
> > > > > not worth.
> > > > >
> > > > >>
> > > >
> > > > I think the concern is: for the successful gup_fast case with no CMA
> > > > pages, this patch is adding another complete loop through all the
> > > > pages. In the fast case.
> > > >
> > > > If the check were instead done as part of the gup_pte_range(), then
> > > > it would be a little more efficient for that case.
> > > >
> > > > As for whether it's worth it, *probably* this is too small an effect to measure.
> > > > But in order to attempt a measurement: running fio (https://github.com/axboe/fio)
> > > > with O_DIRECT on an NVMe drive, might shed some light. Here's an fio.conf file
> > > > that Jan Kara and Tom Talpey helped me come up with, for related testing:
> > > >
> > > > [reader]
> > > > direct=1
> > > > ioengine=libaio
> > > > blocksize=4096
> > > > size=1g
> > > > numjobs=1
> > > > rw=read
> > > > iodepth=64
> > > >
> > Unable to get a NVME device to have a test. And when testing fio on the
> > tranditional disk, I got the error "fio: engine libaio not loadable
> > fio: failed to load engine
> > fio: file:ioengines.c:89, func=dlopen, error=libaio: cannot open shared object file: No such file or directory"
> >
> > But I found a test case which can be slightly adjusted to met the aim.
> > It is tools/testing/selftests/vm/gup_benchmark.c
> >
> > Test enviroment:
> >   MemTotal:       264079324 kB
> >   MemFree:        262306788 kB
> >   CmaTotal:              0 kB
> >   CmaFree:               0 kB
> >   on AMD EPYC 7601
> >
> > Test command:
> >   gup_benchmark -r 100 -n 64
> >   gup_benchmark -r 100 -n 64 -l
> > where -r stands for repeat times, -n is nr_pages param for
> > get_user_pages_fast(), -l is a new option to test FOLL_LONGTERM in fast
> > path, see a patch at the tail.
>
> Thanks!  That is a good test to add.  You should add the patch to the series.
OK.
>
> >
> > Test result:
> > w/o     477.800000
> > w/o-l   481.070000
> > a       481.800000
> > a-l     640.410000
> > b       466.240000  (question a: b outperforms w/o ?)
> > b-l     529.740000
> >
> > Where w/o is baseline without any patch using v5.2-rc2, a is this series, b
> > does the check in gup_pte_range(). '-l' means FOLL_LONGTERM.
> >
> > I am suprised that b-l has about 17% improvement than a. (640.41 -529.74)/640.41
>
> Wow that is bigger than I would have thought.  I suspect it gets worse as -n
> increases?
Yes. I test with -n 64/128/256/512. It has this trend. See the data below.

>
> >
> > As for "question a: b outperforms w/o ?", I can not figure out why, maybe it can be
> > considered as variance.
>
> :-/
>
> Does this change with larger -r or -n values?
-r should have no effect on this. And I change -n 64/128/256/512. The
data always shows b outperforms w/o a bit.

      64        128         256        512
a-l  633.23   676.83  747.14  683.19    (n=256 should be disturbed by
something, but the overall trend keeps going up)
b-l  528.32   529.10  523.95  512.88
w/o  479.73   473.87  477.67  488.70
b    470.13   467.11  463.06  469.62

Thanks,
  Pingfan
>
> >
> > Based on the above result, I think it is better to do the check inside
> > gup_pte_range().
> >
> > Any comment?
>
> I agree.
>
> Ira
>
> >
> > Thanks,
> >
> >
> > > Yeah, agreed. Data is more persuasive. Thanks for your suggestion. I
> > > will try to bring out the result.
> > >
> > > Thanks,
> > >   Pingfan
> > >
> >
>
> > ---
> > Patch to do check inside gup_pte_range()
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 2ce3091..ba213a0 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1757,6 +1757,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >               VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
> >               page = pte_page(pte);
> >
> > +             if (unlikely(flags & FOLL_LONGTERM) &&
> > +                     is_migrate_cma_page(page))
> > +                             goto pte_unmap;
> > +
> >               head = try_get_compound_head(page, 1);
> >               if (!head)
> >                       goto pte_unmap;
> > @@ -1900,6 +1904,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> >               refs++;
> >       } while (addr += PAGE_SIZE, addr != end);
> >
> > +     if (unlikely(flags & FOLL_LONGTERM) &&
> > +             is_migrate_cma_page(page)) {
> > +             *nr -= refs;
> > +             return 0;
> > +     }
> > +
> >       head = try_get_compound_head(pmd_page(orig), refs);
> >       if (!head) {
> >               *nr -= refs;
> > @@ -1941,6 +1951,12 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> >               refs++;
> >       } while (addr += PAGE_SIZE, addr != end);
> >
> > +     if (unlikely(flags & FOLL_LONGTERM) &&
> > +             is_migrate_cma_page(page)) {
> > +             *nr -= refs;
> > +             return 0;
> > +     }
> > +
> >       head = try_get_compound_head(pud_page(orig), refs);
> >       if (!head) {
> >               *nr -= refs;
> > @@ -1978,6 +1994,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
> >               refs++;
> >       } while (addr += PAGE_SIZE, addr != end);
> >
> > +     if (unlikely(flags & FOLL_LONGTERM) &&
> > +             is_migrate_cma_page(page)) {
> > +             *nr -= refs;
> > +             return 0;
> > +     }
> > +
> >       head = try_get_compound_head(pgd_page(orig), refs);
> >       if (!head) {
> >               *nr -= refs;
>
> > ---
> > Patch for testing
> >
> > diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> > index 7dd602d..61dec5f 100644
> > --- a/mm/gup_benchmark.c
> > +++ b/mm/gup_benchmark.c
> > @@ -6,8 +6,9 @@
> >  #include <linux/debugfs.h>
> >
> >  #define GUP_FAST_BENCHMARK   _IOWR('g', 1, struct gup_benchmark)
> > -#define GUP_LONGTERM_BENCHMARK       _IOWR('g', 2, struct gup_benchmark)
> > -#define GUP_BENCHMARK                _IOWR('g', 3, struct gup_benchmark)
> > +#define GUP_FAST_LONGTERM_BENCHMARK  _IOWR('g', 2, struct gup_benchmark)
> > +#define GUP_LONGTERM_BENCHMARK       _IOWR('g', 3, struct gup_benchmark)
> > +#define GUP_BENCHMARK                _IOWR('g', 4, struct gup_benchmark)
> >
> >  struct gup_benchmark {
> >       __u64 get_delta_usec;
> > @@ -53,6 +54,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
> >                       nr = get_user_pages_fast(addr, nr, gup->flags & 1,
> >                                                pages + i);
> >                       break;
> > +             case GUP_FAST_LONGTERM_BENCHMARK:
> > +                     nr = get_user_pages_fast(addr, nr,
> > +                                              (gup->flags & 1) | FOLL_LONGTERM,
> > +                                              pages + i);
> > +                     break;
> >               case GUP_LONGTERM_BENCHMARK:
> >                       nr = get_user_pages(addr, nr,
> >                                           (gup->flags & 1) | FOLL_LONGTERM,
> > @@ -96,6 +102,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
> >
> >       switch (cmd) {
> >       case GUP_FAST_BENCHMARK:
> > +     case GUP_FAST_LONGTERM_BENCHMARK:
> >       case GUP_LONGTERM_BENCHMARK:
> >       case GUP_BENCHMARK:
> >               break;
> > diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> > index c0534e2..ade8acb 100644
> > --- a/tools/testing/selftests/vm/gup_benchmark.c
> > +++ b/tools/testing/selftests/vm/gup_benchmark.c
> > @@ -15,8 +15,9 @@
> >  #define PAGE_SIZE sysconf(_SC_PAGESIZE)
> >
> >  #define GUP_FAST_BENCHMARK   _IOWR('g', 1, struct gup_benchmark)
> > -#define GUP_LONGTERM_BENCHMARK       _IOWR('g', 2, struct gup_benchmark)
> > -#define GUP_BENCHMARK                _IOWR('g', 3, struct gup_benchmark)
> > +#define GUP_FAST_LONGTERM_BENCHMARK  _IOWR('g', 2, struct gup_benchmark)
> > +#define GUP_LONGTERM_BENCHMARK       _IOWR('g', 3, struct gup_benchmark)
> > +#define GUP_BENCHMARK                _IOWR('g', 4, struct gup_benchmark)
> >
> >  struct gup_benchmark {
> >       __u64 get_delta_usec;
> > @@ -37,7 +38,7 @@ int main(int argc, char **argv)
> >       char *file = "/dev/zero";
> >       char *p;
> >
> > -     while ((opt = getopt(argc, argv, "m:r:n:f:tTLUSH")) != -1) {
> > +     while ((opt = getopt(argc, argv, "m:r:n:f:tTlLUSH")) != -1) {
> >               switch (opt) {
> >               case 'm':
> >                       size = atoi(optarg) * MB;
> > @@ -54,6 +55,9 @@ int main(int argc, char **argv)
> >               case 'T':
> >                       thp = 0;
> >                       break;
> > +             case 'l':
> > +                     cmd = GUP_FAST_LONGTERM_BENCHMARK;
> > +                     break;
> >               case 'L':
> >                       cmd = GUP_LONGTERM_BENCHMARK;
> >                       break;
> > --
> > 2.7.5
> >
>
