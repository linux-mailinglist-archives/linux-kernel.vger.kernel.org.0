Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B10CE540
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfJGOad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 10:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbfJGOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:30:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 813DFAFC6;
        Mon,  7 Oct 2019 14:30:31 +0000 (UTC)
Date:   Mon, 7 Oct 2019 16:30:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: move deferred split queue to memcg's nodeinfo
Message-ID: <20191007143030.GN2381@dhcp22.suse.cz>
References: <1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191002084304.GI15624@dhcp22.suse.cz>
 <30421920-4fdb-767a-6ef2-60187932c414@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30421920-4fdb-767a-6ef2-60187932c414@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 16:19:59, Vlastimil Babka wrote:
> On 10/2/19 10:43 AM, Michal Hocko wrote:
> > On Wed 02-10-19 06:16:43, Yang Shi wrote:
> >> The commit 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make
> >> deferred split shrinker memcg aware") makes deferred split queue per
> >> memcg to resolve memcg pre-mature OOM problem.  But, all nodes end up
> >> sharing the same queue instead of one queue per-node before the commit.
> >> It is not a big deal for memcg limit reclaim, but it may cause global
> >> kswapd shrink THPs from a different node.
> >>
> >> And, 0-day testing reported -19.6% regression of stress-ng's madvise
> >> test [1].  I didn't see that much regression on my test box (24 threads,
> >> 48GB memory, 2 nodes), with the same test (stress-ng --timeout 1
> >> --metrics-brief --sequential 72  --class vm --exclude spawn,exec), I saw
> >> average -3% (run the same test 10 times then calculate the average since
> >> the test itself may have most 15% variation according to my test)
> >> regression sometimes (not every time, sometimes I didn't see regression
> >> at all).
> >>
> >> This might be caused by deferred split queue lock contention.  With some
> >> configuration (i.e. just one root memcg) the lock contention my be worse
> >> than before (given 2 nodes, two locks are reduced to one lock).
> >>
> >> So, moving deferred split queue to memcg's nodeinfo to make it NUMA
> >> aware again.
> >>
> >> With this change stress-ng's madvise test shows average 4% improvement
> >> sometimes and I didn't see degradation anymore.
> > 
> > My concern about this getting more and more complex
> > (http://lkml.kernel.org/r/20191002084014.GH15624@dhcp22.suse.cz) holds
> > here even more. Can we step back and reconsider the whole thing please?
> 
> What about freeing immediately after split via workqueue and also have a
> synchronous version called before going oom? Maybe there would be also
> other things that would benefit from this scheme instead of traditional
> reclaim and shrinkers?

That is exactly what we have discussed some time ago.

-- 
Michal Hocko
SUSE Labs
