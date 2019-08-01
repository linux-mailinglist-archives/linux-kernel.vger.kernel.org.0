Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827677DADA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfHAMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 08:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfHAMEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:04:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12C120644;
        Thu,  1 Aug 2019 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564661049;
        bh=ot5STRM/B8yVvrzcOXAfmZCEFTH93aXQATe1UlXglC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ump+elZokFz78+k37rDcEG7nfi1dDvmKbqAeSv1dkaE3Ov2/1+SnJIXX1R1W+cSxa
         O0RuI9LBKE0yehewPDkc5gOdgAreDpZx/sG0vTBm7OZ0VJAEeb5HVFeUKM64PGcRp5
         rhzNY3H22XhvjjFl256OwMtUxxsm7N0vyYdEmZ9E=
Date:   Thu, 1 Aug 2019 13:04:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: fix variable 'pud' set but not used
Message-ID: <20190801120405.tnrjs4iyg2ujy6ed@willie-the-truck>
References: <1564603545-14776-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564603545-14776-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:05:45PM -0400, Qian Cai wrote:
> GCC throws a warning,
> 
> arch/arm64/mm/mmu.c: In function 'pud_free_pmd_page':
> arch/arm64/mm/mmu.c:1033:8: warning: variable 'pud' set but not used
> [-Wunused-but-set-variable]
>   pud_t pud;
>         ^~~
> 
> because pud_table() is a macro and compiled away. Fix it by making it a
> static inline function and for pud_sect() as well.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/pgtable.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3f5461f7b560..541cb4a15341 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -447,8 +447,15 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PMD_TYPE_SECT)
>  
>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
> -#define pud_sect(pud)		(0)
> -#define pud_table(pud)		(1)
> +static inline bool pud_sect(pud_t pud)
> +{
> +	return false;
> +}
> +
> +static inline bool pud_table(pud_t pud)
> +{
> +	return true;
> +}

Applied for 5.3.

Will
