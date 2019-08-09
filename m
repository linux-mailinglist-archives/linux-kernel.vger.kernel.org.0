Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FAC881EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 20:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437358AbfHISCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 14:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437155AbfHISCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:02:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25050AF89;
        Fri,  9 Aug 2019 18:02:46 +0000 (UTC)
Date:   Fri, 9 Aug 2019 20:02:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190809180238.GS18351@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 09:19:13, Yang Shi wrote:
> 
> 
> On 8/9/19 1:32 AM, Michal Hocko wrote:
> > On Fri 09-08-19 07:57:44, Yang Shi wrote:
> > > When doing partial unmap to THP, the pages in the affected range would
> > > be considered to be reclaimable when memory pressure comes in.  And,
> > > such pages would be put on deferred split queue and get minus from the
> > > memory statistics (i.e. /proc/meminfo).
> > > 
> > > For example, when doing THP split test, /proc/meminfo would show:
> > > 
> > > Before put on lazy free list:
> > > MemTotal:       45288336 kB
> > > MemFree:        43281376 kB
> > > MemAvailable:   43254048 kB
> > > ...
> > > Active(anon):    1096296 kB
> > > Inactive(anon):     8372 kB
> > > ...
> > > AnonPages:       1096264 kB
> > > ...
> > > AnonHugePages:   1056768 kB
> > > 
> > > After put on lazy free list:
> > > MemTotal:       45288336 kB
> > > MemFree:        43282612 kB
> > > MemAvailable:   43255284 kB
> > > ...
> > > Active(anon):    1094228 kB
> > > Inactive(anon):     8372 kB
> > > ...
> > > AnonPages:         49668 kB
> > > ...
> > > AnonHugePages:     10240 kB
> > > 
> > > The THPs confusingly look disappeared although they are still on LRU if
> > > you are not familair the tricks done by kernel.
> > Is this a fallout of the recent deferred freeing work?
> 
> This series follows up the discussion happened when reviewing "Make deferred
> split shrinker memcg aware".

OK, so it is a pre-existing problem. Thanks!

> David Rientjes suggested deferred split THP should be accounted into
> available memory since they would be shrunk when memory pressure comes in,
> just like MADV_FREE pages. For the discussion, please refer to:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2010115.html

Thanks for the reference.

> 
> > 
> > > Accounted the lazy free pages to NR_LAZYFREE, and show them in meminfo
> > > and other places.  With the change the /proc/meminfo would look like:
> > > Before put on lazy free list:
> > The name is really confusing because I have thought of MADV_FREE immediately.
> 
> Yes, I agree. We may use a more specific name, i.e. DeferredSplitTHP.
> 
> > 
> > > +LazyFreePages: Cleanly freeable pages under memory pressure (i.e. deferred
> > > +               split THP).
> > What does that mean actually? I have hard time imagine what cleanly
> > freeable pages mean.
> 
> Like deferred split THP and MADV_FREE pages, they could be reclaimed during
> memory pressure.
> 
> If you just go with "DeferredSplitTHP", these ambiguity would go away.

I have to study the code some more but is there any reason why those
pages are not accounted as proper THPs anymore? Sure they are partially
unmaped but they are still THPs so why cannot we keep them accounted
like that. Having a new counter to reflect that sounds like papering
over the problem to me. But as I've said I might be missing something
important here.

-- 
Michal Hocko
SUSE Labs
