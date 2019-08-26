Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633FD9CDA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfHZKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 06:55:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:55652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfHZKzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:55:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD0AFABD9;
        Mon, 26 Aug 2019 10:55:22 +0000 (UTC)
Date:   Mon, 26 Aug 2019 12:55:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Adric Blake <promarbler14@gmail.com>, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, hannes@cmpxchg.org,
        daniel.m.jordan@oracle.com, laoar.shao@gmail.com,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
Message-ID: <20190826105521.GF7538@dhcp22.suse.cz>
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-08-19 18:03:01, Yang Shi wrote:
> 
> 
> On 8/23/19 3:00 PM, Adric Blake wrote:
> > Synopsis:
> > A WARN_ON_ONCE is hit twice in set_task_reclaim_state under the
> > following conditions:
> > - a memory cgroup has been created and a task assigned it it
> > - memory.limit_in_bytes has been set
> > - memory has filled up, likely from cache
> > 
> > In my usage, I create a cgroup under the current session scope and
> > assign a task to it. I then set memory.limit_in_bytes and
> > memory.soft_limit_in_bytes for the cgroup to reasonable values, say
> > 1G/512M. The program accesses large files frequently and gradually
> > fills memory with the page cache. The warnings appears when the
> > entirety of the system memory is filled, presumably from other
> > programs.
> > 
> > If I wait until the program has filled the entirety of system memory
> > with cache and then assign a memory limit, the warnings appear
> > immediately.
> 
> It looks the warning is triggered because kswapd set reclaim_state then the
> memcg soft limit reclaim in the same kswapd set it again.

Yes, this is indeed the case. The same seems possible from the direct
reclaim AFAICS.

> But, kswapd and memcg soft limit uses different reclaim_state from different
> scan control. It sounds not correct, they should use the same reclaim_state
> if they come from the same context if my understanding is correct.

I haven't checked very closely and I might be wrong but setting the
reclaim state from the mem_cgroup_shrink_node doesn't make any sense in
the current code. The soft limit is always called from the global
reclaim and both kswapd and the direct reclaim already track reclaim
state correctly. We just haven't noticed until now beause the warning is
quite recent and mostly likely only few people tend to use soft limit
these days.

That being said, we should simply do this instead:

From 59d128214a62bf2d83c2a2a9cde887b4817275e7 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 26 Aug 2019 12:43:15 +0200
Subject: [PATCH] mm, memcg: do not set reclaim_state on soft limit reclaim

Adric Blake has noticed the following warning:
[38491.963105] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:245 set_task_reclaim_state+0x1e/0x40
[...]
[38491.963239] Call Trace:
[38491.963246]  mem_cgroup_shrink_node+0x9b/0x1d0
[38491.963250]  mem_cgroup_soft_limit_reclaim+0x10c/0x3a0
[38491.963254]  balance_pgdat+0x276/0x540
[38491.963258]  kswapd+0x200/0x3f0
[38491.963261]  ? wait_woken+0x80/0x80
[38491.963265]  kthread+0xfd/0x130
[38491.963267]  ? balance_pgdat+0x540/0x540
[38491.963269]  ? kthread_park+0x80/0x80
[38491.963273]  ret_from_fork+0x35/0x40
[38491.963276] ---[ end trace 727343df67b2398a ]---

which tells us that soft limit reclaim is about to overwrite the
reclaim_state configured up in the call chain (kswapd in this case but
the direct reclaim is equally possible). This means that reclaim stats
would get misleading once the soft reclaim returns and another reclaim
is done.

Fix the warning by dropping set_task_reclaim_state from the soft reclaim
which is always called with reclaim_state set up.

Reported-by: Adric Blake <promarbler14@gmail.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c77d1e3761a7..a6c5d0b28321 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3220,6 +3220,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #ifdef CONFIG_MEMCG
 
+/* Only used by soft limit reclaim. Do not reuse for anything else. */
 unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
@@ -3235,7 +3236,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	};
 	unsigned long lru_pages;
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
+	WARN_ON_ONCE(!current->reclaim_state);
+
 	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
@@ -3253,7 +3255,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
-	set_task_reclaim_state(current, NULL);
 	*nr_scanned = sc.nr_scanned;
 
 	return sc.nr_reclaimed;
-- 
2.20.1

-- 
Michal Hocko
SUSE Labs
