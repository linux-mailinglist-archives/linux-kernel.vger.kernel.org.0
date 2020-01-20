Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40385142E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgATPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 10:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:30 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2032070C;
        Mon, 20 Jan 2020 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579533090;
        bh=LCcU4e5UGq3OH9ShprWhNnt09GF0XJXuxMbSyUBugW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTvFmKdnoaOuLcxDRYa7Ta1L8hTE/HN51tSEtJxuDqbRY6ttUABkmSxnFLKjrjG9K
         FIo4rDliaMvnwjRwl/YtLrUOfQmAA/GGm2VTl1ac0fhEr2A4TmDhkkCoD8FBGKzm4j
         XgW/eESNMulzby33FBgMq9MZ6NTCMBpTEVC7Qhfs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itYi8-000IhN-2l; Mon, 20 Jan 2020 15:11:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 15:11:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH v3 05/32] irqchip/gic-v4.1: VPE table (aka
 GICR_VPROPBASER) allocation
In-Reply-To: <b4a78cea-4ba3-58fb-4121-44508e7ae384@huawei.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-6-maz@kernel.org>
 <b4a78cea-4ba3-58fb-4121-44508e7ae384@huawei.com>
Message-ID: <3f1aad5c7f79b5ae5b87cef57523ec78@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-20 14:03, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/12/24 19:10, Marc Zyngier wrote:
>> GICv4.1 defines a new VPE table that is potentially shared between
>> both the ITSs and the redistributors, following complicated affinity
>> rules.
>> 
>> To make things more confusing, the programming of this table at
>> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER 
>> register
>> for something completely different.
>> 
>> The code flow is somewhat complexified by the need to respect the
>> affinities required by the HW, meaning that tables can either be
>> inherited from a previously discovered ITS or redistributor.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> With two very minor concerns below.
> 
> [...]
> 
>> +static int allocate_vpe_l1_table(void)
>> +{
>> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>> +	u64 val, gpsz, npg, pa;
>> +	unsigned int psz = SZ_64K;
>> +	unsigned int np, epp, esz;
>> +	struct page *page;
>> +
>> +	if (!gic_rdists->has_rvpeid)
>> +		return 0;
>> +
>> +	/*
>> +	 * if VPENDBASER.Valid is set, disable any previously programmed
>> +	 * VPE by setting PendingLast while clearing Valid. This has the
>> +	 * effect of making sure no doorbell will be generated and we can
>> +	 * then safely clear VPROPBASER.Valid.
>> +	 */
>> +	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & 
>> GICR_VPENDBASER_Valid)
>> +		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
>> +				      vlpi_base + GICR_VPENDBASER);
> 
> I'm confused here.  The Valid field resets to 0.  Under which scenario
> will the Valid==1 while we're doing initialization for this RD?

The cases I'm worried about are things like kexec or cpu hotplug,
where we could find that the RD programming is still valid, one way
or another. This is unlikely to hit in practice, but who knows...

> 
>> +
>> +	/*
>> +	 * If we can inherit the configuration from another RD, let's do
>> +	 * so. Otherwise, we have to go through the allocation process. We
>> +	 * assume that all RDs have the exact same requirements, as
>> +	 * nothing will work otherwise.
>> +	 */
>> +	val = 
>> inherit_vpe_l1_table_from_rd(&gic_data_rdist()->vpe_table_mask);
>> +	if (val & GICR_VPROPBASER_4_1_VALID)
>> +		goto out;
>> +
>> +	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), 
>> GFP_KERNEL);
>> +	if (!gic_data_rdist()->vpe_table_mask)
>> +		return -ENOMEM;
>> +
>> +	val = inherit_vpe_l1_table_from_its();
>> +	if (val & GICR_VPROPBASER_4_1_VALID)
>> +		goto out;
>> +
>> +	/* First probe the page size */
>> +	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
>> +	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>> +	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
>> +	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
>> +	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
>> +
>> +	switch (gpsz) {
>> +	default:
>> +		gpsz = GIC_PAGE_SIZE_4K;
>> +		/* fall through */
>> +	case GIC_PAGE_SIZE_4K:
>> +		psz = SZ_4K;
>> +		break;
>> +	case GIC_PAGE_SIZE_16K:
>> +		psz = SZ_16K;
>> +		break;
>> +	case GIC_PAGE_SIZE_64K:
>> +		psz = SZ_64K;
>> +		break;
>> +	}
>> +
>> +	/*
>> +	 * Start populating the register from scratch, including RO fields
>> +	 * (which we want to print in debug cases...)
>> +	 */
>> +	val = 0;
>> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, gpsz);
>> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ENTRY_SIZE, esz);
>> +
>> +	/* How many entries per GIC page? */
>> +	esz++;
>> +	epp = psz / (esz * SZ_8);
>> +
>> +	/*
>> +	 * If we need more than just a single L1 page, flag the table
>> +	 * as indirect and compute the number of required L1 pages.
>> +	 */
>> +	if (epp < ITS_MAX_VPEID) {
>> +		int nl2;
>> +
>> +		gic_rdists->flags |= RDIST_FLAGS_VPE_INDIRECT;
> 
> This flag is set but not used, can we just drop it?

Yes, good point. I can't even remember what I had in mind with this
flag, so it can't be that important! ;-).

I'll clean that up.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
