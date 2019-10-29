Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91BE834E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 09:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfJ2Ihf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 04:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbfJ2Ihf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11716AE87;
        Tue, 29 Oct 2019 08:37:32 +0000 (UTC)
Date:   Tue, 29 Oct 2019 09:37:30 +0100
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
Subject: Re: [RFC v2] memcg: add memcg lru for page reclaiming
Message-ID: <20191029083730.GC31513@dhcp22.suse.cz>
References: <20191026110745.12956-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026110745.12956-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26-10-19 19:07:45, Hillf Danton wrote:
> 
> Currently soft limit reclaim is frozen, see
> Documentation/admin-guide/cgroup-v2.rst for reasons.
> 
> This work adds memcg hook into kswapd's logic to bypass slr,
> paving a brick for its cleanup later.
> 
> After b23afb93d317 ("memcg: punt high overage reclaim to
> return-to-userland path"), high limit breachers are reclaimed one
> after another spiraling up through the memcg hierarchy before
> returning to userspace.
> 
> We can not add new hook yet if it is infeasible to defer that
> reclaiming a bit further until kswapd becomes active.
> 
> It can be defered however because high limit breach looks benign
> in the absence of memory pressure, or we ensure it will be
> reclaimed soon in the presence of kswapd.

This is not true and I have already expressed that in a responsoce to
the v1 of this patch. Let me repeat (for the last time hopefully) the
high limit is aimed at throttling allocators even when the system is not
under a memory pressure. So no, we cannot defer to kswapd.

This patchset is ignoring the previous review feedback. You still
haven't described any real usecase and any reasons why the existing
feature list doesn't satisfy it.

Until this is sorted out:
Nacked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
