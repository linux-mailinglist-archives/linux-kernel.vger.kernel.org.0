Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28132874AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406038AbfHII5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 04:57:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405982AbfHII5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA141AFDB;
        Fri,  9 Aug 2019 08:57:49 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:57:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ndrw <ndrw.xf@redhazel.co.uk>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190809085748.GN18351@dhcp22.suse.cz>
References: <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz>
 <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
 <20190808185925.GH18351@dhcp22.suse.cz>
 <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 22:59:32, ndrw wrote:
> On 08/08/2019 19:59, Michal Hocko wrote:
> > Well, I am afraid that implementing anything like that in the kernel
> > will lead to many regressions and bug reports. People tend to have very
> > different opinions on when it is suitable to kill a potentially
> > important part of a workload just because memory gets low.
> 
> Are you proposing having a zero memory reserve or not having such option at
> all? I'm fine with the current default (zero reserve/margin).

We already do have a reserve (min_free_kbytes). That gives kswapd some
room to perform reclaim in the background without obvious latencies to
allocating tasks (well CPU still be used so there is still some effect).

Kswapd tries to keep a balance and free memory low but still with some
room to satisfy an immediate memory demand. Once kswapd doesn't catch up
with the memory demand we dive into the direct reclaim and that is where
people usually see latencies coming from.

The main problem here is that it is hard to tell from a single
allocation latency that we have a bigger problem. As already said, the
usual trashing scenario doesn't show problem during the reclaim because
pages can be freed up very efficiently. The problem is that they are
refaulted very quickly so we are effectively rotating working set like
crazy. Compare that to a normal used-once streaming IO workload which is
generating a lot of page cache that can be recycled in a similar pace
but a working set doesn't get freed. Free memory figures will look very
similar in both cases.

> I strongly prefer forcing OOM killer when the system is still running
> normally. Not just for preventing stalls: in my limited testing I found the
> OOM killer on a stalled system rather inaccurate, occasionally killing
> system services etc. I had much better experience with earlyoom.

Good that earlyoom works for you. All I am saying is that this is not
generally applicable heuristic because we do care about a larger variety
of workloads. I should probably emphasise that the OOM killer is there
as a _last resort_ hand break when something goes terribly wrong. It
operates at times when any user intervention would be really hard
because there is a lack of resources to be actionable.

[...]
> > > > PSI is giving you a matric that tells you how much time you
> > > > spend on the memory reclaim. So you can start watching the system from
> > > > lower utilization already.
> 
> I've tested it on a system with 45GB of RAM, SSD, swap disabled (my
> intention was to approximate a worst-case scenario) and it didn't really
> detect stall before it happened. I can see some activity after reaching
> ~42GB, the system remains fully responsive until it suddenly freezes and
> requires sysrq-f.

This is a useful feedback! What was your workload? Which kernel version?

-- 
Michal Hocko
SUSE Labs
