Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B871944BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCZQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 12:55:24 -0400
Received: from foss.arm.com ([217.140.110.172]:34912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZQzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:55:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE947FA;
        Thu, 26 Mar 2020 09:55:23 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2F3E3F71E;
        Thu, 26 Mar 2020 09:55:22 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:55:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Li Wang <li.wang@windriver.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mmu: no write cache for O_SYNC flag
Message-ID: <20200326165520.GD26987@mbp>
References: <20200326163625.30714-1-li.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326163625.30714-1-li.wang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:36:25AM -0700, Li Wang wrote:
> reproduce steps:
> 1.
> disable CONFIG_STRICT_DEVMEM in linux kernel
> 2.
> Process A gets a Physical Address of global variable by
> "/proc/self/pagemap".
> 3.
> Process B writes a value to the same Physical Address by mmap():
> fd=open("/dev/mem",O_SYNC);
> Virtual Address=mmap(fd);
> 
> problem symptom:
> after Process B write a value to the Physical Address,
> Process A of the value of global variable does not change.
> They both W/R the same Physical Address.
> 
> technical reason:
> Process B writing the Physical Address is by the Virtual Address,
> and the Virtual Address comes from "/dev/mem" and mmap().
> In arm64 arch, the Virtual Address has write cache.
> So, maybe the value is not written into Physical Address.
> 
> fix reason:
> giving write cache flag in arm64 is in phys_mem_access_prot():
> =====
> arch/arm64/mm/mmu.c
> phys_mem_access_prot()
> {
>   if (!pfn_valid(pfn))
>     return pgprot_noncached(vma_prot);
>   else if (file->f_flags & O_SYNC)
>     return pgprot_writecombine(vma_prot);
>   return vma_prot;
> }
> ====
> the other arch and the share function drivers/char/mem.c of phys_mem_access_prot()
> does not add write cache flag.
> So, removing the flag to fix the issue

Other architectures may have transparent caches and don't require
different attributes.

> Signed-off-by: Li Wang <li.wang@windriver.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 128f70852bf3..d7083965ca17 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -81,8 +81,6 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  {
>  	if (!pfn_valid(pfn))
>  		return pgprot_noncached(vma_prot);
> -	else if (file->f_flags & O_SYNC)
> -		return pgprot_writecombine(vma_prot);
>  	return vma_prot;
>  }
>  EXPORT_SYMBOL(phys_mem_access_prot);

A better solution is for user space not to pass O_SYNC when opening
/dev/mem. We've had this ABI for a long time (arch/arm/ and several
other architectures do the same), why change it now?

-- 
Catalin
