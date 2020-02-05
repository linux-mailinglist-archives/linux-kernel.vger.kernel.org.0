Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD61530A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 13:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBEM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 07:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgBEM1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:27:07 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE6622527;
        Wed,  5 Feb 2020 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580905627;
        bh=QKBpJPiVyTVeBC8mnt3utXps19G5xC9I5KMgOWdab1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zSt+huBiTdTNPzwwBWTKDLJoxb/3PNigLzG2XOn1LgYahLEG7KCaHXdAwSKGd8f2r
         mR0TUHU+F4WwAJTnOrGaPFJ2Ma78/JMXt+Tmvyi98eJbPMnlpHbogwSvyd1FXvtNG4
         4o8qrykZBMw71QyHSPAlxxJJ3ilOKqkLeIj7jlbg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izJlp-0037ry-8I; Wed, 05 Feb 2020 12:27:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 12:27:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
Subject: Re: [PATCH RFC 3/5] irqchip/gic-v4.1: Ensure L2 vPE table is
 allocated at RD level
In-Reply-To: <20200204090940.1225-4-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
 <20200204090940.1225-4-yuzenghui@huawei.com>
Message-ID: <621f153637ccabb85ede10e2c495c38f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

Thanks for this. A few comments below.

On 2020-02-04 09:09, Zenghui Yu wrote:
> In GICv4, we will ensure that level2 vPE table memory is allocated
> for the specified vpe_id on all v4 ITS, in its_alloc_vpe_table().
> This still works well for the typical GICv4.1 implementation, where
> the new vPE table is shared between the ITSs and the RDs.
> 
> To make things explicit, introduce allocate_vpe_l1_table_entry() to
> make sure that the L2 tables are allocated on all v4.1 RDs. We're
> likely not need to allocate memory in it because the vPE table is
> shared and (L2 table is) already allocated at ITS level, except
> for the case where the ITS doesn't share anything (say SVPET == 0,
> practically unlikely but architecturally allowed).

Huh... Interesting. I definitely don't anticipate the case to pop up,
but you are right, this is architecturally allowed.

> The implementation of allocate_vpe_l1_table_entry() is mostly
> copied from its_alloc_table_entry().
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 0f1fe56ce0af..c1d01454eec8 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2443,6 +2443,64 @@ static u64 
> inherit_vpe_l1_table_from_rd(cpumask_t **mask)
>  	return 0;
>  }
> 
> +static int allocate_vpe_l1_table_entry(int cpu, u32 id)

Given that this actually allocates the L2 table, I'd rather have it 
called
something like allocate_vpe_l2_table() as the pendant of 
allocate_vpe_l1_table().

This should also properly return a bool rather then an int.

> +{
> +	void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
> +	u64 val, gpsz, npg;
> +	unsigned int psz, esz, idx;
> +	struct page *page;
> +	__le64 *table;
> +
> +	if (!gic_rdists->has_rvpeid)
> +		return true;
> +
> +	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
> +
> +	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
> +	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
> +	npg  = FIELD_GET(GICR_VPROPBASER_4_1_SIZE, val) + 1;
> +
> +	switch (gpsz) {
> +	default:
> +		WARN_ON(1);
> +		/* fall through */
> +	case GIC_PAGE_SIZE_4K:
> +		psz = SZ_4K;
> +		break;
> +	case GIC_PAGE_SIZE_16K:
> +		psz = SZ_16K;
> +		break;
> +	case GIC_PAGE_SIZE_64K:
> +		psz = SZ_64K;
> +		break;
> +	}
> +
> +	/* Don't allow vpe_id that exceeds single, flat table limit */
> +	if (!(val & GICR_VPROPBASER_4_1_INDIRECT))
> +		return (id < (npg * psz / (esz * SZ_8)));
> +
> +	/* Compute 1st level table index & check if that exceeds table limit 
> */
> +	idx = id >> ilog2(psz / (esz * SZ_8));
> +	if (idx >= (npg * psz / GITS_LVL1_ENTRY_SIZE))
> +		return false;
> +
> +	table = gic_data_rdist_cpu(cpu)->vpe_l1_base;
> +
> +	/* Allocate memory for 2nd level table */
> +	if (!table[idx]) {
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
> +		if (!page)
> +			return false;
> +
> +		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);

I think we may need a cache flushing here in some circumstances. We 
certainly
have it in its_alloc_table_entry.

> +
> +		/* Ensure updated table contents are visible to RD hardware */
> +		dsb(sy);
> +	}
> +
> +	return true;
> +}
> +
>  static int allocate_vpe_l1_table(void)
>  {
>  	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> @@ -2957,6 +3015,7 @@ static bool its_alloc_device_table(struct
> its_node *its, u32 dev_id)
>  static bool its_alloc_vpe_table(u32 vpe_id)
>  {
>  	struct its_node *its;
> +	int cpu;
> 
>  	/*
>  	 * Make sure the L2 tables are allocated on *all* v4 ITSs. We
> @@ -2979,6 +3038,15 @@ static bool its_alloc_vpe_table(u32 vpe_id)
>  			return false;
>  	}
> 
> +	/*
> +	 * Make sure the L2 tables are allocated for all copies of
> +	 * the L1 table on *all* v4.1 RDs.
> +	 */
> +	for_each_possible_cpu(cpu) {

not: You could predicate this on gic_rdists->has_rvpeid so that you 
don't
iterate pointlessly on non v4.1 HW.

> +		if (!allocate_vpe_l1_table_entry(cpu, vpe_id))
> +			return false;
> +	}
> +
>  	return true;
>  }

Otherwise, looks good to me.

         M.
-- 
Jazz is not dead. It just smells funny...
