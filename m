Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955377A8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfG3Mjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:39:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfG3Mjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:39:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so30002613pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ab9+yQllgrxhV1PV/fDiWkVd8KTBl0Z4jc93v/FyaQw=;
        b=YPayV2Tsa3gOdnqXV9g1d7Z1RXrW8NzdVyVVzOilsA1igzI/rHFmlxWqz2QNxpW4U6
         dD5MFPpint7VYr6z8bGMtBS+li8hGGd4Nu1XQkS7keaj6l/7tg/mAyHSxedtcGS9wFw6
         9sJgyM95LXS43bfOXzUMz6mCasAm7hzL44R90nb1HLTsJewZ4NcItRMQpRzVNSKcTpb1
         58FaOZwjOG0vLlee5mEg2Axr4+CZnXJwJP36yn4oI9ZOOP3a3cOPAi1CPhNv/AQ+E+Gx
         nbtaK5VP7nEcHtlYX8cu2649N1q2zeVjHVwCVQaPys5UeyUD8TWr/IT8oWKWqYsSyFdJ
         zK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ab9+yQllgrxhV1PV/fDiWkVd8KTBl0Z4jc93v/FyaQw=;
        b=YTVoONryBZdDgLt/R8sTaSFPFsn73cqmVzgdDMaef5iC1mnh7LDuMv9VeV4p+EEI83
         Xh+57tR0Nn7qy/D7VpkeQsJyZeaNEJKxOA3gQ8+CiezIniWWtNkqjgPtnkmnOPhmeswe
         3tFhy8vZCBPQYt3ANZ43OFszcxSYSh8sabioZADjvLJCuTgFJXNpEA0138y2KRwu2N+4
         YKQofsVNKT/LOBcQbinCfLufMyZ5HCdzGXTMJn3cofIx4Urey2oIXLewZEa8TbzMoZgM
         ZT22JqV4dEiktwX0pJ8e0oGJ45paU7bxYfsDeSS6/gC1+BzlL5t7sWtm6hgIRtw4NjEx
         Y4tA==
X-Gm-Message-State: APjAAAWD+kbXByO9V2nYA9MTa/Y62WWbyg2rJhpayxdYlwX4LCEqriF9
        Tw80YRcRofhCM5Ea910/5rvHW7yr
X-Google-Smtp-Source: APXvYqyKe+n/nS4aOkmskr/0g93PGfZyD+f/iJDZav+UStfSIraoDl2l/xmMU8fmzTdF6fnjVG6qKQ==
X-Received: by 2002:a63:db47:: with SMTP id x7mr108219665pgi.375.1564490381025;
        Tue, 30 Jul 2019 05:39:41 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k70sm64512464pje.14.2019.07.30.05.39.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 05:39:39 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:39:35 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190730123935.GB184615@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730123237.GR9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:32:37PM +0200, Michal Hocko wrote:
> On Tue 30-07-19 21:11:10, Minchan Kim wrote:
> > On Mon, Jul 29, 2019 at 10:35:15AM +0200, Michal Hocko wrote:
> > > On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> > > > On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > > > > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > > > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > > > > takes above 6ms with preemption disabled easily. When I see that, the
> > > > > > reason is it holds page table spinlock during entire 512 page operation
> > > > > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > > > > run in the time because it could make frame drop or glitch audio problem.
> > > > > 
> > > > > Where is the time spent during the tear down? 512 pages doesn't sound
> > > > > like a lot to tear down. Is it the TLB flushing?
> > > > 
> > > > Miguel confirmed there is no such big latency without mark_page_accessed
> > > > in zap_pte_range so I guess it's the contention of LRU lock as well as
> > > > heavy activate_page overhead which is not trivial, either.
> > > 
> > > Please give us more details ideally with some numbers.
> > 
> > I had a time to benchmark it via adding some trace_printk hooks between
> > pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
> > device is 2018 premium mobile device.
> > 
> > I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
> > task runs on little core even though it doesn't have any IPI and LRU
> > lock contention. It's already too heavy.
> > 
> > If I remove activate_page, 35-40% overhead of zap_pte_range is gone
> > so most of overhead(about 0.7ms) comes from activate_page via
> > mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
> > accumulate up to several ms.
> 
> Thanks for this information. This is something that should be a part of
> the changelog. I am sorry to still poke into this because I still do not

I will include it.

> have a full understanding of what is going on and while I do not object
> to drop the spinlock I still suspect this is papering over a deeper
> problem.

I couldn't come up with better solution. Feel free to suggest it.

> 
> If mark_page_accessed is really expensive then why do we even bother to
> do it in the tear down path in the first place? Why don't we simply set
> a referenced bit on the page to reflect the young pte bit? I might be
> missing something here of course.

commit bf3f3bc5e73
Author: Nick Piggin <npiggin@suse.de>
Date:   Tue Jan 6 14:38:55 2009 -0800

    mm: don't mark_page_accessed in fault path

    Doing a mark_page_accessed at fault-time, then doing SetPageReferenced at
    unmap-time if the pte is young has a number of problems.

    mark_page_accessed is supposed to be roughly the equivalent of a young pte
    for unmapped references. Unfortunately it doesn't come with any context:
    after being called, reclaim doesn't know who or why the page was touched.

    So calling mark_page_accessed not only adds extra lru or PG_referenced
    manipulations for pages that are already going to have pte_young ptes anyway,
    but it also adds these references which are difficult to work with from the
    context of vma specific references (eg. MADV_SEQUENTIAL pte_young may not
    wish to contribute to the page being referenced).

    Then, simply doing SetPageReferenced when zapping a pte and finding it is
    young, is not a really good solution either. SetPageReferenced does not
    correctly promote the page to the active list for example. So after removing
    mark_page_accessed from the fault path, several mmap()+touch+munmap() would
    have a very different result from several read(2) calls for example, which
    is not really desirable.

    Signed-off-by: Nick Piggin <npiggin@suse.de>
    Acked-by: Johannes Weiner <hannes@saeurebad.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
