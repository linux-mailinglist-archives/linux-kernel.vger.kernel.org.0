Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66491C34D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfJAMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJAMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:54:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2E321872;
        Tue,  1 Oct 2019 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934459;
        bh=qdFT2iQGfLY4YITal90NGC2PaaAOxSUOpd1IJ8jDa4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KD7GKKfxZ54dCseOBe5DG+Yohm1Gco/g7LjKC3gCbHAP9ww1Hb9AcIC5WGiQnooAO
         +x0gIphzaT3nFyIhopIKkTQYByBH1dMoWYdlUT9AwlNE1MQujO3FhOhYP2Owa+U82x
         DR9GDDoMON4RQpr++Mr7UPWmm3BFFpcOkOmqmfNY=
Date:   Tue, 1 Oct 2019 13:54:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20191001125413.mhxa6qszwnuhglky@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930015740.84362-4-justin.he@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case.(by Kirill)
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/memory.c | 99 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 84 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b1ca51a079f2..1f56b0118ef5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>  					2;
>  #endif
>  
> +#ifndef arch_faults_on_old_pte
> +static inline bool arch_faults_on_old_pte(void)
> +{
> +	return false;
> +}
> +#endif

Kirill has acked this, so I'm happy to take the patch as-is, however isn't
it the case that /most/ architectures will want to return true for
arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
that to be the default, and have x86 and arm64 provide an override? For
example, aren't most architectures still going to hit the double fault
scenario even with your patch applied?

Will
