Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F205AD185
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 03:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfIIBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 21:25:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731552AbfIIBZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:25:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C96ABB1BDEDBF66C19FA;
        Mon,  9 Sep 2019 09:25:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Sep 2019
 09:25:12 +0800
Subject: Re: [PATCH -next] perf/smmuv3: gpio: creg-snps: use
 devm_platform_ioremap_resource() to simplify code
To:     <will@kernel.org>, <mark.rutland@arm.com>
References: <20190906143844.27956-1-yuehaibing@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <de66c0f1-129e-846d-1bde-f2e45b38dd82@huawei.com>
Date:   Mon, 9 Sep 2019 09:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190906143844.27956-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch title is wrong,  fix it in v2, sorry.

On 2019/9/6 22:38, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index abcf54f..773128f 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -727,7 +727,7 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>  static int smmu_pmu_probe(struct platform_device *pdev)
>  {
>  	struct smmu_pmu *smmu_pmu;
> -	struct resource *res_0, *res_1;
> +	struct resource *res_0;
>  	u32 cfgr, reg_size;
>  	u64 ceid_64[2];
>  	int irq, err;
> @@ -764,8 +764,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  
>  	/* Determine if page 1 is present */
>  	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		smmu_pmu->reloc_base = devm_ioremap_resource(dev, res_1);
> +		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
>  		if (IS_ERR(smmu_pmu->reloc_base))
>  			return PTR_ERR(smmu_pmu->reloc_base);
>  	} else {
> 

