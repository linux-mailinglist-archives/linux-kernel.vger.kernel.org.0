Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77676E05A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbfJVN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:58:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727960AbfJVN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:58:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7513B444;
        Tue, 22 Oct 2019 13:58:33 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:58:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v1] memcg: add memcg lru for page reclaiming
Message-ID: <20191022135832.GR9379@dhcp22.suse.cz>
References: <20191021115654.14740-1-hdanton@sina.com>
 <20191022133050.15620-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022133050.15620-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 21:30:50, Hillf Danton wrote:
> 
> On Mon, 21 Oct 2019 14:14:53 +0200 Michal Hocko wrote:
> > 
> > On Mon 21-10-19 19:56:54, Hillf Danton wrote:
> > > 
> > > Currently soft limit reclaim is frozen, see
> > > Documentation/admin-guide/cgroup-v2.rst for reasons.
> > > 
> > > Copying the page lru idea, memcg lru is added for selecting victim
> > > memcg to reclaim pages from under memory pressure. It now works in
> > > parallel to slr not only because the latter needs some time to reap
> > > but the coexistence facilitates it a lot to add the lru in a straight
> > > forward manner.
> > 
> > This doesn't explain what is the problem/feature you would like to
> > fix/achieve. It also doesn't explain the overall design. 
> 
> 1, memcg lru makes page reclaiming hierarchy aware

Is that a problem statement or a design goal?

> While doing the high work, memcgs are currently reclaimed one after
> another up through the hierarchy;

Which is the design because it is the the memcg where the high limit got
hit. The hierarchical behavior ensures that the subtree of that memcg is
reclaimed and we try to spread the reclaim fairly over the tree.

> in this RFC after ripping pages off
> the first victim, the work finishes with the first ancestor of the victim
> added to lru.
> 
> Recaliming is defered until kswapd becomes active.

This is a wrong assumption because high limit might be configured way
before kswapd is woken up.

> 2, memcg lru tries much to avoid overreclaim

Again, is this a problem statement or a design goal?
 
> Only one memcg is picked off lru in FIFO mode under memory pressure,
> and MEMCG_CHARGE_BATCH pages are reclaimed one memcg at a time.

And why is this preferred over SWAP_CLUSTER_MAX and whole subtree
reclaim that we do currently? 

Please do not set another version until it is actually clear what you
want to achieve and why.
-- 
Michal Hocko
SUSE Labs
