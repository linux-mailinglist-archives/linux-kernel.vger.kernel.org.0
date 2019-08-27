Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA79E74A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfH0MDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:03:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfH0MDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:03:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B89AAFC2;
        Tue, 27 Aug 2019 12:03:36 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:03:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
Message-ID: <20190827120335.GA7538@dhcp22.suse.cz>
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
 <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz>
 <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
 <20190827115014.GZ7538@dhcp22.suse.cz>
 <CALOAHbAtuQFB=GC41ZgSLXxheaEY4yz=fO9Zr5=rvTnyOYjF3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAtuQFB=GC41ZgSLXxheaEY4yz=fO9Zr5=rvTnyOYjF3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 19:56:16, Yafang Shao wrote:
> On Tue, Aug 27, 2019 at 7:50 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 27-08-19 19:43:49, Yafang Shao wrote:
> > > On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > If there are no objection to the patch I will post it as a standalong
> > > > one.
> > >
> > > I have no objection to your patch. It could fix the issue.
> > >
> > > I still think that it is not proper to use a new scan_control here as
> > > it breaks the global reclaim context.
> > >
> > > This context switch from global reclaim to memcg reclaim is very
> > > subtle change to the subsequent processing, that may cause some
> > > unexpected behavior.
> >
> > Why would it break it? Could you be more specific please?
> >
> 
> Hmm, I have explained it when replying to  Hillf's patch.
> The most suspcious one is settting target_mem_cgroup here, because we
> only use it to judge whether it is in global reclaim.
> While the memcg softlimit reclaim is really in global reclaims.

But we are reclaim the target_mem_cgroup hierarchy. This is the whole
point of the soft reclaim. Push down that hierarchy below the configured
limit. And that is why we absolutely have to switch the reclaim context.

> Another example the reclaim_idx, if is not same with reclaim_idx in
> page allocation context, the reclaimed pages may not be used by the
> allocator, especially in the direct reclaim.

Again, we do not care about that as well. All we care about is to
reclaim _some_ memory to get below the soft limit. This is the semantic
that is not really great but this is how the Soft reclaim has
traditionally worked and why we keep claiming that people shouldn't
really use it. It does lead to over reclaim and that is a design rather
than a bug.

> And some other things in scan_control.

Like?
-- 
Michal Hocko
SUSE Labs
