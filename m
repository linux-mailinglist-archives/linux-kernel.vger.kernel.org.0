Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05A63CC94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfFKNIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfFKNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5CA9ADD4;
        Tue, 11 Jun 2019 13:08:20 +0000 (UTC)
Date:   Tue, 11 Jun 2019 15:08:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Chengang (L)" <cg.chen@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "pavel.tatashin@microsoft.com" <pavel.tatashin@microsoft.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Message-ID: <20190611130820.GI2388@dhcp22.suse.cz>
References: <D27E5778F399414A8B5D5F672064BAD8B3E5FB7B@dggemi529-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D27E5778F399414A8B5D5F672064BAD8B3E5FB7B@dggemi529-mbs.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-06-19 12:16:35, Chengang (L) wrote:
> Hi Michal
> 
> 
> >On Sun 09-06-19 17:10:28, ChenGang wrote:
> >> Usually the value of min_free_kbytes is multiply of 4, and in this 
> >> case ,the right shift is ok.
> >> But if it's not, the right-shifting operation will lose the low 2 
> >> bits, and this cause kernel don't reserve enough memory.
> >> So it's necessary to align the value of min_free_kbytes to multiply of 4.
> >> For example, if min_free_kbytes is 64, then should keep 16 pages, but 
> >> if min_free_kbytes is 65 or 66, then should keep 17 pages.
> 
> >Could you describe the actual problem? Do we ever generate min_free_kbytes that would lead to unexpected reserves or is this trying to compensate for those values being configured from the userspace? If later why do we care at all?
> 
> >Have you seen this to be an actual problem or is this mostly motivated by the code reading?
> 
> I haven't seen an actual problem, and it's motivated by code
> reading.  Users can configure this value through interface
> /proc/sys/vm/min_free_kbytes, so I think a bit precious is better.

The interface is intended for admins and they should better know what
they are doing, right? Using an ad-hoc valus is not something that is a
common usecase.

That being said, your change makes the code slightly harder to read and
the benefit is not entirely clear from the changelog (which btw. sounds
like there is a real problem which is not described in the user visible
terms). So if you really believe this change is worth it, then make sure
you justify it by exaplain what is a negative consequence of a dubious
value set by an admin.

> >> Signed-off-by: ChenGang <cg.chen@huawei.com>
> >> ---
> >>  mm/page_alloc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index d66bc8a..1baeeba 
> >> 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
> >>  
> >>  static void __setup_per_zone_wmarks(void)  {
> >> -	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
> >> +	unsigned long pages_min =
> >> +		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
> >>  	unsigned long lowmem_pages = 0;
> >>  	struct zone *zone;
> >>  	unsigned long flags;
> >> --
> >> 1.8.5.6
> >> 
> 
> >-- 
> >Michal Hocko
> >SUSE Labs

-- 
Michal Hocko
SUSE Labs
