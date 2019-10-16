Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83259D9361
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393837AbfJPOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:10:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731923AbfJPOKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:10:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3777B979;
        Wed, 16 Oct 2019 14:09:59 +0000 (UTC)
Date:   Wed, 16 Oct 2019 16:09:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
 a reference count of 0
Message-ID: <20191016140958.GE317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <bd38d88d-19a7-275a-386d-f37cb76a3390@redhat.com>
 <20191016134519.GC317@dhcp22.suse.cz>
 <2aef8477-7d12-63a8-e273-9eae8712d5c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aef8477-7d12-63a8-e273-9eae8712d5c2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 15:55:00, David Hildenbrand wrote:
> On 16.10.19 15:45, Michal Hocko wrote:
[...]
> > There is state stored in the struct page. In other words this shouldn't
> > be really different from HWPoison pages. I cannot find the code that is
> > doing that and maybe we don't handle that. But we cannot simply online
> > hwpoisoned page. Offlining the range will not make a broken memory OK
> > all of the sudden. And your usecase sounds similar to me.
> 
> Sorry to say, but whenever we online memory the memmap is overwritten,
> because there is no way you could tell it contains garbage or not. You have
> to assume it is garbage. (my recent patch even poisons the memmap when
> offlining, which helped to find a lot of these "garbage memmap" BUGs)
> 
> online_pages()
> 	...
> 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
> 	...
> 		memmap_init_zone()
> 			-> memmap initialized
> 
> So yes, offlining memory with HWPoison and re-onlining it effectively drops
> HWPoison markers. On the next access, you will trigger a new HWPoison.

Right you are! I need to sit on this much more and think about it with a
clean head.
-- 
Michal Hocko
SUSE Labs
