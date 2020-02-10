Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E705C1581E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:01:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgBJSBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:01:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB741FB;
        Mon, 10 Feb 2020 10:01:11 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E9073F68F;
        Mon, 10 Feb 2020 10:01:10 -0800 (PST)
Subject: Re: [PATCH] perf/smmuv3: Use platform_get_irq_optional() for wired
 interrupt
To:     John Garry <john.garry@huawei.com>, will@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com
References: <1581353417-136604-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ce02f401-5d32-ef0e-80ed-2579bd4f08bb@arm.com>
Date:   Mon, 10 Feb 2020 18:01:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1581353417-136604-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2020 4:50 pm, John Garry wrote:
> Even though a SMMUv3 PMCG implementation may use an MSI as the form of
> interrupt source, the kernel would still complain that it does not find
> the wired (GSIV) interrupt in this case:
> 
> root@(none)$ dmesg | grep arm-smmu-v3-pmcg | grep "not found"
> [   59.237219] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.8.auto: IRQ index 0 not found
> [   59.322841] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.9.auto: IRQ index 0 not found
> [   59.422155] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: IRQ index 0 not found
> [   59.539014] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: IRQ index 0 not found
> [   59.640329] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: IRQ index 0 not found
> [   59.743112] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: IRQ index 0 not found
> [   59.880577] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: IRQ index 0 not found
> [   60.017528] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: IRQ index 0 not found
> 
> Use platform_get_irq_optional() to silence the warning.
> 
> If neither interrupt source is found, then the driver will still warn that
> IRQ setup errored and the probe will fail.

Indeed, this is fallout from the core platform_get_irq() changes, but is 
clearly appropriate since the GSIV is explicitly optional in IORT. Not 
to mention we did the same thing for SMMUv3 itself already.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index d704eccc548f..f01a57e5a5f3 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -771,7 +771,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>   	}
>   
> -	irq = platform_get_irq(pdev, 0);
> +	irq = platform_get_irq_optional(pdev, 0);
>   	if (irq > 0)
>   		smmu_pmu->irq = irq;
>   
> 
