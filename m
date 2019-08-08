Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7B86939
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbfHHS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 14:59:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390218AbfHHS72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:59:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 325BEAFD4;
        Thu,  8 Aug 2019 18:59:26 +0000 (UTC)
Date:   Thu, 8 Aug 2019 20:59:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ndrw.xf@redhazel.co.uk
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190808185925.GH18351@dhcp22.suse.cz>
References: <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz>
 <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 18:57:02, ndrw.xf@redhazel.co.uk wrote:
> 
> 
> On 8 August 2019 17:32:28 BST, Michal Hocko <mhocko@kernel.org> wrote:
> >
> >> Would it be possible to reserve a fixed (configurable) amount of RAM
> >for caches,
> >
> >I am afraid there is nothing like that available and I would even argue
> >it doesn't make much sense either. What would you consider to be a
> >cache? A kernel/userspace reclaimable memory? What about any other in
> >kernel memory users? How would you setup such a limit and make it
> >reasonably maintainable over different kernel releases when the memory
> >footprint changes over time?
> 
> Frankly, I don't know. The earlyoom userspace tool works well enough
> for me so I assumed this functionality could be implemented in
> kernel. Default thresholds would have to be tested but it is unlikely
> zero is the optimum value.

Well, I am afraid that implementing anything like that in the kernel
will lead to many regressions and bug reports. People tend to have very
different opinions on when it is suitable to kill a potentially
important part of a workload just because memory gets low.

> >Besides that how does that differ from the existing reclaim mechanism?
> >Once your cache hits the limit, there would have to be some sort of the
> >reclaim to happen and then we are back to square one when the reclaim
> >is
> >making progress but you are effectively treshing over the hot working
> >set (e.g. code pages)
> 
> By forcing OOM killer. Reclaiming memory when system becomes unresponsive is precisely what I want to avoid.
> 
> >> and trigger OOM killer earlier, before most UI code is evicted from
> >memory?
> >
> >How does the kernel knows that important memory is evicted?
> 
> I assume current memory management policy (LRU?) is sufficient to keep most frequently used pages in memory.

LRU aspect doesn't help much, really. If we are reclaiming the same set
of pages becuase they are needed for the workload to operate then we are
effectivelly treshing no matter what kind of replacement policy you are
going to use.


[...]
> >PSI is giving you a matric that tells you how much time you
> >spend on the memory reclaim. So you can start watching the system from
> >lower utilization already.
> 
> This is a fantastic news. Really. I didn't know this is how it
> works. Two potential issues, though:
> 1. PSI (if possible) should be normalised wrt the memory reclaiming
> cost (SSDs have lower cost than HDDs). If not automatically then
> perhaps via a user configurable option. That's somewhat similar to
> having configurable PSI thresholds.

The cost of the reclaim is inherently reflected in those numbers
already because it gives you the amount of time that is spent getting a
memory for you. If you are under a memory pressure then the memory
reclaim is a part of the allocation path.

> 2. It seems PSI measures the _rate_ pages are evicted from
> memory. While this may correlate with the _absolute_ amount of of
> memory left, it is not the same. Perhaps weighting PSI with absolute
> amount of memory used for caches would improve this metric.

Please refer to Documentation/accounting/psi.rst for more information
about how PSI works. 
-- 
Michal Hocko
SUSE Labs
