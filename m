Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAE146F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAWREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:04:11 -0500
Received: from foss.arm.com ([217.140.110.172]:42368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWREL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:04:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79A421FB;
        Thu, 23 Jan 2020 09:04:10 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD023F6C4;
        Thu, 23 Jan 2020 09:04:08 -0800 (PST)
Subject: Re: [PATCH v2 1/6] arm64: add support for the AMU extension v1
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-2-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <05b1981b-cf4d-d990-5155-6ed3fadcca92@arm.com>
Date:   Thu, 23 Jan 2020 17:04:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-2-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On 18/12/2019 18:26, Ionela Voinescu wrote:
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -382,6 +382,42 @@
>  #define SYS_TPIDR_EL0			sys_reg(3, 3, 13, 0, 2)
>  #define SYS_TPIDRRO_EL0			sys_reg(3, 3, 13, 0, 3)
>  
> +/* Definitions for system register interface to AMU for ARMv8.4 onwards */
> +#define SYS_AM_EL0(crm, op2)		sys_reg(3, 3, 13, crm, op2)
> +#define SYS_AMCR_EL0			SYS_AM_EL0(2, 0)
> +#define SYS_AMCFGR_EL0			SYS_AM_EL0(2, 1)
> +#define SYS_AMCGCR_EL0			SYS_AM_EL0(2, 2)
> +#define SYS_AMUSERENR_EL0		SYS_AM_EL0(2, 3)
> +#define SYS_AMCNTENCLR0_EL0		SYS_AM_EL0(2, 4)
> +#define SYS_AMCNTENSET0_EL0		SYS_AM_EL0(2, 5)
> +#define SYS_AMCNTENCLR1_EL0		SYS_AM_EL0(3, 0)
> +#define SYS_AMCNTENSET1_EL0		SYS_AM_EL0(3, 1)
> +
> +/*
> + * Group 0 of activity monitors (architected):
> + *                op0 CRn   op1   op2     CRm
> + * Counter:       11  1101  011   n<2:0>  010:n<3>

Nit: any reason for picking a different order than the encoding one? e.g.
                     op0  op1  CRn   CRm       op2
                     11   011  1101  010:<n3>  n<2:0>

> + * Type:          11  1101  011   n<2:0>  011:n<3>
> + * n: 0-3

My Arm ARM (DDI 0487E.a) says n can be in the [0, 15] range, despite there
being only 4 architected counters ATM. Shouldn't matter too much now, but
when more architected counters are added we'll have to assert 'n' against
something (some revision #?).

> + *
> + * Group 1 of activity monitors (auxiliary):
> + *                op0 CRn   op1   op2     CRm
> + * Counter:       11  1101  011   n<2:0>  110:n<3>
> + * Type:          11  1101  011   n<2:0>  111:n<3>
> + * n: 0-15
> + */
> +
> +#define SYS_AMEVCNTR0_EL0(n)            SYS_AM_EL0(4 + ((n) >> 3), (n) & 0x7)
                                                                          /^^^^
If you want to be fancy, you could use GENMASK(2, 0) --------------------/

> +#define SYS_AMEVTYPE0_EL0(n)            SYS_AM_EL0(6 + ((n) >> 3), (n) & 0x7)
> +#define SYS_AMEVCNTR1_EL0(n)            SYS_AM_EL0(12 + ((n) >> 3), (n) & 0x7)
> +#define SYS_AMEVTYPE1_EL0(n)            SYS_AM_EL0(14 + ((n) >> 3), (n) & 0x7)
> +
> +/* V1: Fixed (architecturally defined) activity monitors */
> +#define SYS_AMEVCNTR0_CORE_EL0          SYS_AMEVCNTR0_EL0(0)
> +#define SYS_AMEVCNTR0_CONST_EL0         SYS_AMEVCNTR0_EL0(1)
> +#define SYS_AMEVCNTR0_INST_RET_EL0      SYS_AMEVCNTR0_EL0(2)
> +#define SYS_AMEVCNTR0_MEM_STALL         SYS_AMEVCNTR0_EL0(3)
> +
>  #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
>  
>  #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)

> @@ -1150,6 +1152,59 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
>  
>  #endif
>  
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +
> +/*
> + * This per cpu variable only signals that the CPU implementation supports
> + * the Activity Monitors Unit (AMU) but does not provide information
> + * regarding all the events that it supports.
> + * When this amu_feat per CPU variable is true, the user of this feature
> + * can only rely on the presence of the 4 fixed counters. But this does
> + * not guarantee that the counters are enabled or access to these counters
> + * is provided by code executed at higher exception levels.
> + *
> + * Also, to ensure the safe use of this per_cpu variable, the following
> + * accessor is defined to allow a read of amu_feat for the current cpu only
> + * from the current cpu.
> + *  - cpu_has_amu_feat()
> + */
> +static DEFINE_PER_CPU_READ_MOSTLY(u8, amu_feat);
> +

Why not bool?

> +inline bool cpu_has_amu_feat(void)
> +{
> +	return !!this_cpu_read(amu_feat);
> +}
> +
> +static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
> +{
> +	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> +		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
> +			smp_processor_id());
> +		this_cpu_write(amu_feat, 1);
> +	}
> +}
