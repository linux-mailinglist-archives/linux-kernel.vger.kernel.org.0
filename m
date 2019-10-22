Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BADFF70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfJVIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388061AbfJVIaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:30:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79712ACA0;
        Tue, 22 Oct 2019 08:30:02 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:30:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191022083002.GE9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
 <20191018123901.GN5017@dhcp22.suse.cz>
 <20191021134846.GB11330@linux>
 <20191021140619.GQ9379@dhcp22.suse.cz>
 <20191022075626.GB19060@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022075626.GB19060@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 09:56:27, Oscar Salvador wrote:
> On Mon, Oct 21, 2019 at 04:06:19PM +0200, Michal Hocko wrote:
> > On Mon 21-10-19 15:48:48, Oscar Salvador wrote:
> > > We can only perform actions on LRU/Movable pages or hugetlb pages.
> > 
> > What would prevent other pages mapped via page tables to be handled as
> > well?
> 
> What kind of pages?

Any pages mapped to the userspace. E.g. driver memory which is not on
LRU.

> I mean, I guess it could be done, it was just not implemented, and I
> did not want to add more "features" as my main goal was to re-work
> the interface to be more deterministic.

Fair enough. One step at the time sounds definitely good
 
> > > 1) we would need to hook in enqueue_hugetlb_page so the page is not enqueued
> > >    into hugetlb freelists
> > > 2) when trying to free a hugetlb page, we would need to do as we do for gigantic
> > >    pages now, and that is breaking down the pages into order-0 pages and release
> > >    them to the buddy (so the check in free_papges_prepare would skip the
> > >    hwpoison page).
> > >    Trying to handle a higher-order hwpoison page in free_pages_prepare is
> > >    a bit complicated.
> > 
> > I am not sure I see the problem. If you dissolve the hugetlb page then
> > there is no hugetlb page anymore and so you make it a regular high-order
> > page.
> 
> Yes, but the problem comes when trying to work with a hwpoison high-order page
> in free_pages_prepare, it gets more complicated, and when I weigthed
> code vs benefits, I was not really sure to go down that road.
> 
> If we get a hwpoison high-order page in free_pages_prepare, we need to
> break it down to smaller pages, so we can skip the "bad" to not be sent
> into buddy allocator.

But we have destructors for compound pages. Can we do the heavy lifting
there?

> > If the page is free then it shouldn't pin the memcg or any other state.
> 
> Well, it is not really free, as it is not usable, is it?

Sorry I meant to say the page is free from the memcg POV - aka no task
from the memcg is holding a reference to it. The page is not usable for
anybody, that is true but no particular memcg should pay a price for
that. This would mean that random memcgs would end up pinned for ever
without a good reason.
-- 
Michal Hocko
SUSE Labs
