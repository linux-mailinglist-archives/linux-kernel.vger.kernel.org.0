Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52E122C53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfLQMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:54:44 -0500
Received: from foss.arm.com ([217.140.110.172]:36234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfLQMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:54:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D455731B;
        Tue, 17 Dec 2019 04:54:43 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3AFE3F719;
        Tue, 17 Dec 2019 04:54:41 -0800 (PST)
Subject: Re: [Patch v6 5/7] sched/fair: update cpu_capacity to reflect thermal
 pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-6-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <829b67ec-d463-2ed5-749b-11fa9def26ad@arm.com>
Date:   Tue, 17 Dec 2019 13:54:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576123908-12105-6-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 05:11, Thara Gopinath wrote:
> cpu_capacity relflects the maximum available capacity of a cpu. Thermal

s/relflects/reflects

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e12a375..4840655 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7725,8 +7725,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>  	if (unlikely(irq >= max))
>  		return 1;
>  
> +	/*
> +	 * avg_rt.util avg and avg_dl.util track binary signals
> +	 * (running and not running) with weights 0 and 1024 respectively.

What exactly is this weight here? I assume the 'unsigned long load'
parameter of ___update_load_avg(). At least this would match its use in
__update_load_avg_se().

[...]
