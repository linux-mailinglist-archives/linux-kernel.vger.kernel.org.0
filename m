Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FF2D655
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE2H3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 03:29:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2H3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2qFO6R2FdEWpmlQ/21BG2KnrEzXYRXJAi0pNklzkaI=; b=NvEOnp9mgMx6edq7y2uA9QdQN
        UUamf4ZUN4dZIAwqWEYgMvKWoyxrz4DnX81JvCWdi0Uzicv3uWY8Tu3amj5akl5zwWwAgq6ISGu0M
        pgCaeBXNBlSXIF34i4UXewD8wfnyTL5Rg5yjA/auBkmplL67Qi+V5dusp0s6aaoA3SRyFzRLtQj5c
        wAJKUGQabfmJO5kUTX1x2lGVYFrU3YoolJ3N27LKyc2veVXgHryra/+5EyqZ+tqVUPgBO/4BbA61C
        +9ZZFlcvgAYc7/U2VhGA96XRyqOc86993TxZ+E0nJpgUvsoQ7JNIdTZ8cpSrcbxXTSnOoXhmKxNa0
        zFqNfOs1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVt17-0008Pk-PH; Wed, 29 May 2019 07:28:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E610201A7E41; Wed, 29 May 2019 09:28:55 +0200 (CEST)
Date:   Wed, 29 May 2019 09:28:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
Message-ID: <20190529072855.GX2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
 <20190528121508.GS2606@hirez.programming.kicks-ass.net>
 <991ef247-8efe-bc21-a988-3d628733d915@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991ef247-8efe-bc21-a988-3d628733d915@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:21:49PM -0400, Liang, Kan wrote:
> 
> 
> On 5/28/2019 8:15 AM, Peter Zijlstra wrote:
> > On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:
> > > +/*
> > > + * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
> > > + * and another for the whole slots counter
> > > + *
> > > + * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
> > > + * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
> > > + * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
> > > + * have the same configuration.
> > > + */
> > > +#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 17)
> > > +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
> > > +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
> > > +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
> > > +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
> > > +#define INTEL_PMC_MSK_ANY_SLOTS			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
> > > +						 INTEL_PMC_MSK_FIXED_SLOTS)
> > > +static inline bool is_metric_idx(int idx)
> > > +{
> > > +	return idx >= INTEL_PMC_IDX_FIXED_METRIC_BASE && idx <= INTEL_PMC_IDX_TD_BE_BOUND;
> > > +}
> > 
> > Something like:
> > 
> > 	return (idx >> INTEL_PMC_IDX_FIXED_METRIC_BASE) & 0xf;
> > 
> > might be faster code... (if it wasn't for 64bit literals being a pain,
> > it could be a simple test instruction).
> > 
> 
> is_metric_idx() is not a mask. It's to check if the idx between 49 and 52.

blergh, indeed. Check that it compiles into a single branch though, if
it gets that wrong it needs hand holding.

One way would be to make these 48-51 and put BTS as 52, and then you do
have a mask.

Another way would be to write it as:

	(unsigned)(idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) < 4;


