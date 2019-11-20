Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9F1046A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 23:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKTWbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 17:31:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:58173 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKTWbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:31:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 14:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381524854"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 14:31:01 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A3416300B64; Wed, 20 Nov 2019 14:31:01 -0800 (PST)
Date:   Wed, 20 Nov 2019 14:31:01 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/12] perf stat: Use affinity for opening events
Message-ID: <20191120223101.GB84886@tassilo.jf.intel.com>
References: <20191116055229.62002-1-andi@firstfloor.org>
 <20191116055229.62002-10-andi@firstfloor.org>
 <20191120150732.GE4007@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120150732.GE4007@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		evlist__for_each_cpu (evsel_list, i, cpu) {
> > +			affinity__set(&affinity, cpu);
> > +			/* First close errored or weak retry */
> > +			evlist__for_each_entry(evsel_list, counter) {
> > +				if (!counter->reset_group && !counter->errored)
> > +					continue;
> > +				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> > +					continue;
> > +				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
> > +			}
> > +			/* Now reopen weak */
> > +			evlist__for_each_entry(evsel_list, counter) {
> > +				if (!counter->reset_group && !counter->errored)
> > +					continue;
> > +				if (evsel__cpu_iter_skip(counter, cpu))
> > +					continue;
> 
> why staring at this I wonder why can't we call perf_evsel__close_cpu in
> here and remove the above loop? together with evsel__cpu_iter_skip_no_inc
> function

We only want to close events which errored or need a weak entry.
The others can stay open.  perf_evsel__close_cpu closes all unconditionally.

-Andi
