Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB2105476
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKUOb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 09:31:58 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43916 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKUOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:31:58 -0500
Received: by mail-qv1-f68.google.com with SMTP id cg2so1459987qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fW+snf6UqDvFVf1LkUQFZkGk7vLMJEbBU8A9Yp3N68M=;
        b=k5aDy7/OfCyk/SolHuR6ucmHqIw0D31VqEYAXrXrhSKVIIn4kJThFMunYz82gRzgfH
         bqmTtKZwjxuiNkwNund1fK7BqnDbLLRBnhBVFY5+517Ee5qfse0HPwyTSzwgdJakgXyX
         VGsW7pupItMZ5zqnPzsBCYVGQsg+SmTXoJuwWrpJpmpvKQqBFZ0NoHLUnOw/PFPt6M/S
         kTFS45tIpzLNb1FD6OcbmNVkCqrF2lit3rN4YGLDvhaPQcskD2C1iuHvMCgOYD+Blb+G
         Na/eQM9B+WU503d0VceDXxVOscR+2meyCF7zecaFDXkOD6x7KKBjTSs2f7dbxP5R1dTQ
         RqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fW+snf6UqDvFVf1LkUQFZkGk7vLMJEbBU8A9Yp3N68M=;
        b=LrJUDlj+loOIvx6yTqD40G7P1KN0dbIDejM1O1yOEbkw4gMbU2zJrmdUArSY24enxb
         DakVLHYuuPAn9suMkvKKDKO4Gh4L9rknlHXgcmvBzXeQM/uoFTq8TLPsVmpCnIK7eMh/
         WgbbtIbcN4UouTl3Jbt4mZgbBEhpzR/zH8+zbsAH+tmE+zQsa/VrILQUgBnoqd/rOszT
         jqvOnU5N5L8GyYrvnlaFAlX/6gkZzdBgCLDTREUugi6P2clrmzjeyd279h+pzWDEQH7R
         4RGZUYlEigBp6oEiF9XByLidFSGrJueXc3ibJqZQtfk2hMmYmGlFOCOfh+71kl3s3JXm
         IARA==
X-Gm-Message-State: APjAAAU9dmHgDtp4IAhsVCd1crUVLuQr7zRkmbsLWGFy+R+JDF9HJZ3w
        QEYQ3SRVg1+ZHdo6ECxAn2E=
X-Google-Smtp-Source: APXvYqygaYmhKEs/gkzsD4QbqA1UF73loYMYI6rSvXcmQVgA6t6WJDHZ630y8U7+mALmZUQcopp/0Q==
X-Received: by 2002:ad4:57d4:: with SMTP id y20mr8577290qvx.63.1574346715395;
        Thu, 21 Nov 2019 06:31:55 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l5sm1539941qth.23.2019.11.21.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:31:54 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5BA140D3E; Thu, 21 Nov 2019 11:31:51 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:31:51 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] perf intel-pt: Add support for recording AUX area
 samples
Message-ID: <20191121143151.GD5078@kernel.org>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
 <20191115124225.5247-14-adrian.hunter@intel.com>
 <20191121142843.GB5078@kernel.org>
 <20191121143129.GC5078@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121143129.GC5078@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 21, 2019 at 11:31:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 21, 2019 at 11:28:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 15, 2019 at 02:42:23PM +0200, Adrian Hunter escreveu:
> > > Set up the default number of mmap pages, default sample size and default
> > > psb_period for AUX area sampling. Add documentation also.
> > > 
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > ---
> > >  tools/perf/Documentation/intel-pt.txt | 59 ++++++++++++++++++-
> > >  tools/perf/arch/x86/util/auxtrace.c   |  2 +
> > >  tools/perf/arch/x86/util/intel-pt.c   | 81 ++++++++++++++++++++++++++-
> > >  3 files changed, 139 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
> > > index e0d9e7dd4f17..2cf2d9e9d0da 100644
> > > --- a/tools/perf/Documentation/intel-pt.txt
> > > +++ b/tools/perf/Documentation/intel-pt.txt
> > > @@ -434,6 +434,56 @@ pwr_evt		Enable power events.  The power events provide information about
> > >  		"0" otherwise.
> > >  
> > >  
> > > +AUX area sampling option
> > > +------------------------
> > > +
> > > +To select Intel PT "sampling" the AUX area sampling option can be used:
> > > +
> > > +	--aux-sample
> > > +
> > > +Optionally it can be followed by the sample size in bytes e.g.
> > > +
> > > +	--aux-sample=8192
> > > +
> > > +In addition, the Intel PT event to sample must be defined e.g.
> > > +
> > > +	-e intel_pt//u
> > > +
> > > +Samples on other events will be created containing Intel PT data e.g. the
> > > +following will create Intel PT samples on the branch-misses event, note the
> > > +events must be grouped using {}:
> > > +
> > > +	perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
> > > +
> > > +An alternative to '--aux-sample' is to add the config term 'aux-sample-size' to
> > > +events.  In this case, the grouping is implied e.g.
> > > +
> > > +	perf record -e intel_pt//u -e branch-misses/aux-sample-size=8192/u
> > > +
> > > +is the same as:
> > > +
> > > +	perf record -e '{intel_pt//u,branch-misses/aux-sample-size=8192/u}'
> > > +
> > > +but allows for also using an address filter e.g.:
> > > +
> > > +	perf record -e intel_pt//u --filter 'filter * @/bin/ls' -e branch-misses/aux-sample-size=8192/u -- ls
> > 
> > 
> > Can we improve this warning?
> > 
> > [root@quaco ~]# perf record -e intel_pt//u --filter 'filter * @/bin/ls' -e branch-misses/aux-sample-size=8192/u -- ls
> > Error:
> > The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses/aux-sample-size=8192/u).
> > /bin/dmesg | grep -i perf may provide additional information.
> > 
> > [root@quaco ~]#
> > [root@quaco ~]# uname -a
> > Linux quaco 5.4.0-rc8 #1 SMP Mon Nov 18 06:15:31 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
> > [root@quaco ~]#
> 
> Ditto for this other example:
> 
> [root@quaco ~]# perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
> Error:
> The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses:u).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@quaco ~]#

