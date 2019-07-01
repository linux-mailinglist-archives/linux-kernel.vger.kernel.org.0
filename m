Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037B228F58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbfEXC7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 22:59:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35605 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfEXC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:59:47 -0400
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1hU0Qq-0003q2-6p
        for linux-kernel@vger.kernel.org; Fri, 24 May 2019 02:59:44 +0000
Received: by mail-oi1-f200.google.com with SMTP id a196so3139293oii.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVTkfCXi8Qvdl5BtPJlX4LlWKBE6YTyiV+OTd3AKz3c=;
        b=LYg96kS27druHY9HC9nUxjb7grQcv2MSASv7rropCkvxLVBV5L7iE5RfSo7k83tKPz
         CBgMghgUPUeHysSh8UWWnRR/R+jLDeVeCXrrSFzQUu5W8sr5RC8nAO0euzbe/1Sx9Prj
         J6UTpgwZiakFFSlN2XDFuT0ufj4VwVFa5xPt7KQP5aWeaeGZ1hQaAcD9XFoJu1GvvTvM
         V5SwPGxPTMcHfYbBGG7uwlF25gp74OlmVT4i/3keWDzqa2PVSZtX4D0OBzoUYFK6qd0D
         2aaJkD0zaPwIyECAantaOjkurJQ/vNY8qp8w+jz6OIe5TNTIuLQ9N1MVY9OmL+5keK5j
         NhZA==
X-Gm-Message-State: APjAAAW0uCEtR5Y/pn5v/vd2s06LoT82n+TP/4Tf/+b/NPJNSXC+u0R2
        dzV/px2+mESWmSVC06yC4NRgJcC4brRFgkYz50Gby3ZuI8dO1BvRebahLllXNHyNQEBDlwWk5Au
        y72B9hTxd0p7qrGtbcyrgAYBcfaqnfL8YNfhTjZI/ycSI3SioD7UihlHTDA==
X-Received: by 2002:a9d:7c85:: with SMTP id q5mr23318121otn.31.1558666781897;
        Thu, 23 May 2019 19:59:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYCS/jIPuxtRQmoQl/5N5w/PRITbInIGx1pTjVVqdV4vaiAMsKDZGjjfDVIPuB372BRT8qS0RUcYiTUiZKg3Y=
X-Received: by 2002:a9d:7c85:: with SMTP id q5mr23318098otn.31.1558666781507;
 Thu, 23 May 2019 19:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-2-nicoleotsuka@gmail.com>
 <CALdTtnurdNe4+oJjSJfWw1ONf8-xvJ8KhonQkJNj+4LDZT7jAQ@mail.gmail.com>
In-Reply-To: <CALdTtnurdNe4+oJjSJfWw1ONf8-xvJ8KhonQkJNj+4LDZT7jAQ@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Thu, 23 May 2019 20:59:30 -0600
Message-ID: <CALdTtnuwRKkna_y5_5BdEYWNRbOQnLvtfz1PY-d4r78tj5hgVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dma-contiguous: Abstract dma_{alloc, free}_contiguous()
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, chris@zankel.net,
        linux-xtensa@linux-xtensa.org, keescook@chromium.org,
        sfr@canb.auug.org.au, tony@atomide.com,
        Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
        akpm@linux-foundation.org, treding@nvidia.com, dwmw2@infradead.org,
        iamjoonsoo.kim@lge.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 7:52 PM dann frazier <dann.frazier@canonical.com> wrote:
>
> On Mon, May 6, 2019 at 4:35 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > Both dma_alloc_from_contiguous() and dma_release_from_contiguous()
> > are very simply implemented, but requiring callers to pass certain
> > parameters like count and align, and taking a boolean parameter to
> > check __GFP_NOWARN in the allocation flags. So every function call
> > duplicates similar work:
> >   /* A piece of example */
> >   unsigned long order = get_order(size);
> >   size_t count = size >> PAGE_SHIFT;
> >   page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> >   [...]
> >   dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
> >
> > Additionally, as CMA can be used only in the context which permits
> > sleeping, most of callers do a gfpflags_allow_blocking() check and
> > a corresponding fallback allocation of normal pages upon any false
> > result:
> >   /* A piece of example */
> >   if (gfpflags_allow_blocking(flag))
> >       page = dma_alloc_from_contiguous();
> >   if (!page)
> >       page = alloc_pages();
> >   [...]
> >   if (!dma_release_from_contiguous(dev, page, count))
> >       __free_pages(page, get_order(size));
> >
> > So this patch simplifies those function calls by abstracting these
> > operations into the two new functions: dma_{alloc,free}_contiguous.
> >
> > As some callers of dma_{alloc,release}_from_contiguous() might be
> > complicated, this patch just implements these two new functions to
> > kernel/dma/direct.c only as an initial step.
> >
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > Changelog
> > v1->v2:
> >  * Added new functions beside the old ones so we can replace callers
> >    one by one later.
> >  * Applied new functions to dma/direct.c only, because it's the best
> >    example caller to apply and should be safe with the new functions.
> >
> >  include/linux/dma-contiguous.h | 10 +++++++
> >  kernel/dma/contiguous.c        | 48 ++++++++++++++++++++++++++++++++++
> >  kernel/dma/direct.c            | 24 +++--------------
> >  3 files changed, 62 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> > index f247e8aa5e3d..dacbdcb91a89 100644
> > --- a/include/linux/dma-contiguous.h
> > +++ b/include/linux/dma-contiguous.h
> > @@ -115,6 +115,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> >                                        unsigned int order, bool no_warn);
> >  bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> >                                  int count);
> > +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
> > +void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
> >
> >  #else
> >
> > @@ -157,6 +159,14 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> >         return false;
> >  }
> >
> > +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline
> > +void dma_free_contiguous(struct device *dev, struct page *page, size_t size) { }
> > +
> >  #endif
> >
> >  #endif
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index b2a87905846d..21f39a6cb04f 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> >         return cma_release(dev_get_cma_area(dev), pages, count);
> >  }
>
> This breaks the build for me if CONFIG_DMA_CMA=n:
>
>   LD [M]  fs/9p/9p.o
> ld: fs/9p/vfs_inode.o: in function `dma_alloc_contiguous':
> vfs_inode.c:(.text+0xa60): multiple definition of
> `dma_alloc_contiguous'; fs/9p/vfs_super.o:vfs_super.c:(.text+0x500):
> first defined here
>
> Do the following insertions need to be under an #ifdef CONFIG_DMA_CMA ?

