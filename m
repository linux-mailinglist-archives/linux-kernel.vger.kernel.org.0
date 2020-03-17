Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0F18917F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCQWaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:30:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgCQWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:30:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so12750002pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=wPJg6k1Sfn4B+Mn0ckVM+kQDp/J12ZPy70SP4OqLIKc=;
        b=a4AYWaPYTV1Ov4C4bMzAohMy1SC9tLz+W2ucVsXcKXrISG2pEufjEu65pVsU1Ulzxc
         SIInJL8CAWvEzvc4bd9aGw48Zr0Q1cHy+J5QxTenCh7Wo/xUBrzI0zUgcp71syQ4Ud38
         jykLe4l8oLtY3FBM1DHX2IV9hs8tkHyakVKQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wPJg6k1Sfn4B+Mn0ckVM+kQDp/J12ZPy70SP4OqLIKc=;
        b=cTQWFv4RAYXnXhToUe1aHI536iy0C6zOYfChqxITygRV5mfhPWqquLaeN2opKTtWb6
         9MjLGsREKBAN8g9SYBZ/OadjF2kmGp5pDXSWlGF5Zop0a4ilXtdhZcAt+bhDvGC0jah6
         j3xXN3/mMgsj7axbeltEvUSqRgGV7uFcnGjuRwK/0P9o4xrYA50ADp77AvEY4NUmeK6g
         owNHYENgt8MyrP8xUNVUDl6OCEii3M8HU4e8sUUsuVyeFxi0SLcAjFke1J2Wf5ZL6cEA
         c6bvldTYKmHGSGtz3KmrjMFbgjy81O/mACoSNr6cMY8J4lruS+An4Z0qPxBP6NXUh0iU
         rQQQ==
X-Gm-Message-State: ANhLgQ2olCsddae7NeFaNb4l1iZwBU7T5xa/B/MsVbur4YZIzWaVrhmS
        RoE0pUABubEf4XNWjdmmTyPDgg==
X-Google-Smtp-Source: ADFU+vtJ/d67T1c/j3elk3aQsSMEmbYNSCFaYEz7RmgX8uPiCI1o36kNu92JJiiS8LO+Qa1lkIqiog==
X-Received: by 2002:a63:741c:: with SMTP id p28mr1255502pgc.402.1584484243489;
        Tue, 17 Mar 2020 15:30:43 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-11e1-e7cb-3c10-05d6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:11e1:e7cb:3c10:5d6])
        by smtp.gmail.com with ESMTPSA id a2sm348002pjq.20.2020.03.17.15.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 15:30:42 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com, ego@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in powernv_cpufreq_work_fn
In-Reply-To: <20200316135743.57735-1-psampat@linux.ibm.com>
References: <20200316135743.57735-1-psampat@linux.ibm.com>
Date:   Wed, 18 Mar 2020 09:30:39 +1100
Message-ID: <87fte6obqo.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

Thanks.

I have checked:

 - for matching puts/gets
 - that all the '.' to '->' conversions, aud uses of '&' check out
 - that the Snowpatch checks pass (https://patchwork.ozlabs.org/patch/1255580/)

On that basis:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> size overflow in 'powernv_cpufreq_work_fn'
>
> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 56f4bc0d209e..20ee0661555a 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> +	struct cpufreq_policy *policy;
>  	unsigned int cpu;
>  	cpumask_t mask;
>  
> @@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
>  	chip->restore = false;
>  	for_each_cpu(cpu, &mask) {
>  		int index;
> -		struct cpufreq_policy policy;
>  
> -		cpufreq_get_policy(&policy, cpu);
> -		index = cpufreq_table_find_index_c(&policy, policy.cur);
> -		powernv_cpufreq_target_index(&policy, index);
> -		cpumask_andnot(&mask, &mask, policy.cpus);
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			continue;
> +		index = cpufreq_table_find_index_c(policy, policy->cur);
> +		powernv_cpufreq_target_index(policy, index);
> +		cpumask_andnot(&mask, &mask, policy->cpus);
> +		cpufreq_cpu_put(policy);
>  	}
>  out:
>  	put_online_cpus();
> -- 
> 2.24.1
