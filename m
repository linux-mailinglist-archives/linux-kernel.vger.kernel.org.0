Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53299FEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfH1Jhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:37:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfH1Jhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lzDU24rr69reVb104Pce2/xUV/b2psIODNqgf8Q5hjI=; b=iBjfAYPXlHB+XqPH4DdhAmFHg
        774im8ZAEvMqDXaAEYklM8RcJWo5UVzucK9HxzyKPZJ6OV8nnQLepb8gDr88OQ4+5KC8eTFY3Ni+V
        uuEcZB4odylEURWjWNICBuIVepn+vIpCwV5XLVsUeXcAiYcv4ziu9IsrrCdz5a1GFW75gATruMEkx
        skbNQeXW+IzpYaQPQyIbUX00xi0D3NuICIvHDIPLCkHL0/6yRLs4u10v9MAGukNVvcAnFRUkj1zuF
        /q2+KXFaRnWTtLE59wyUu/0Urdt/3UeKnmHc/7ubh8vEOOmJ4TRKpw/I91uLlfxKVRixTwPrVRvUs
        3y1Nf2anQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2uOT-0008Q7-JY; Wed, 28 Aug 2019 09:37:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C51B4300B83;
        Wed, 28 Aug 2019 11:36:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8D5720230B03; Wed, 28 Aug 2019 11:37:31 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:37:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828093731.GO2386@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
 <20190828084416.GC2369@hirez.programming.kicks-ass.net>
 <20190828090217.GN2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828090217.GN2386@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:02:17AM +0200, Peter Zijlstra wrote:
> @@ -2192,8 +2227,22 @@ static void intel_pmu_read_event(struct
>  static void intel_pmu_enable_fixed(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> -	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
>  	u64 ctrl_val, mask, bits = 0;
> +	int idx = hwc->idx;
> +
> +	if (is_topdown_idx(idx)) {
> +		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +		/*
> +		 * When there are other Top-Down events already active; don't
> +		 * enable the SLOTS counter.
> +		 */
> +		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
> +			return;
> +
> +		idx = INTEL_PMC_IDX_FIXED_SLOTS;
> +	}
> +
> +	intel_set_masks(event, hwc->idx);

That wants to be idx, not hwc->idx.
