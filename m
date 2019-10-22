Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9DE0575
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfJVNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:49:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731035AbfJVNtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:49:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D6D6AFA8;
        Tue, 22 Oct 2019 13:49:51 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:49:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
Message-ID: <20191022134950.GQ9379@dhcp22.suse.cz>
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
 <20191018074411.GC5017@dhcp22.suse.cz>
 <0b05c135-4762-e745-5289-58ee84cc8c3e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b05c135-4762-e745-5289-58ee84cc8c3e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 07:54:20, Dave Hansen wrote:
> On 10/18/19 12:44 AM, Michal Hocko wrote:
> > How does this compare to
> > http://lkml.kernel.org/r/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com
> 
> It's a _bit_ more tied to persistent memory and it appears a bit more
> tied to two tiers rather something arbitrarily deep.  They're pretty
> similar conceptually although there are quite a few differences.
> 
> For instance, what I posted has a static mapping for the migration path.
>  If node A is in reclaim, we always try to allocate pages on node B.
> There are no restrictions on what those nodes can be.  In Yang Shi's
> apporach, there's a dynamic search for a target migration node on each
> migration that follows the normal alloc fallback path.  This ends up
> making migration nodes special.

As we have discussed at LSFMM this year and there seemed to be a goog
consensus on that, the resulting implementation should be as pmem
neutral as possible. After all node migration mode sounds like a
reasonable feature even without pmem. So I would be more inclined to the
normal alloc fallback path rather than a very specific and static
migration fallback path. If that turns out impractical then sure let's
come up with something more specific but I think there is quite a long
route there because we do not really have much of an experience with
this so far.

> There are also some different choices that are pretty arbitrary.  For
> instance, when you allocation a migration target page, should you cause
> memory pressure on the target?

Those are details to really sort out and they require some
experimentation to.

> To be honest, though, I don't see anything fatally flawed with it.  It's
> probably a useful exercise to factor out the common bits from the two
> sets and see what we can agree on being absolutely necessary.

Makes sense. What would that be? Is there a real consensus on having the
new node_reclaim mode to be the configuration mechanism? Do we want to
support generic NUMA without any PMEM in place as well for starter?

Thanks!
-- 
Michal Hocko
SUSE Labs
