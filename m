Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7717BCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfGaJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 05:17:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfGaJRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:17:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34942337;
        Wed, 31 Jul 2019 02:17:30 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F2E23F71F;
        Wed, 31 Jul 2019 02:17:29 -0700 (PDT)
Date:   Wed, 31 Jul 2019 10:17:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731091726.GB63307@arrakis.emea.arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
 <20190731090653.GD9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731090653.GD9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:06:53AM +0200, Michal Hocko wrote:
> On Tue 30-07-19 12:57:43, Andrew Morton wrote:
> > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > > Add mempool allocations for struct kmemleak_object and
> > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > under memory pressure. Additionally, mask out all the gfp flags passed
> > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > 
> > > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > > different minimum pool size (defaulting to NR_CPUS * 4).
> > 
> > Why would anyone ever want to alter this?  Is there some particular
> > misbehaviour which this will improve?  If so, what is it?
> 
> I do agree with Andrew here. Can we simply go with no tunning for now
> and only add it based on some real life reports that the auto-tuning is
> not sufficient?

In a first attempt earlier this year, Qian reported that an emergency
pool (subsequently converted to using mempool) with the default pre-fill
does not help under memory pressure:

https://lore.kernel.org/linux-mm/49f77efc-8375-8fc8-aa89-9814bfbfe5bc@lca.pw/

I'm waiting for him to confirm whether the tunable in this patch helps,
otherwise we can look elsewhere, maybe refilling the mempool via other
means than just on free.

In general, not sure we can do much under memory pressure. I'm looking
at adding the kmemleak metadata to the slab itself (though I get some
weird -EEXIST error in kobject_add_internal) but there are still places
where the metadata needs to be allocated directly and, under OOM, this
is prone to failure. I guess we'll have to live with this.

-- 
Catalin
