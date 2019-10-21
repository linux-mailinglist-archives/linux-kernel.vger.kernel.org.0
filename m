Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A500EDF1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfJUPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 11:47:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfJUPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B848EAE79;
        Mon, 21 Oct 2019 15:47:12 +0000 (UTC)
Date:   Mon, 21 Oct 2019 17:47:12 +0200
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
Message-ID: <20191021154712.GW9379@dhcp22.suse.cz>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-2-david@redhat.com>
 <20191021144345.GT9379@dhcp22.suse.cz>
 <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 17:39:36, David Hildenbrand wrote:
> On 21.10.19 16:43, Michal Hocko wrote:
[...]
> > We still set PageReserved before onlining pages and that one should be
> > good to go as well (memmap_init_zone).
> > Thanks!
> 
> memmap_init_zone() is called when onlining memory. There, set all pages to
> reserved right now (on context == MEMMAP_HOTPLUG). We clear PG_reserved when
> onlining a page to the buddy (e.g., generic_online_page). If we would online
> a memory block with holes, we would want to keep all such pages
> (!pfn_valid()) set to reserved. Also, there might be other side effects.

Isn't it sufficient to have those pages in a poisoned state? They are
not onlined so their state is basically undefined anyway. I do not see
how PageReserved makes this any better.

Also is the hole inside a hotplugable memory something we really have to
care about. Has anybody actually seen a platform to require that?
-- 
Michal Hocko
SUSE Labs
