Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA59F68B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 01:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfH0XFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 19:05:19 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48606 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0XFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:05:19 -0400
X-Greylist: delayed 3026 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 19:05:18 EDT
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0] (helo=home.buserror.net)
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i2jd4-0005yb-Kk; Tue, 27 Aug 2019 17:07:56 -0500
Date:   Tue, 27 Aug 2019 17:07:52 -0500
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        jingxiangfeng@huawei.com, zhaohongjiang@huawei.com,
        thunder.leizhen@huawei.com, fanchengyang@huawei.com,
        yebin10@huawei.com
Message-ID: <20190827220752.GA17757@home.buserror.net>
References: <20190809100800.5426-1-yanaijie@huawei.com>
 <20190809100800.5426-5-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809100800.5426-5-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com, zhaohongjiang@huawei.com, thunder.leizhen@huawei.com, fanchengyang@huawei.com, yebin10@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
Subject: Re: [PATCH v6 04/12] powerpc/fsl_booke/32: introduce
 create_tlb_entry() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 06:07:52PM +0800, Jason Yan wrote:
> Add a new helper create_tlb_entry() to create a tlb entry by the virtual
> and physical address. This is a preparation to support boot kernel at a
> randomized address.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
> Tested-by: Diana Craciun <diana.craciun@nxp.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S | 29 ++++++++++++++++++++++++++++
>  arch/powerpc/mm/mmu_decl.h           |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index adf0505dbe02..04d124fee17d 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -1114,6 +1114,35 @@ __secondary_hold_acknowledge:
>  	.long	-1
>  #endif
>  
> +/*
> + * Create a 64M tlb by address and entry
> + * r3/r4 - physical address
> + * r5 - virtual address
> + * r6 - entry
> + */
> +_GLOBAL(create_tlb_entry)

This function is broadly named but contains various assumptions about the
entry being created.  I'd just call it create_kaslr_tlb_entry.

> +	lis     r7,0x1000               /* Set MAS0(TLBSEL) = 1 */
> +	rlwimi  r7,r6,16,4,15           /* Setup MAS0 = TLBSEL | ESEL(r6) */
> +	mtspr   SPRN_MAS0,r7            /* Write MAS0 */
> +
> +	lis     r6,(MAS1_VALID|MAS1_IPROT)@h
> +	ori     r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
> +	mtspr   SPRN_MAS1,r6            /* Write MAS1 */
> +
> +	lis     r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@h
> +	ori     r6,r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@l
> +	and     r6,r6,r5
> +	ori	r6,r6,MAS2_M@l
> +	mtspr   SPRN_MAS2,r6            /* Write MAS2(EPN) */
> +
> +	ori     r8,r4,(MAS3_SW|MAS3_SR|MAS3_SX)
> +	mtspr   SPRN_MAS3,r8            /* Write MAS3(RPN) */
> +
> +	tlbwe                           /* Write TLB */
> +	isync
> +	sync
> +	blr

Should set MAS7 under MMU_FTR_BIG_PHYS (or CONFIG_PHYS_64BIT if it's
too early for features) -- even if relocatable kernels over 4GiB aren't
supported (I don't remember if they work or not), MAS7 might be non-zero
on entry.  And the function claims to take a 64-bit phys addr as input...

MAS2_M should be MAS2_M_IF_NEEDED to match other kmem tlb entries.

-Scott
