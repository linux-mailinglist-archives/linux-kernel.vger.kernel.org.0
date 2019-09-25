Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5878CBD877
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442329AbfIYGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 02:45:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436692AbfIYGpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:45:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43262AC8E;
        Wed, 25 Sep 2019 06:45:18 +0000 (UTC)
Date:   Wed, 25 Sep 2019 08:45:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, rientjes@google.com,
        ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, hannes@cmpxchg.org, cai@lca.pw
Subject: Re: + mm-thp-extract-split_queue_-into-a-struct.patch added to -mm
 tree
Message-ID: <20190925064516.GE23050@dhcp22.suse.cz>
References: <20190923220902.-_eJc%akpm@linux-foundation.org>
 <20190924135608.GW23050@dhcp22.suse.cz>
 <1d13fbe3-2a25-3b31-64a5-50d511c201f4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d13fbe3-2a25-3b31-64a5-50d511c201f4@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 09:26:37, Yang Shi wrote:
> 
> 
> On 9/24/19 6:56 AM, Michal Hocko wrote:
> > Do we really need this if deferred list is going to be shrunk more
> > pro-actively as discussed already - I am sorry I do not have a link handy
> > but in short the deferred list would be drained from a kworker context
> > more pro-actively rather than wait for the memory pressure to happen.
> 
> From our experience I really didn't see the current waiting for memory
> pressure approach is a problem, it does work well and is still a good
> compromise. And, I'm supposed we all agree the side effect incurred by the
> more proactive kworker approach is definitely a concern (i.e. may waste cpu
> cycles, break isolation, etc) according to our discussion.
>
> And we do have other much simpler ways to shrink THPs more proactively, for
> example, waking up kswapd more aggressively via tuning
> watermark_scale_factor, and/or do shrinking harder, etc.

No, we do not want to make THPs even more tricky to configure then they
are now. There are many howtos out there to recommend disabling THPs
because they might have performance or other subtle side effects. I do
not want to feed that cargo cult even more. Really users shouldn't even
notice that THPs are split because that is so much of an internal
implementation detail. Now the existing implementation really hides a
lot of memory and it requires some expertise to understand where that
memory went. And the later part is something users tend to care about
from experience.

So I really do think that waiting for the memory pressure is simply a
wrong thing to do. It causes unnecessary reclaim because some
of the pages are going to be dropped before the shrinker can act.

> Even though we have to drain THPs more proactively by whatever means in the
> future, I'd prefer it is memcg aware as well.

OK, let's keep it then until we have another means for pro-active
draining.
-- 
Michal Hocko
SUSE Labs
