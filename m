Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3FE835E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 09:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfJ2Il4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 04:41:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfJ2Il4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:41:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46353B039;
        Tue, 29 Oct 2019 08:41:54 +0000 (UTC)
Date:   Tue, 29 Oct 2019 09:41:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2] mm: add page preemption
Message-ID: <20191029084153.GD31513@dhcp22.suse.cz>
References: <20191026112808.14268-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26-10-19 19:28:08, Hillf Danton wrote:
> 
> The cpu preemption feature makes a task able to preempt other tasks
> of lower priorities for cpu. It has been around for a while.
> 
> This work introduces task prio into page reclaiming in order to add
> the page preemption feature that makes a task able to preempt other
> tasks of lower priorities for page.
> 
> No page will be reclaimed on behalf of tasks of lower priorities
> under pp, a two-edge feature that functions only under memory
> pressure, laying a barrier to pages flowing to lower prio, and the
> nice syscall is what users need to fiddle with it for instance as
> no task will be preempted without prio shades, if they have a couple
> of workloads that are sensitive to jitters in lru pages, and some
> difficulty predicting their working set sizes.
> 
> Currently lru pages are reclaimed under memory pressure without prio
> taken into account; pages can be reclaimed from tasks of lower
> priorities on behalf of higher-prio tasks and vice versa.
> 
> s/and vice versa/only/ is what we need to make pp by definition, but
> it could not make a sense without prio introduced in reclaiming,
> otherwise we can simply skip deactivating the lru pages based on prio
> comprison, and work is done.
> 
> The introduction consists of two parts. On the page side, we have to
> store the page owner task's prio in page, which needs an extra room the
> size of the int type in the page struct.
> 
> That room sounds impossible without inflating the page struct size, and
> it is not solved but walked around by sharing room with the 32-bit numa
> balancing, see 75980e97dacc ("mm: fold page->_last_nid into page->flags
> where possible").
> 
> On the reclaimer side, kswapd's prio is set with the prio of its waker,
> and updated in the same manner as kswapd_order.
> 
> V2 is based on next-20191018.
> 
> Changes since v1
> - page->prio shares room with _last_cpupid as per Matthew Wilcox
> 
> Changes since v0
> - s/page->nice/page->prio/
> - drop the role of kswapd's reclaiming prioirty in prio comparison
> - add pgdat->kswapd_prio
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Hillf Danton <hdanton@sina.com>

As already raised in the review of v1. There is no real life usecase
described in the changelog. I have also expressed concerns about how
such a reclaim would work in the first place (priority inversion,
expensive reclaim etc.). Until that is provided/clarified

Nacked-by: Michal Hocko <mhocko@suse.com>

Please do not ignore review feedback in the future.
-- 
Michal Hocko
SUSE Labs
