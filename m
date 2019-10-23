Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB59E1BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405569AbfJWNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:07:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:23123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390642AbfJWNHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:07:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196771778"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 06:07:14 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0112630034D; Wed, 23 Oct 2019 06:07:13 -0700 (PDT)
Date:   Wed, 23 Oct 2019 06:07:13 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH v2 9/9] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191023130713.GG4660@tassilo.jf.intel.com>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-10-andi@firstfloor.org>
 <20191023103048.GK22919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023103048.GK22919@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:30:48PM +0200, Jiri Olsa wrote:
> On Sun, Oct 20, 2019 at 10:52:02AM -0700, Andi Kleen wrote:
> 
> SNIP
> 
> >  
> >  void evlist__enable(struct evlist *evlist)
> >  {
> >  	struct evsel *pos;
> > +	struct affinity affinity;
> > +	struct perf_cpu_map *cpus;
> > +	int i;
> > +
> > +	if (affinity__setup(&affinity) < 0)
> > +		return;
> > +
> > +	cpus = evlist__cpu_iter_start(evlist);
> > +	for (i = 0; i < cpus->nr; i++) {
> > +		int cpu = cpus->map[i];
> > +		affinity__set(&affinity, cpu);
> >  
> > +		evlist__for_each_entry(evlist, pos) {
> > +			if (evlist__cpu_iter_skip(pos, cpu))
> > +				continue;
> > +			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
> > +				continue;
> 
> all the previous patches and this one have this code in common,
> could we make this a single function, that would call a callback
> that would have affinity set.. sort of like what we do in 
> cpu_function_call in the kernel

I'm personally not a big friend of call backs. They usually make
the code harder to read and reason about. 

Prefer to use callable libraries of common code.

Also the event open code has some more complex variants of this pattern
which would need multiple call backs.

I already factored the common code into the iterator.

I guess the for loop could be a macro, and affinity_set() could
perhaps accept the map and return the cpu. I'll add that in
the next version. This will reduce the common code by a few lines
more.

-Andi
