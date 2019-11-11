Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAFF791F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 17:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKKQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 11:50:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:9514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKKQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:50:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="202385368"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2019 08:50:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A39E3301376; Mon, 11 Nov 2019 08:50:28 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:50:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191111165028.GC573472@tassilo.jf.intel.com>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-14-andi@firstfloor.org>
 <20191111140415.GA26980@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111140415.GA26980@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:04:15PM +0100, Jiri Olsa wrote:
> On Thu, Nov 07, 2019 at 10:16:46AM -0800, Andi Kleen wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 33080f79b977..571bb102b432 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
> >  void evlist__disable(struct evlist *evlist)
> >  {
> >  	struct evsel *pos;
> > +	struct affinity affinity;
> > +	int cpu, i;
> 
> should we have the fallback to current code in here (and below) as well?
> also for reading/openning?

The return only happens when you're out of memory, when nothing
will work anyways.

-Andi

> 
> jirka
> 
> > +
> > +	if (affinity__setup(&affinity) < 0)
> > +		return;
