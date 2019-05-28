Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB02C717
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfE1M4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 08:56:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfE1M4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DRQ/H105p5/3a63H0dgbNKZg2aY/zu92xXWVVrC1LWw=; b=ju/o2maTvwBbImtbPNLh5QpOs
        Ud8JYiA5IV0MawILTrpNnLHBKTVUTLj+dkHvixv1BSr4gj8t3E8I8T+p5b2e4051Ov2Rg/KYWm1QJ
        zz7QFpZVaJCPThFVl+uIQIEqbJVsJH07M3xUW6GYJC35fwaag7xgEz2niYaoSNj8Jw0bsI0Wp7ztD
        3Ly8l+EKaOczZqqft4/KMXSFc79MrLn4U/u4HiIThMVx+se3zVPMbhZwYsA5VbgFrB6j6G4ESWe2H
        mQUllMiNAy54MetyWYKThQnWHifRSnrZtB8lYJaelStrfoL0QxG4k23gME+0NWuq6cPkJrkhlgjee
        3oI2GYtlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVbeK-0003rv-Kv; Tue, 28 May 2019 12:56:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CC7520729088; Tue, 28 May 2019 14:56:15 +0200 (CEST)
Date:   Tue, 28 May 2019 14:56:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528125615.GW2606@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e9075d57853d..07ecfe75f0e6 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -91,16 +91,20 @@ u64 x86_perf_event_update(struct perf_event *event)
>  					new_raw_count) != prev_raw_count)
>  		goto again;
>  
> -	/*
> -	 * Now we have the new raw value and have updated the prev
> -	 * timestamp already. We can now calculate the elapsed delta
> -	 * (event-)time and add that to the generic event.
> -	 *
> -	 * Careful, not all hw sign-extends above the physical width
> -	 * of the count.
> -	 */
> -	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> -	delta >>= shift;
> +	if (unlikely(hwc->flags & PERF_X86_EVENT_UPDATE))
> +		delta = x86_pmu.metric_update_event(event, new_raw_count);
> +	else {
> +		/*
> +		 * Now we have the new raw value and have updated the prev
> +		 * timestamp already. We can now calculate the elapsed delta
> +		 * (event-)time and add that to the generic event.
> +		 *
> +		 * Careful, not all hw sign-extends above the physical width
> +		 * of the count.
> +		 */
> +		delta = (new_raw_count << shift) - (prev_raw_count << shift);
> +		delta >>= shift;
> +	}
>  
>  	local64_add(delta, &event->count);
>  	local64_sub(delta, &hwc->period_left);

> @@ -1186,6 +1194,9 @@ int x86_perf_event_set_period(struct perf_event *event)
>  	if (idx == INTEL_PMC_IDX_FIXED_BTS)
>  		return 0;
>  
> +	if (x86_pmu.set_period && x86_pmu.set_period(event))
> +		goto update_userpage;
> +
>  	/*
>  	 * If we are way outside a reasonable range then just skip forward:
>  	 */
> @@ -1234,6 +1245,7 @@ int x86_perf_event_set_period(struct perf_event *event)
>  			(u64)(-left) & x86_pmu.cntval_mask);
>  	}
>  
> +update_userpage:
>  	perf_event_update_userpage(event);
>  
>  	return ret;


*groan*.... that's pretty terrible.
