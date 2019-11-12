Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6CF9025
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 08:04:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33919 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:04:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so14701524oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qrxvDNxHoV1453Zos2MLsmWvZ/DGxuUgcPphZ/VBDA=;
        b=SPUn2TxRd03zOGx8w9VzTG3LKgkLwJt4wZ83nRrM0/K90KmBp2cWQieXnH7XzvKuiO
         AnguPJaTA66jJSCmmCCGu8Png/pr4MgD8bJRBP4Xn9d2dYcMeY58/zUohKRHVWmZV64l
         MlALVswaOE4tsCZIelxxk1wFsXPksC6y7rScU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qrxvDNxHoV1453Zos2MLsmWvZ/DGxuUgcPphZ/VBDA=;
        b=GsXXyxw6Y14IxUNHTHpG9Ul+l1MgGy4MBy7k+qSSkj/PKw/ik1yOfK7ggsn/xV+OIo
         1bxrBeS6bRWV5BbeBzOzQ/hDNIqWzS0p5sFDIY3hmB9xBIBrMJbuCeag5GzTficrGEM0
         I7A+ai4MhDu0IiSKrhdf0vSbXqLRgL0dPrOxq/Y3O+EJJ55k1dAyiVYgSQtxhneZi54a
         ceKP1zZOItTXmeHVKpmcWCGIXz8N7ellqxD6nfoWsVypPYkvtEEOO0PYcj/hx0nhZELg
         KLHb9Czi6GITYMMMPAUZGDVsBNXSeR97VVkGYhs2eAQbW+8bfiQDyTXnqhrpOjjHRXz5
         hmKw==
X-Gm-Message-State: APjAAAUpfmFlYeC76LllQEM8VWZJ/rNshsRl7ulTreC7CgYeYW0UHya1
        TGYKLJ8zcuQVux0r0YgekVLGUAPrEJ8Ajo3x8Xjj4w==
X-Google-Smtp-Source: APXvYqx1klxjiF9goBzY2ca4SxhAN0ejRZucHN1skYe/+FXLwI+4G0rvw9F32nQxW1mIivLD+5DJeueTHicqnLqPA4U=
X-Received: by 2002:aca:39d7:: with SMTP id g206mr3662651oia.101.1573563867579;
 Tue, 12 Nov 2019 05:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20191111192258.2234502-1-arnd@arndb.de> <20191112105507.GA7122@lst.de>
In-Reply-To: <20191112105507.GA7122@lst.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 12 Nov 2019 14:04:16 +0100
Message-ID: <CAKMK7uEEz1n+zuTs29rbPHU74Dspaib=prpMge63L_-rUk_o4A@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 08:22:50PM +0100, Arnd Bergmann wrote:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior, everywhere else this is the same as ioremap() anyway.
> >
> > Change the only driver that still references ioremap_uc() to only do so
> > on x86-32/ia64 in order to allow removing that interface at some
> > point in the future for the other architectures.
> >
> > On some architectures, ioremap_uc() just returns NULL, changing
> > the driver to call ioremap() means that they now have a chance
> > of working correctly.
>
> So this whole area is a bit of a mess.  ioremap_uc on ia64 is brand
> new in this cycle, for ia64-internal users that were previously
> using ioremap_nocache.  And ioremap_nocache was identical to ioremap
> everywhere but ia64.  So I think we can safely skip ia64 in the ifdef
> if we go down that route.
>
> But also on x86 I'd actually rather prefer killing off this only mainline
> user of ioremap_uc.  It was added by Luis in commit 3cc2dac5be3f
> ("drivers/video/fbdev/atyfb: Replace MTRR UC hole with strong UC",
> which looks like an optimization of MTRR usage.  I feel like I really
> don't understand the point there, but it also seems a pity to keep
> the API around just for that.

Wut ... Maybe I'm missing something, but from how we use mtrr in other
gpu drivers it's a) either you use MTRR because that's all you got or
b) you use pat. Mixing both sounds like a pretty bad idea, since if
you need MTRR for performance (because you dont have PAT) then you
can't fix the wc with the PAT-based ioremap_uc. And if you have PAT,
then you don't really need an MTRR to get wc.

So I'd revert this patch from Luis and ...

> That being said linux-next added another call to ioremap_uc in
> drivers/mfd/intel-lpss.c, so it looks like the API might have to stay.
>
> So I guess modulo excluding ia64 your patch looks fine, and should go
> along something like the one below.  I'll happily carry them in the
> ioremap tree with the right ACKs.
>
> ---
> From 81243b2aa78babcc5f97b2c2a29957fcf3fd3664 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 12 Nov 2019 11:52:25 +0100
> Subject: ioremap: remove ioremap_uc except on x86 and ia64
>
> ioremap_uc is a special API to work around caching oddities on
> Intel platforms.  Remove it from all other architectures now that
> only x86 and ia64-specific callers are left.