I mean on follow up patches, I'm applying this series now as-is.
  
> > > +
> > > +It is important to select a sample size that is big enough to contain at least
> > > +one PSB packet.  If not a warning will be displayed:
> > > +
> > > +	Intel PT sample size (%zu) may be too small for PSB period (%zu)
> > > +
> > > +The calculation used for that is: if sample_size <= psb_period + 256 display the
> > > +warning.  When sampling is used, psb_period defaults to 0 (2KiB).
> > > +
> > > +The default sample size is 4KiB.
> > > +
> > > +The sample size is passed in aux_sample_size in struct perf_event_attr.  The
> > > +sample size is limited by the maximum event size which is 64KiB.  It is
> > > +difficult to know how big the event might be without the trace sample attached,
> > > +but the tool validates that the sample size is not greater than 60KiB.
> > > +
> > > +
> > >  new snapshot option
> > >  -------------------
> > >  
> > > @@ -487,8 +537,8 @@ their mlock limit (which defaults to 64KiB but is not multiplied by the number
> > >  of cpus).
> > >  
> > >  In full-trace mode, powers of two are allowed for buffer size, with a minimum
> > > -size of 2 pages.  In snapshot mode, it is the same but the minimum size is
> > > -1 page.
> > > +size of 2 pages.  In snapshot mode or sampling mode, it is the same but the
> > > +minimum size is 1 page.
> > >  
> > >  The mmap size and auxtrace mmap size are displayed if the -vv option is used e.g.
> > >  
> > > @@ -501,12 +551,17 @@ Intel PT modes of operation
> > >  
> > >  Intel PT can be used in 2 modes:
> > >  	full-trace mode
> > > +	sample mode
> > >  	snapshot mode
> > >  
> > >  Full-trace mode traces continuously e.g.
> > >  
> > >  	perf record -e intel_pt//u uname
> > >  
> > > +Sample mode attaches a Intel PT sample to other events e.g.
> > > +
> > > +	perf record --aux-sample -e intel_pt//u -e branch-misses:u
> > > +
> > >  Snapshot mode captures the available data when a signal is sent e.g.
> > >  
> > >  	perf record -v -e intel_pt//u -S ./loopy 1000000000 &
> > > diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
> > > index 96f4a2c11893..092543cad324 100644
> > > --- a/tools/perf/arch/x86/util/auxtrace.c
> > > +++ b/tools/perf/arch/x86/util/auxtrace.c
> > > @@ -26,6 +26,8 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
> > >  	bool found_bts = false;
> > >  
> > >  	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
> > > +	if (intel_pt_pmu)
> > > +		intel_pt_pmu->auxtrace = true;
> > >  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
> > >  
> > >  	evlist__for_each_entry(evlist, evsel) {
> > > diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> > > index d6d26256915f..20df442fdf36 100644
> > > --- a/tools/perf/arch/x86/util/intel-pt.c
> > > +++ b/tools/perf/arch/x86/util/intel-pt.c
> > > @@ -17,6 +17,7 @@
> > >  #include "../../util/event.h"
> > >  #include "../../util/evlist.h"
> > >  #include "../../util/evsel.h"
> > > +#include "../../util/evsel_config.h"
> > >  #include "../../util/cpumap.h"
> > >  #include "../../util/mmap.h"
> > >  #include <subcmd/parse-options.h>
> > > @@ -551,6 +552,43 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
> > >  					evsel->core.attr.config);
> > >  }
> > >  
> > > +static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,
> > > +					struct evsel *evsel)
> > > +{
> > > +	struct perf_evsel_config_term *term;
> > > +	u64 user_bits = 0, bits;
> > > +
> > > +	term = perf_evsel__get_config_term(evsel, CFG_CHG);
> > > +	if (term)
> > > +		user_bits = term->val.cfg_chg;
> > > +
> > > +	bits = perf_pmu__format_bits(&intel_pt_pmu->format, "psb_period");
> > > +
> > > +	/* Did user change psb_period */
> > > +	if (bits & user_bits)
> > > +		return;
> > > +
> > > +	/* Set psb_period to 0 */
> > > +	evsel->core.attr.config &= ~bits;
> > > +}
> > > +
> > > +static void intel_pt_min_max_sample_sz(struct evlist *evlist,
> > > +				       size_t *min_sz, size_t *max_sz)
> > > +{
> > > +	struct evsel *evsel;
> > > +
> > > +	evlist__for_each_entry(evlist, evsel) {
> > > +		size_t sz = evsel->core.attr.aux_sample_size;
> > > +
> > > +		if (!sz)
> > > +			continue;
> > > +		if (min_sz && (sz < *min_sz || !*min_sz))
> > > +			*min_sz = sz;
> > > +		if (max_sz && sz > *max_sz)
> > > +			*max_sz = sz;
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * Currently, there is not enough information to disambiguate different PEBS
> > >   * events, so only allow one.
> > > @@ -606,6 +644,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	if (opts->auxtrace_snapshot_mode && opts->auxtrace_sample_mode) {
> > > +		pr_err("Snapshot mode (" INTEL_PT_PMU_NAME " PMU) and sample trace cannot be used together\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >  	if (opts->use_clockid) {
> > >  		pr_err("Cannot use clockid (-k option) with " INTEL_PT_PMU_NAME "\n");
> > >  		return -EINVAL;
> > > @@ -617,6 +660,9 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> > >  	if (!opts->full_auxtrace)
> > >  		return 0;
> > >  
> > > +	if (opts->auxtrace_sample_mode)
> > > +		intel_pt_config_sample_mode(intel_pt_pmu, intel_pt_evsel);
> > > +
> > >  	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
> > >  	if (err)
> > >  		return err;
> > > @@ -666,6 +712,34 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> > >  				    opts->auxtrace_snapshot_size, psb_period);
> > >  	}
> > >  
> > > +	/* Set default sizes for sample mode */
> > > +	if (opts->auxtrace_sample_mode) {
> > > +		size_t psb_period = intel_pt_psb_period(intel_pt_pmu, evlist);
> > > +		size_t min_sz = 0, max_sz = 0;
> > > +
> > > +		intel_pt_min_max_sample_sz(evlist, &min_sz, &max_sz);
> > > +		if (!opts->auxtrace_mmap_pages && !privileged &&
> > > +		    opts->mmap_pages == UINT_MAX)
> > > +			opts->mmap_pages = KiB(256) / page_size;
> > > +		if (!opts->auxtrace_mmap_pages) {
> > > +			size_t sz = round_up(max_sz, page_size) / page_size;
> > > +
> > > +			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
> > > +		}
> > > +		if (max_sz > opts->auxtrace_mmap_pages * (size_t)page_size) {
> > > +			pr_err("Sample size %zu must not be greater than AUX area tracing mmap size %zu\n",
> > > +			       max_sz,
> > > +			       opts->auxtrace_mmap_pages * (size_t)page_size);
> > > +			return -EINVAL;
> > > +		}
> > > +		pr_debug2("Intel PT min. sample size: %zu max. sample size: %zu\n",
> > > +			  min_sz, max_sz);
> > > +		if (psb_period &&
> > > +		    min_sz <= psb_period + INTEL_PT_PSB_PERIOD_NEAR)
> > > +			ui__warning("Intel PT sample size (%zu) may be too small for PSB period (%zu)\n",
> > > +				    min_sz, psb_period);
> > > +	}
> > > +
> > >  	/* Set default sizes for full trace mode */
> > >  	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> > >  		if (privileged) {
> > > @@ -682,7 +756,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> > >  		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> > >  		size_t min_sz;
> > >  
> > > -		if (opts->auxtrace_snapshot_mode)
> > > +		if (opts->auxtrace_snapshot_mode || opts->auxtrace_sample_mode)
> > >  			min_sz = KiB(4);
> > >  		else
> > >  			min_sz = KiB(8);
> > > @@ -1136,5 +1210,10 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
> > >  	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
> > >  	ptr->itr.reference = intel_pt_reference;
> > >  	ptr->itr.read_finish = intel_pt_read_finish;
> > > +	/*
> > > +	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
> > > +	 * should give at least 1 PSB per sample.
> > > +	 */
> > > +	ptr->itr.default_aux_sample_size = 4096;
> > >  	return &ptr->itr;
> > >  }
> > > -- 
> > > 2.17.1
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
