Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69D0C4B80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJBKfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 06:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfJBKfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:35:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33B85B028;
        Wed,  2 Oct 2019 10:35:15 +0000 (UTC)
Date:   Wed, 2 Oct 2019 12:34:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191002103422.GJ15624@dhcp22.suse.cz>
References: <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <fac13297-424f-33b0-e01d-d72b949a73fe@suse.cz>
 <alpine.DEB.2.21.1910011318050.38265@chino.kir.corp.google.com>
 <a5abc877-26de-ed3c-eb33-71474301c852@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5abc877-26de-ed3c-eb33-71474301c852@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-10-19 23:54:14, Vlastimil Babka wrote:
> On 10/1/19 10:31 PM, David Rientjes wrote:
[...]
> > If 
> > hugetlb wants to stress this to the fullest extent possible, it already 
> > appropriately uses __GFP_RETRY_MAYFAIL.
> 
> Which doesn't work anymore right now, and should again after this patch.

I didn't get to fully digest the patch Vlastimil is proposing. (Ab)using
__GFP_NORETRY is quite subtle but it is already in place with some
explanation and a reference to THPs. So while I am not really happy it
is at least something you can reason about.

b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction
may not succeed") on the other hand has added a much more wider change
which has clearly broken hugetlb and any __GFP_RETRY_MAYFAIL user of
pageblock_order sized allocations. And that is much worse and something
I was pointing at during the review and those concerns were never really
addressed before merging.

In any case this is something to be fixed ASAP. Do you have any better
proposa? I do not assume you would be proposing yet another revert.
-- 
Michal Hocko
SUSE Labs
