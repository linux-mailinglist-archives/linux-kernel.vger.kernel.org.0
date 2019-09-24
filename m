Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9344DBC8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632757AbfIXNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 09:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504934AbfIXNaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:30:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87032AF89;
        Tue, 24 Sep 2019 13:30:17 +0000 (UTC)
Date:   Tue, 24 Sep 2019 15:30:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm: memcg: add priority for soft limit reclaiming
Message-ID: <20190924133016.GT23050@dhcp22.suse.cz>
References: <20190924073642.3224-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924073642.3224-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 15:36:42, Hillf Danton wrote:
> 
> On Mon, 23 Sep 2019 21:28:34 Michal Hocko wrote:
> > 
> > On Mon 23-09-19 21:04:59, Hillf Danton wrote:
> > >
> > > On Thu, 19 Sep 2019 21:32:31 +0800 Michal Hocko wrote:
> > > >
> > > > On Thu 19-09-19 21:13:32, Hillf Danton wrote:
> > > > >
> > > > > Currently memory controler is playing increasingly important role in
> > > > > how memory is used and how pages are reclaimed on memory pressure.
> > > > >
> > > > > In daily works memcg is often created for critical tasks and their pre
> > > > > configured memory usage is supposed to be met even on memory pressure.
> > > > > Administrator wants to make it configurable that the pages consumed by
> > > > > memcg-B can be reclaimed by page allocations invoked not by memcg-A but
> > > > > by memcg-C.
> > > >
> > > > I am not really sure I understand the usecase well but this sounds like
> > > > what memory reclaim protection in v2 is aiming at.
> > > >
> > Please describe the usecase.
> > 
> It is for quite a while that task-A has been able to preempt task-B for
> cpu cycles. IOW the physical resource cpu cycles are preemptible.
> 
> Are physical pages are preemptible too in the same manner?
> Nope without priority defined for pages currently (say the link between
> page->nice and task->nice).
> 
> The slrp is added for memcg instead of nice because 1) it is only used
> in the page reclaiming context (in memcg it is soft limit reclaiming),
> and 2) it is difficult to compare reclaimer and reclaimee task->nice
> directly in that context as only info about reclaimer and lru page is
> available.
> 
> Here task->nice is replaced with memcg->slrp in order to do page
> preemption, PP. There is no way for task-A to PP task-B, but the
> group containing task-A can PP the group containing task-B.
> That preemption needs code within 100 lines as you see on top of
> the current memory controller framework.

This is exactly what the reclaim protection in memcg v2 is meant to be
used for. Also soft limit reclaim is absolutely terrible to achieve that
because it is just too gross to result in any smooth experience (just
have a look how it is doing priority 0 scannig!).

I am not going to even go further wrt the implementation because I
belive the priority is even semantically broken wrt hierarchical
behavior.

But really, make sure you look into the existing feature set that memcg
v2 provides already and come back if you find it unsuitable and we can
move from there. Soft limit reclaim is dead and we should let it RIP.
-- 
Michal Hocko
SUSE Labs