Ah, no - the problem is actually a missing "static inline" in the
!CONFIG_DMA_CMA version of dma_alloc_contiguous().

  -dann

> > +/**
> > + * dma_alloc_contiguous() - allocate contiguous pages
> > + * @dev:   Pointer to device for which the allocation is performed.
> > + * @size:  Requested allocation size.
> > + * @gfp:   Allocation flags.
> > + *
> > + * This function allocates contiguous memory buffer for specified device. It
> > + * first tries to use device specific contiguous memory area if available or
> > + * the default global one, then tries a fallback allocation of normal pages.
> > + */
> > +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> > +{
> > +       int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> > +       size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +       size_t align = get_order(PAGE_ALIGN(size));
> > +       struct cma *cma = dev_get_cma_area(dev);
> > +       struct page *page = NULL;
> > +
> > +       /* CMA can be used only in the context which permits sleeping */
> > +       if (cma && gfpflags_allow_blocking(gfp)) {
> > +               align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> > +               page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> > +       }
> > +
> > +       /* Fallback allocation of normal pages */
> > +       if (!page)
> > +               page = alloc_pages_node(node, gfp, align);
> > +
> > +       return page;
> > +}
> > +
> > +/**
> > + * dma_free_contiguous() - release allocated pages
> > + * @dev:   Pointer to device for which the pages were allocated.
> > + * @page:  Pointer to the allocated pages.
> > + * @size:  Size of allocated pages.
> > + *
> > + * This function releases memory allocated by dma_alloc_contiguous(). As the
> > + * cma_release returns false when provided pages do not belong to contiguous
> > + * area and true otherwise, this function then does a fallback __free_pages()
> > + * upon a false-return.
> > + */
> > +void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
> > +{
> > +       if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
> > +               __free_pages(page, get_order(size));
> > +}
> > +
> >  /*
> >   * Support for reserved memory regions defined in device tree
> >   */
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 2c2772e9702a..0816c1e8b05a 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -96,8 +96,6 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> >  struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> >                 dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >  {
> > -       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -       int page_order = get_order(size);
> >         struct page *page = NULL;
> >         u64 phys_mask;
> >
> > @@ -109,20 +107,9 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> >         gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> >                         &phys_mask);
> >  again:
> > -       /* CMA can be used only in the context which permits sleeping */
> > -       if (gfpflags_allow_blocking(gfp)) {
> > -               page = dma_alloc_from_contiguous(dev, count, page_order,
> > -                                                gfp & __GFP_NOWARN);
> > -               if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > -                       dma_release_from_contiguous(dev, page, count);
> > -                       page = NULL;
> > -               }
> > -       }
> > -       if (!page)
> > -               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
> > -
> > +       page = dma_alloc_contiguous(dev, size, gfp);
> >         if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > -               __free_pages(page, page_order);
> > +               dma_free_contiguous(dev, page, size);
> >                 page = NULL;
> >
> >                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> > @@ -154,7 +141,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
> >         if (PageHighMem(page)) {
> >                 /*
> >                  * Depending on the cma= arguments and per-arch setup
> > -                * dma_alloc_from_contiguous could return highmem pages.
> > +                * dma_alloc_contiguous could return highmem pages.
> >                  * Without remapping there is no way to return them here,
> >                  * so log an error and fail.
> >                  */
> > @@ -176,10 +163,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
> >
> >  void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
> >  {
> > -       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -
> > -       if (!dma_release_from_contiguous(dev, page, count))
> > -               __free_pages(page, get_order(size));
> > +       dma_free_contiguous(dev, page, size);
> >  }
> >
> >  void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
