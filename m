Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5080FE4FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKOShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:37:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:33865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfKOShk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:37:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="288631716"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2019 10:37:39 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 36B113010AB; Fri, 15 Nov 2019 10:37:39 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:37:39 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/12] perf stat: Use affinity for reading
Message-ID: <20191115183739.GC22747@tassilo.jf.intel.com>
References: <20191112005941.649137-1-andi@firstfloor.org>
 <20191112005941.649137-11-andi@firstfloor.org>
 <20191115145535.GC4255@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115145535.GC4255@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index ca82a93960cd..c8af4bc23f8f 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -86,6 +86,7 @@ struct evsel {
> >  	struct list_head	config_terms;
> >  	struct bpf_object	*bpf_obj;
> >  	int			bpf_fd;
> > +	int			err;
> 
> I was wondering what would be the best place for this,
> and all the previous variables u added and this one
> are stat specific, so I think this all belongs to
>   
>   (struct perf_stat_evsel*) evsel->stat

I hope to eventually make perf record use affinity too.
Just not in this patchkit. So I'll keep them in the generic
evsel for now.

-Andi
