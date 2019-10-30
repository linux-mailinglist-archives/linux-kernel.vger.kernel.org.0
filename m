Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9488CE9FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfJ3PvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 11:51:12 -0400
Received: from one.firstfloor.org ([193.170.194.197]:38256 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfJ3PvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:51:11 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id B1E7A8675A; Wed, 30 Oct 2019 16:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1572450668;
        bh=buEPZYQ7PmpiAS8Dp8tUdF7+RuFJhqEE6l218Vxc664=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArfLXauaLFv2U7MBhT/k/YmlaTaS3l0BH/jECja1dEbxncGHZr4wB8HAK9fbiHFds
         HUYpWud+ngjxG+hsUYJxtnxtNXmdDFemEeTz3pZuGka5WfBuBCqs1DNFgd/2NUgDVS
         SFpMfH1BuPuHenAvtZ+whKELqVs4/Esed/yIPTz4=
Date:   Wed, 30 Oct 2019 08:51:08 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events
 ordered by CPU
Message-ID: <20191030155108.taqo2kbuaro3idhe@two.firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-4-andi@firstfloor.org>
 <20191030100606.GG20826@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030100606.GG20826@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:06:06AM +0100, Jiri Olsa wrote:
> > +struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist)
> > +{
> > +	struct perf_cpu_map *cpus;
> > +	struct evsel *pos;
> > +
> > +	/*
> > +	 * evlist->cpus is not necessarily a superset of all the
> > +	 * event's cpus, so compute our own super set. This
> > +	 * assume that there is a super set
> > +	 */
> > +	cpus = evlist->core.cpus;
> > +	evlist__for_each_entry(evlist, pos) {
> > +		pos->cpu_index = 0;
> > +		if (pos->core.cpus->nr > cpus->nr)
> > +			cpus = pos->core.cpus;
> > +	}
> > +	return cpus;
> 
> I might not understand the reason for cpu_index, but 

This is just so that we can iterate each event's map
independently.

> imagine something like below should be enough, no?

Well it's more complicated because evlist->all_cpus doesn't exist.
The exists evlist->cpus cannot be used (I tried that)
I also don't think we have an existing function to merge
two maps, so that would need to be added to create it.
Just using ->cpu_index is a much simpler change.


-Andi
