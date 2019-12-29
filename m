Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1D12CB1F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 23:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfL2WLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 17:11:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfL2WLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 17:11:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF131FB;
        Sun, 29 Dec 2019 14:11:24 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26543F237;
        Sun, 29 Dec 2019 14:11:22 -0800 (PST)
Date:   Sun, 29 Dec 2019 22:11:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Li Guanglei <guangleix.li@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, guanglei.li@unisoc.com
Subject: Re: [PATCH v01] sched/core: uclamp: fix rq.uclamp memory size of
 initialization
Message-ID: <20191229221119.oaxrygmi37cnzqas@e107158-lin.cambridge.arm.com>
References: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/19 15:44, Li Guanglei wrote:
> From: Li Guanglei <guanglei.li@unisoc.com>
> 
> uclamp_rq for each clamp id(UCLAMP_CNT) should be initialized when call

s/clamp id(UCLAMP_CNT)/UCLAMP_CNT/

> init_uclamp.
> 
> Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>

This need fixes tag

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")

Otherwise this looks good to me.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

> ---
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4..05f870b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1252,7 +1252,8 @@ static void __init init_uclamp(void)
>  	mutex_init(&uclamp_mutex);
>  
>  	for_each_possible_cpu(cpu) {
> -		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
> +		memset(&cpu_rq(cpu)->uclamp, 0,
> +				sizeof(struct uclamp_rq)*UCLAMP_CNT);
>  		cpu_rq(cpu)->uclamp_flags = 0;
>  	}
>  
> -- 
> 2.7.4
> 
