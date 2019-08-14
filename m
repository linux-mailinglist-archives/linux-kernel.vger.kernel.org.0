Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BE8D5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHNO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfHNO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:26:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A45FEAEE9;
        Wed, 14 Aug 2019 14:26:13 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:26:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 4/4] mm/memory_hotplug: online_pages cannot be 0 in
 online_pages()
Message-ID: <20190814142613.GC17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:57:01, David Hildenbrand wrote:
> walk_system_ram_range() will fail with -EINVAL in case
> online_pages_range() was never called (== no resource applicable in the
> range). Otherwise, we will always call online_pages_range() with
> nr_pages > 0 and, therefore, have online_pages > 0.

I have no idea why those checks where there TBH. Tried to dig out
commits which added them but didn't help.

> Remove that special handling.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 87f85597a19e..07e72fe17495 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -854,6 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  	ret = walk_system_ram_range(pfn, nr_pages, &onlined_pages,
>  		online_pages_range);
>  	if (ret) {
> +		/* not a single memory resource was applicable */
>  		if (need_zonelists_rebuild)
>  			zone_pcp_reset(zone);
>  		goto failed_addition;
> @@ -867,27 +868,22 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  
>  	shuffle_zone(zone);
>  
> -	if (onlined_pages) {
> -		node_states_set_node(nid, &arg);
> -		if (need_zonelists_rebuild)
> -			build_all_zonelists(NULL);
> -		else
> -			zone_pcp_update(zone);
> -	}
> +	node_states_set_node(nid, &arg);
> +	if (need_zonelists_rebuild)
> +		build_all_zonelists(NULL);
> +	else
> +		zone_pcp_update(zone);
>  
>  	init_per_zone_wmark_min();
>  
> -	if (onlined_pages) {
> -		kswapd_run(nid);
> -		kcompactd_run(nid);
> -	}
> +	kswapd_run(nid);
> +	kcompactd_run(nid);
>  
>  	vm_total_pages = nr_free_pagecache_pages();
>  
>  	writeback_set_ratelimit();
>  
> -	if (onlined_pages)
> -		memory_notify(MEM_ONLINE, &arg);
> +	memory_notify(MEM_ONLINE, &arg);
>  	mem_hotplug_done();
>  	return 0;
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
