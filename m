Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D018BDEC01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfJUMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 08:20:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbfJUMUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3B73B35C;
        Mon, 21 Oct 2019 12:20:02 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:20:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/16] mm,madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Message-ID: <20191021122002.GM9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-3-osalvador@suse.de>
 <20191018115227.GL5017@dhcp22.suse.cz>
 <20191021070254.GB8782@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021070254.GB8782@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 07:02:55, Naoya Horiguchi wrote:
> On Fri, Oct 18, 2019 at 01:52:27PM +0200, Michal Hocko wrote:
> > On Thu 17-10-19 16:21:09, Oscar Salvador wrote:
> > > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > 
> > > The call to get_user_pages_fast is only to get the pointer to a struct
> > > page of a given address, pinning it is memory-poisoning handler's job,
> > > so drop the refcount grabbed by get_user_pages_fast
> > > 
> > > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > > ---
> > >  mm/madvise.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 2be9f3fdb05e..89ed9a22ff4f 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -878,16 +878,24 @@ static int madvise_inject_error(int behavior,
> > >  		 */
> > >  		order = compound_order(compound_head(page));
> > >  
> > > -		if (PageHWPoison(page)) {
> > > -			put_page(page);
> > > +		/*
> > > +		 * The get_user_pages_fast() is just to get the pfn of the
> > > +		 * given address, and the refcount has nothing to do with
> > > +		 * what we try to test, so it should be released immediately.
> > > +		 * This is racy but it's intended because the real hardware
> > > +		 * errors could happen at any moment and memory error handlers
> > > +		 * must properly handle the race.
> > > +		 */
> > > +		put_page(page);
> > > +
> > > +		if (PageHWPoison(page))
> > >  			continue;
> > > -		}
> > >  
> > >  		if (behavior == MADV_SOFT_OFFLINE) {
> > >  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
> > >  					pfn, start);
> > >  
> > > -			ret = soft_offline_page(page, MF_COUNT_INCREASED);
> > > +			ret = soft_offline_page(page, 0);
> > 
> > What does prevent this struct page to go away completely?
> 
> Nothing does it.  Memory error handler tries to pin by itself and
> then determines what state the page is in now.

OK, but the page is not pinned by this context so it can go away at any
time, right? Or do I miss your point? Who would be the Error handler
context in this case?
-- 
Michal Hocko
SUSE Labs
