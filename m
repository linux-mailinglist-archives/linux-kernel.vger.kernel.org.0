Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5CDFF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfJVIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:20:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388011AbfJVIU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:20:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61DF4ADFE;
        Tue, 22 Oct 2019 08:20:54 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:20:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc.c: Don't set pages PageReserved()
 when offlining
Message-ID: <20191022082053.GB9379@dhcp22.suse.cz>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-2-david@redhat.com>
 <20191021144345.GT9379@dhcp22.suse.cz>
 <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
 <20191021154712.GW9379@dhcp22.suse.cz>
 <91ecb9b7-4271-a3a7-2342-b0afd4c41606@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ecb9b7-4271-a3a7-2342-b0afd4c41606@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 17:54:35, David Hildenbrand wrote:
> On 21.10.19 17:47, Michal Hocko wrote:
> > On Mon 21-10-19 17:39:36, David Hildenbrand wrote:
> > > On 21.10.19 16:43, Michal Hocko wrote:
> > [...]
> > > > We still set PageReserved before onlining pages and that one should be
> > > > good to go as well (memmap_init_zone).
> > > > Thanks!
> > > 
> > > memmap_init_zone() is called when onlining memory. There, set all pages to
> > > reserved right now (on context == MEMMAP_HOTPLUG). We clear PG_reserved when
> > > onlining a page to the buddy (e.g., generic_online_page). If we would online
> > > a memory block with holes, we would want to keep all such pages
> > > (!pfn_valid()) set to reserved. Also, there might be other side effects.
> > 
> > Isn't it sufficient to have those pages in a poisoned state? They are
> > not onlined so their state is basically undefined anyway. I do not see
> > how PageReserved makes this any better.
> 
> It is what people have been using for a long time. Memory hole ->
> PG_reserved. The memmap is valid, but people want to tell "this here is
> crap, don't look at it".

The page is poisoned, right? If yes then setting the reserved bit
doesn't make any sense.

> > Also is the hole inside a hotplugable memory something we really have to
> > care about. Has anybody actually seen a platform to require that?
> 
> That's what I was asking. I can see "support" for this was added basically
> right from the beginning. I'd say we rip that out and cleanup/simplify. I am
> not aware of a platform that requires this. Especially, memory holes on
> DIMMs (detected during boot) seem like an unlikely thing.

The thing is that the hotplug development shows ad-hoc decisions
throughout the code. It is even worse that it is hard to guess whether
some hludges are a result of a careful design or ad-hoc trial and
failure approach on setups that never were production. Building on top
of that be preserving hacks is not going to improve the situation. So I
am perfectly fine to focus on making the most straightforward setups
work reliably. Even when there is a risk of breaking some odd setups. We
can fix them up later but we would have at least a specific example and
document it.
-- 
Michal Hocko
SUSE Labs
