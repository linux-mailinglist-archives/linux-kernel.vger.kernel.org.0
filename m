Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACD19AC73
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgDANOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 09:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbgDANOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:14:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87DBAABAE;
        Wed,  1 Apr 2020 13:14:31 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:14:26 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401131426.GN3772@suse.de>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331160117.GA170994@google.com>
 <20200401072359.GC22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200401072359.GC22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:23:59AM +0200, Michal Hocko wrote:
> > Can you suggest what prevents other users of GFP_MEMALLOC from doing that
> > also? 
> 
> There is no explicit mechanism which is indeed unfortunate. The only
> user real user of the flag is Swap over NFS AFAIK. I have never dared to
> look into details on how the complete reserves depletion is prevented.
> Mel would be much better fit here.
> 

It's "prevented" by the fact that every other memory allocation request
that is not involved with reclaiming memory gets stalled in the allocator
with only the swap subsystem making any progress until the machine
recovers. Potentially only kswapd is still running until the system
recovers if stressed hard enough.

The naming is terrible but is mased on kswapd's use of the PF_MEMALLOC
flag. For swap-over-nfs, GFP_MEMALLOC saying "this allocation request is
potentially needed for kswapd to make forward progress and not freeze".

I would not be comfortable with kfree_rcu() doing the same thing because
there can be many callers in parallel and it's freeing slab objects.
Swap over NFS should free at least one page, freeing a slab object is
not guaranteed to free anything.

-- 
Mel Gorman
SUSE Labs
