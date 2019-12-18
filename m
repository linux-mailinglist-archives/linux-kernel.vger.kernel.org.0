Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C918123E17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 04:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRDqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 22:46:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43826 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRDqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:46:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so662225wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdnaDzCOwk6rsvAnZaC2ZQiQdFaLBqTLLfNDRQQhxDY=;
        b=0Sfc9XE1NLZKY1AjonAflMTtDQWATJDMN8BqCfGb/vIJfHOC/8e+lQM7Qg6qgKCuaB
         +d/mO6J86NRZ9L/kHkZW4o+ZLyQseWjWWeqGBju0tC5bj3DrOnaL2nby/yGprCCryis6
         cc8dD9ouyxGvgDQSCrViqtnRJGEtx6JThso+u/FzcxlzNOz66FIxKXGq8HmfxVa4wB2X
         tSNAE2F1kQHp46OErkzrqCAZ+FPTCPfwVKJinjo0w9vPF7DKJ8l0jEq5bvE/fUekZo1J
         puEkMLlWKk06/WR4mRNlKSmY17fVxQ/TEKDNuZgYh6pujaNvt5rWgxEhkI0vRBRusz6F
         xCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdnaDzCOwk6rsvAnZaC2ZQiQdFaLBqTLLfNDRQQhxDY=;
        b=jwYWGJGxmMFMoQJJbWA2nGJS/uDkHOFoIhTTKy4LOeSj5rcCSNpTgTYJ1RYt9UNmaG
         erSv+2u9jntL2GVEnXW/TwOhgHmI1in67+rjxVG0S3MPw//8uOVrnltH68zTShqmrNw2
         VdV9j5nMS/riuuGTUus4p/loTlesyDUXVf9DUTTZEhQSZLP9Fa0Izmf8MK/BGeuS2EDh
         Ky0GlunHovXsVafYKRi2PiIQVsZpanaHDklobyTCrNlG/PUw0iffNMBv4wRU0nitjPny
         hzLLECLoxOaRL8OXbwZCDsPM7iaYT60HsO3e9vVg323zsJyxZS0CfMZzRCPnDp/bSP5G
         LMxw==
X-Gm-Message-State: APjAAAWXatDUCt3w/5gYfHcRiP8TLgxxok/uOP5tv1AmKKL2dDCNbQMg
        ZhoCnC+VpaeZqq8y2Jrzeok0q0Y2Pj+fVNNlhC87E09R
X-Google-Smtp-Source: APXvYqwnXYt4Bap4c3JgnA1rGM1rIMpopW/Ik54jWZRHcz4V745vaH7UU1cjgUvTyzjCOtVFJQWW8JXoMBfA3U/NSBk=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr1333231wrn.251.1576640806047;
 Tue, 17 Dec 2019 19:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20191217131530.513096-1-david.abdurachmanov@sifive.com>
In-Reply-To: <20191217131530.513096-1-david.abdurachmanov@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 18 Dec 2019 09:16:34 +0530
Message-ID: <CAAhSdy1pz5Zmrdm6hBxugjbBiw3d25XZJ47rpKgVk7fHaoEr6Q@mail.gmail.com>
Subject: Re: [PATCH] define vmemmap before pfn_to_page calls
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:45 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> pfn_to_page call depends on `vmemmap` being available before the call.
> This caused compilation errors in Fedora/RISCV with 5.5-rc2 and was caused
> by NOMMU changes which moved declarations after functions definitions.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Fixes: 6bd33e1ece52 ("riscv: add nommu support")
> ---
>  arch/riscv/include/asm/pgtable.h | 34 ++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ff0ed4f292e..d8c89e6e6b3d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -90,6 +90,23 @@ extern pgd_t swapper_pg_dir[];
>  #define __S110 PAGE_SHARED_EXEC
>  #define __S111 PAGE_SHARED_EXEC
>
> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> +#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +
> +/*
> + * Roughly size the vmemmap space to be large enough to fit enough
> + * struct pages to map half the virtual address space. Then
> + * position vmemmap directly below the VMALLOC region.
> + */
> +#define VMEMMAP_SHIFT \
> +       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +#define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
> +#define VMEMMAP_END    (VMALLOC_START - 1)
> +#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap                ((struct page *)VMEMMAP_START)
> +
>  static inline int pmd_present(pmd_t pmd)
>  {
>         return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
> @@ -400,23 +417,6 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define __pte_to_swp_entry(pte)        ((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)  ((pte_t) { (x).val })
>
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
> -/*
> - * Roughly size the vmemmap space to be large enough to fit enough
> - * struct pages to map half the virtual address space. Then
> - * position vmemmap directly below the VMALLOC region.
> - */
> -#define VMEMMAP_SHIFT \
> -       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> -#define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
> -#define VMEMMAP_END    (VMALLOC_START - 1)
> -#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> -
> -#define vmemmap                ((struct page *)VMEMMAP_START)
> -
>  #define PCI_IO_SIZE      SZ_16M
>  #define PCI_IO_END       VMEMMAP_START
>  #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
> --
> 2.23.0
>

Can you add a comment for "#define vmemmap" about your findings ?

Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
