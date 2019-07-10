Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35F96269E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfGHQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 12:50:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfGHQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7TP6olv0vwBenq+UW4Cc+ytFRZnhcSmljzIf/cLfNMo=; b=dKiU9OHSgnviQs+xmMw117A7k
        JBNGq8R/hdLZQk1imT3NL+DXKHnJnMlI0aaRKi7jW2QSwscqnfu5RWZyr6VASmYpAgCWPDibLeLKW
        qjhu7EJnywmBbX6BZiH7gKH+SRPk/cZPnjdumVf7onqoz7iUQiVW96cHgTY7iFL7TFspaObfeilow
        owLxoHt+Dl4LQOaTMeWvuRdFwa8V4MoIYszhDKA73/i1/PZMjFEDOSZg+9lvF0VmIujEVrSpWmyDM
        xC6G/gmdq6ErxC//+rWOXkw0jd+OZJF1h2f3UrayY6XFZvQNzmwBEX9cG5+OC4GWVHGpRohFssr8O
        xmr0RMgxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWqa-0006w0-2R; Mon, 08 Jul 2019 16:50:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5513320976EFA; Mon,  8 Jul 2019 18:50:34 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 5/7] perf: cache perf_event_groups_first for cgroups
Message-ID: <20190708165034.GI3419@hirez.programming.kicks-ass.net>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-6-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:53PM -0700, Ian Rogers wrote:
> @@ -3511,7 +3550,12 @@ static int visit_groups_merge(struct perf_event_context *ctx,
>  	min_heapify_all(&heap);
>  
>  	while (heap.num_elements > 0) {
> -		ret = func(ctx, cpuctx, heap.storage[0], data);
> +		if (is_pinned)
> +			ret = pinned_sched_in(ctx, cpuctx, heap.storage[0]);
> +		else
> +			ret = flexible_sched_in(ctx, cpuctx, heap.storage[0],
> +						data);
> +
>  		if (ret)
>  			return ret;
>  

You can actually merge those two functions; see merge_sched_in() in the
below patch:

https://lkml.kernel.org/r/20181010104559.GO5728@hirez.programming.kicks-ass.net