... apply this one. Since the same reasoning should apply to anything
that's running on any cpu with PAT.
-Daniel

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/io.h    |  1 -
>  arch/m68k/include/asm/kmap.h   |  1 -
>  arch/mips/include/asm/io.h     |  1 -
>  arch/parisc/include/asm/io.h   |  1 -
>  arch/powerpc/include/asm/io.h  |  1 -
>  arch/sh/include/asm/io.h       |  1 -
>  arch/sparc/include/asm/io_64.h |  1 -
>  include/asm-generic/io.h       | 15 ---------------
>  include/linux/io.h             |  2 ++
>  lib/devres.c                   |  4 ++++
>  10 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index 1989b946a28d..11fdcade3c5c 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -290,7 +290,6 @@ static inline void __iomem * ioremap_nocache(unsigned long offset,
>  }
>
>  #define ioremap_wc ioremap_nocache
> -#define ioremap_uc ioremap_nocache
>
>  static inline void iounmap(volatile void __iomem *addr)
>  {
> diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
> index 559cb91bede1..22b5ea4fc8b8 100644
> --- a/arch/m68k/include/asm/kmap.h
> +++ b/arch/m68k/include/asm/kmap.h
> @@ -28,7 +28,6 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
>  }
>
>  #define ioremap_nocache ioremap
> -#define ioremap_uc ioremap
>  #define ioremap_wt ioremap_wt
>  static inline void __iomem *ioremap_wt(unsigned long physaddr,
>                                        unsigned long size)
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 3f6ce74335b4..9195ded1d6a7 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -249,7 +249,6 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
>   */
>  #define ioremap_nocache(offset, size)                                  \
>         __ioremap_mode((offset), (size), _CACHE_UNCACHED)
> -#define ioremap_uc ioremap_nocache
>
>  /*
>   * ioremap_cache -     map bus memory into CPU space
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index 46212b52c23e..0674f5cd3045 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -130,7 +130,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
>  void __iomem *ioremap(unsigned long offset, unsigned long size);
>  #define ioremap_nocache(off, sz)       ioremap((off), (sz))
>  #define ioremap_wc                     ioremap_nocache
> -#define ioremap_uc                     ioremap_nocache
>
>  extern void iounmap(const volatile void __iomem *addr);
>
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index a63ec938636d..119bcbe3e328 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -716,7 +716,6 @@ extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
>  void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
>  void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
>  #define ioremap_nocache(addr, size)    ioremap((addr), (size))
> -#define ioremap_uc(addr, size)         ioremap((addr), (size))
>  #define ioremap_cache(addr, size) \
>         ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
>
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 1495489225ac..30bbe787f1ef 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -368,7 +368,6 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
>  #endif
>
>  #define ioremap_nocache        ioremap
> -#define ioremap_uc     ioremap
>
>  /*
>   * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index f4afa301954a..688911051b44 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -407,7 +407,6 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  }
>
>  #define ioremap_nocache(X,Y)           ioremap((X),(Y))
> -#define ioremap_uc(X,Y)                        ioremap((X),(Y))
>  #define ioremap_wc(X,Y)                        ioremap((X),(Y))
>  #define ioremap_wt(X,Y)                        ioremap((X),(Y))
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 325fc98cc9ff..357e8638040c 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -972,21 +972,6 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  #define ioremap_wt ioremap
>  #endif
>
> -/*
> - * ioremap_uc is special in that we do require an explicit architecture
> - * implementation.  In general you do not want to use this function in a
> - * driver and use plain ioremap, which is uncached by default.  Similarly
> - * architectures should not implement it unless they have a very good
> - * reason.
> - */
> -#ifndef ioremap_uc
> -#define ioremap_uc ioremap_uc
> -static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> -{
> -       return NULL;
> -}
> -#endif
> -
>  #ifdef CONFIG_HAS_IOPORT_MAP
>  #ifndef CONFIG_GENERIC_IOMAP
>  #ifndef ioport_map
> diff --git a/include/linux/io.h b/include/linux/io.h
> index a59834bc0a11..6574bb0f28e6 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -64,8 +64,10 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
>
>  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>                            resource_size_t size);
> +#ifdef ioremap_uc
>  void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
>                                    resource_size_t size);
> +#endif
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>                                    resource_size_t size);
>  void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> diff --git a/lib/devres.c b/lib/devres.c
> index f56070cf970b..0299279ddf02 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -40,9 +40,11 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>         case DEVM_IOREMAP_NC:
>                 addr = ioremap_nocache(offset, size);
>                 break;
> +#ifdef ioremap_uc
>         case DEVM_IOREMAP_UC:
>                 addr = ioremap_uc(offset, size);
>                 break;
> +#endif
>         case DEVM_IOREMAP_WC:
>                 addr = ioremap_wc(offset, size);
>                 break;
> @@ -72,6 +74,7 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  }
>  EXPORT_SYMBOL(devm_ioremap);
>
> +#ifdef ioremap_uc
>  /**
>   * devm_ioremap_uc - Managed ioremap_uc()
>   * @dev: Generic device to remap IO address for
> @@ -86,6 +89,7 @@ void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
>         return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
>  }
>  EXPORT_SYMBOL_GPL(devm_ioremap_uc);
> +#endif /* ioremap_uc */
>
>  /**
>   * devm_ioremap_nocache - Managed ioremap_nocache()
> --
> 2.20.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
