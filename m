Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C590F2C809
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfE1NoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:44:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfE1NoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nvi7MnXX/CxSxnFKxV1sR7rcZWzepfL3hwfQ+8PG8Y8=; b=eSHzSzixc2JWxyPPSo4TVlPJ9
        mIHi6+veTT3ZL1ETz09keDDvVtcq9Po84m1vYq+noiFHeyLKF4vJSvGG9BdGNdlO2ofeKujyS2kHK
        +TmMPX86O8DaF/upbtQ5i7LIcdoVbKKm51znjgJXDhJMpACvQOAdqFdqE4MFnxWbTujkUgWOQ4har
        RVo4K25BHO4/GO4WKEoNtmeBXFiwLZoSmjCxt1raV2ccn/IlKehMRT2YiXeo3wIPTdEnhPqEMF5Mk
        AoYdtzOAX0MWtxQgDA2+TzJZTmRMtP/eo1WGrCGpRSouK3CP8CTO0EoGAKctpfbczlgR9QvZSxsgv
        ikjSPcPyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcOS-0003Fs-LE; Tue, 28 May 2019 13:43:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82B212065C636; Tue, 28 May 2019 15:43:54 +0200 (CEST)
Date:   Tue, 28 May 2019 15:43:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528134354.GP2623@hirez.programming.kicks-ass.net>
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
> @@ -3287,6 +3304,13 @@ static int core_pmu_hw_config(struct perf_event *event)
>  	return intel_pmu_bts_config(event);
>  }
>  
> +#define EVENT_CODE(e)	(e->attr.config & INTEL_ARCH_EVENT_MASK)
> +#define is_slots_event(e)	(EVENT_CODE(e) == 0x0400)
> +#define is_perf_metrics_event(e)				\
> +		(((EVENT_CODE(e) & 0xff) == 0xff) &&		\
> +		 (EVENT_CODE(e) >= 0x01ff) &&			\
> +		 (EVENT_CODE(e) <= 0x04ff))
> +

That is horrific.. (e & INTEL_ARCH_EVENT_MASK) & 0xff is just daft,
that should be: (e & ARCH_PERFMON_EVENTSEL_EVENT).

Also, we already have fake events for event=0, see FIXED2, why are we
now using event=0xff ?
