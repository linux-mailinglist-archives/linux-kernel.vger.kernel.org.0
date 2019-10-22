Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3CE00F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfJVJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:43:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbfJVJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RwIP5iYVyDPZ4XmYjQVjvZswU8VLxR/GtcD4XS8SImg=; b=ltGOOSMBEdi9MdfgedYGqHuDC
        GzgOqwKXl4XZ/ydrrwwa9xZBYSvImnTuIVpeuYFKzzJdp6Heo7UPXreMaXNjYrqF6DQY/05jSrsLS
        Lfin28Y/Jl2yXuKUvgSU3l+GjP4eSa/K0eiC1CM6lzjpqe8MVuAHHwf/1NXQfHhTt5gyzRsDOrXEh
        hzMIWn+ejfiZXx0yiecL1nheG9st/oxoGsFOQxnjKxy16SZWLqiDRblgSpCNUWQ5m+0xIhIYzP2CC
        bWG14fRJ8ZF221vTMXFf1kxNkd7So0jrYKj7+ijD0l2pDJORAqJSncIQLn+KwjkHN6g1+iH95AFKS
        eH2NsWntQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqgv-0002RW-EB; Tue, 22 Oct 2019 09:43:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3A87300F29;
        Tue, 22 Oct 2019 11:42:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2900F20977B04; Tue, 22 Oct 2019 11:43:00 +0200 (CEST)
Date:   Tue, 22 Oct 2019 11:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
Message-ID: <20191022094300.GL1817@hirez.programming.kicks-ass.net>
References: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
 <4d6320bb-0d15-0028-aefb-a176c986b8db@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6320bb-0d15-0028-aefb-a176c986b8db@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:01:11AM +0300, Alexey Budankov wrote:

>  			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
>  
> +			/*
> +			 * PMU specific parts of task perf context can require
> +			 * additional synchronization which makes sense only if
> +			 * both next_ctx->task_ctx_data and ctx->task_ctx_data
> +			 * pointers are allocated. As an example of such
> +			 * synchronization see implementation details of Intel
> +			 * LBR call stack data profiling;
> +			 */
> +			if (ctx->task_ctx_data && next_ctx->task_ctx_data)
> +				pmu->sync_task_ctx(next_ctx->task_ctx_data,
> +						   ctx->task_ctx_data);

This still does not check if pmu->sync_task_ctx is set. If any other
arch ever uses task_ctx_data without then also supplying this method
things will go *bang*.

Also, I think I prefer the variant I gave you yesterday:

  https://lkml.kernel.org/r/20191021103745.GF1800@hirez.programming.kicks-ass.net

	if (pmu->swap_task_ctx)
		pmu->swap_task_ctx(ctx, next_ctx);
	else
		swap(ctx->task_ctx_data, next_ctx->task_ctx_data);

That also unconfuses the argument order in your above patch (where you
have to undo thw swap).

Alternatively, since there currently is no other arch using
task_ctx_data, we can make the pmu::swap_task_ctx() thing mandatory when
having it and completely replace the swap(), write it like so:


-	swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
+	if (pmu->swap_task_ctx)
+		pmu->swap_task_ctx(ctx, next_ctx);

Hmm?
