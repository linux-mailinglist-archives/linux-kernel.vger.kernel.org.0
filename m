Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB36D120771
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfLPNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:43:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cLfO0FrQIKDkhgJ7+GWTEvyF1lH2jQR6D5ajAAbwWqM=; b=R2sWXSzlCi29GOXEb+/EfVweF
        TzupiJFTCWPu3SPv0GI77HT5+VhO+cpDFybK+mZZ7pBw95JonFirMmiU1ON47gbMnu3DAw5kgY1KB
        kmKFYVYMFR7WELulE9JhF4fT9Krom+GrZ9uX56N8ko/PERBwF4ary7alQ/z9xkLqf/ahJJQ3w/z2e
        jetzKD6oO+/aifTtsszChK8mVO0j26XcSmKK4XOiQm9yMAY8hsZ5wTtslx0Yb8wqo+iQd5Ii8eRq8
        S4mcEq5B0ZBO4NH59llFRLJpzqIUj3dya62Ceh6wQ3wKw9GCbKNCXX04n8uCTZ9AmvoeI+PVIp39h
        T1Jun0TUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igqek-0000JG-Fj; Mon, 16 Dec 2019 13:43:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49952301747;
        Mon, 16 Dec 2019 14:42:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 577332B2A00ED; Mon, 16 Dec 2019 14:43:24 +0100 (CET)
Date:   Mon, 16 Dec 2019 14:43:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 1/7] sched/pelt.c: Add support to track thermal
 pressure
Message-ID: <20191216134324.GQ2844@hirez.programming.kicks-ass.net>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:11:42PM -0500, Thara Gopinath wrote:
> The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg, the
> average thermal pressure is tracked through load_avg. This is because
> thermal pressure signal is weighted "delta" capacity and is not
> binary(util_avg is binary). "delta capacity" here means delta between the
> actual capacity of a cpu and the decreased capacity a cpu due to a thermal
> event.

I'm thinking that ^, would make a nice adding to that v.

> +/*
> + * thermal:
> + *
> + *   load_sum = \Sum se->avg.load_sum
> + *
> + *   util_avg and runnable_load_avg are not supported and meaningless.
> + *
> + */
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	if (___update_load_sum(now, &rq->avg_thermal,
> +			       capacity,
> +			       capacity,
> +			       capacity)) {
> +		___update_load_avg(&rq->avg_thermal, 1, 1);
> +		trace_pelt_thermal_tp(rq);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
