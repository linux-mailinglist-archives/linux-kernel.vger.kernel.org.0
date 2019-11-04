Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCDEF136
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfKDXf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 18:35:57 -0500
Received: from one.firstfloor.org ([193.170.194.197]:32986 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKDXf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:35:56 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 0A9598685B; Tue,  5 Nov 2019 00:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1572910554;
        bh=T6WN/3CmGi87L/O4bOPUkr7RqKMi6e4Y71TMqMSUjGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gv07PrwEP8Bu2dcguFy0qJaw0tfu61iCyH0ODEWGE/472MXW7iU1wY7HxfEYFicOi
         38n+lsenDzqx+y4j+AocaFfHQ3b0oCPYf+ltSHW2MikNK+v1U2zLjqFyENCIpceiTe
         xc8qfyf22FZjDtdBdtsoqfoWYNRtRDO3a88T54wQ=
Date:   Mon, 4 Nov 2019 15:35:53 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 4/7] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191104233553.zcjw2u64pggixkka@two.firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-5-andi@firstfloor.org>
 <20191030100554.GE20826@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030100554.GE20826@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  
> > -	evlist__for_each_entry_reverse(evlist, evsel)
> > -		evsel__close(evsel);
> > +	if (affinity__setup(&affinity) < 0)
> > +		return;
> > +	cpus = evlist__cpu_iter_start(evlist);
> > +	cpumap__for_each_cpu (cpus, i, cpu) {
> > +		affinity__set(&affinity, cpu);
> 
> whats the point of affinity->changed flags when we call
> affinity__set unconditionaly? I think we can do without
> it, becase we'll always endup calling affinity__set

No we don't in the per thread case (without -a) 

In this case affinity is never set because there is no cpu.

I added it just to make the strace look nicer in this case.

> 
> however, it seems superfluous to always allocate those
> bitmaps, while we need just the current cpus that we
> run on and also that is probably questionable
> 
> could we put 'struct affinity' to 'struct evlist'
> and get rid of all affinity__setup/cleanup calls?
> (apart from those in evlist__init and evlist__delete)

affinity setup/cleanup is essentially push/pop for the affinity
state. For setup while it could be in theory moved
it would be a bad API because if someone sets up a evlist
inside an affinity region it would save the wrong state.

For cleanup there's nothing that would call it to reset
the affinity.

They could be made global, but that's somewhat ugly
and might also break with threading.


-Andi
