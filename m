Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2461189A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 14:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfLJNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 08:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLJNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:25:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D15207FF;
        Tue, 10 Dec 2019 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575984303;
        bh=7zz0gT/SrMqg+Iv3/a+MU7zCh+V2pcljyvzuxR+IT34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GM1k2ugB1SumXt2BeMZkt/nfg8Hpg1wJl35Dv8zm/pnjLZLxly+QpNTSclZQ9xH5
         kaJzxjY0okQ64nFPtls6LyKALqZSsZwnY1/5Q641+vdO2WJ03UXl33/WwOVfs73jZ0
         WtYNagDwyN8nEHS/rXf4aHm5SEfhS6VVha7ey/7s=
Date:   Tue, 10 Dec 2019 13:24:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
Message-ID: <20191210132458.GA19183@willie-the-truck>
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:46:24PM +0800, Hanjun Guo wrote:
> In smmu_pmu_probe(), there is put_cpu() in the error path,
> which is wrong because we use raw_smp_processor_id() to
> get the cpu ID, not get_cpu(), remove it.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 773128f..fd1d46a 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  out_unregister:
>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
>  out_cpuhp_err:
> -	put_cpu();
>  	return err;

Can we kill 'out_cpuhp_err' altogether then and just return err if we fail
to add the hotplug instance?

Will
