Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D171481BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfHENTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:19:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHENTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+zg3Q0qbwadWzEXAHp2dEIUnwX928QZQCv40GNsiQfE=; b=MkKnS0haSAsZCM1dQAbXlm7qm
        /9jne+j7omAc+jgYQFv0sE1x3jeePjGawqcbaD/c69HixKGXRNGrOnNScsU1+ShZl3jjZaEuuCFrw
        Rrf52WWLraGV621/8eEvwdwdrMDNBKqBAq/wUDWuWDZRd4dmwRdiuE5awB6nu4mrhnqBga3/MSZ2O
        pgeKKYdi3sS6aB7AXsJ3DM4/R6hkc/SKkc0V2VOZzudyQZkkmiD9EPNk4ANJFfBzHOgcHD1yG324g
        KF1yoW3RPS7T95OnZY3jXqY4TTcJU7F9gXM+Ga1+UeZdOxjCIyJbmyg3O1iY6oF6ORiVS3sOBVFzW
        Zpn+8hIbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huct8-0008I6-Sg; Mon, 05 Aug 2019 13:18:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFED82020AD3A; Mon,  5 Aug 2019 15:18:56 +0200 (CEST)
Date:   Mon, 5 Aug 2019 15:18:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/7] perf: Allow normal events to be sources of AUX
 data
Message-ID: <20190805131856.GM2349@hirez.programming.kicks-ass.net>
References: <20190805071618.29468-1-alexander.shishkin@linux.intel.com>
 <20190805071618.29468-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805071618.29468-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:16:12AM +0300, Alexander Shishkin wrote:
> In some cases, ordinary (non-AUX) events can generate data for AUX events.
> For example, PEBS events can come out as records in the Intel PT stream
> instead of their usual DS records, if configured to do so.
> 
> One requirement for such events is to consistently schedule together, to
> ensure that the data from the "AUX source" events isn't lost while their
> corresponding AUX event is not scheduled. We use grouping to provide this
> guarantee: an "AUX source" event can be added to a group where an AUX event
> is a group leader, and provided that the former supports writing to the
> latter.

Two niggles -- and sorry for not bringing those up sooner:

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 7198ddd0c6b1..213cae95e713 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -374,7 +374,8 @@ struct perf_event_attr {
>  				namespaces     :  1, /* include namespaces data */
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
> -				__reserved_1   : 33;
> +				aux_source     :  1, /* generate AUX records instead of events */
> +				__reserved_1   : 32;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */

The name: "aux_source" seems to imply that we change the source to
'aux', while in fact it is the destination we change.

So we want to %s/aux_source/aux_output/ on the whole thing?

> +	/*
> +	 * Our group leader must be an aux event if we want to be
> +	 * an aux_source. This way, the aux event will precede its
> +	 * aux_source events in the group, and therefore will always
> +	  schedule first.
> +	 */

You fudged the comment there.
