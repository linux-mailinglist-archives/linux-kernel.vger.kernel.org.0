Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092A61185C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLJLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:04:39 -0500
Received: from foss.arm.com ([217.140.110.172]:39776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfLJLEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:04:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246AA1FB;
        Tue, 10 Dec 2019 03:04:38 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15EF83F6CF;
        Tue, 10 Dec 2019 03:04:36 -0800 (PST)
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
To:     Hanjun Guo <guohanjun@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b32a687-5553-dc3f-da6c-2d5c88b7e311@arm.com>
Date:   Tue, 10 Dec 2019 11:04:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 10:46 am, Hanjun Guo wrote:
> In smmu_pmu_probe(), there is put_cpu() in the error path,
> which is wrong because we use raw_smp_processor_id() to
> get the cpu ID, not get_cpu(), remove it.

Bah, somehow that slipped through the last round of review :)

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 773128f..fd1d46a 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   out_unregister:
>   	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
>   out_cpuhp_err:
> -	put_cpu();
>   	return err;
>   }
>   
> 
