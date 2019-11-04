Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE4EDCB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfKDKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 05:40:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:36340 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKDKkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:40:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 02:40:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="200459764"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2019 02:40:06 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
In-Reply-To: <20191104084024.GZ4131@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com> <20191025140835.53665-2-alexander.shishkin@linux.intel.com> <20191028162712.GH4097@hirez.programming.kicks-ass.net> <87tv7sg5ml.fsf@ashishki-desk.ger.corp.intel.com> <20191104084024.GZ4131@hirez.programming.kicks-ass.net>
Date:   Mon, 04 Nov 2019 12:40:05 +0200
Message-ID: <87y2wvexh6.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Oct 28, 2019 at 07:08:18PM +0200, Alexander Shishkin wrote:
>
>> > @@ -6318,11 +6318,12 @@ static void perf_aux_sample_output(struc
>> >  
>> >  	/*
>> >  	 * Guard against NMI hits inside the critical section;
>> > -	 * see also perf_aux_sample_size().
>> > +	 * see also perf_prepare_sample_aux().
>> >  	 */
>> >  	WRITE_ONCE(rb->aux_in_sampling, 1);
>> > +	barrier();
>> 
>> Isn't WRITE_ONCE() barrier enough on its own? My thinking was that we
>> only need a compiler barrier here, hence the WRITE_ONCE.
>
> WRITE_ONCE() is a volatile store and (IIRC) the compiler ensures order
> against other volatile things, but not in general.
>
> barrier() OTOH clobbers all of memory and thereby ensures nothing can
> get hoised over it.
>
> Now, the only thing we do inside this region is an indirect call, which
> on its own already implies a sync point for as long as the compiler
> cannot inline it, so it might be a bit paranoid on my end (I don't think
> even LTO can reduce this indirection and cause inlining).

I see what you mean. I was only thinking about not having to order the
AUX STOREs vs the rb->aux_in_sampling. Ordering the call itself makes
sense.

Thanks,
--
Alex
