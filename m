Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E476091
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGZITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 04:19:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:19:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9641BB62C;
        Fri, 26 Jul 2019 08:19:19 +0000 (UTC)
Date:   Fri, 26 Jul 2019 10:19:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190726081919.GI6142@dhcp22.suse.cz>
References: <20190725092206.23712-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725092206.23712-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-07-19 11:22:06, David Hildenbrand wrote:
> Commit 9852a7212324 ("mm: drop hotplug lock from lru_add_drain_all()")
> states that lru_add_drain_all() "Doesn't need any cpu hotplug locking
> because we do rely on per-cpu kworkers being shut down before our
> page_alloc_cpu_dead callback is executed on the offlined cpu."
> 
> And also "Calling this function with cpu hotplug locks held can actually
> lead to obscure indirect dependencies via WQ context.".
> 
> Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
> rwsem") we do a cpus_read_lock() in mem_hotplug_begin().
> 
> I don't see how that lock is still helpful, we already hold the
> device_hotplug_lock to protect try_offline_node(), which is AFAIK one
> problematic part that can race with CPU hotplug. If it is still
> necessary, we should document why.

I have forgot all the juicy details. Maybe Thomas remembers. The
previous recursive home grown locking was just terrible. I do not see
stop_machine being used in the memory hotplug anymore.
 
I do support this kind of removal because binding CPU and MEM hotplug
locks is fragile and wrong. But this patch really needs more explanation
on why this is safe. In other words what does cpu_read_lock protects
from in mem hotplug paths.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e7c3b219a305..43b8cd4b96f5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -86,14 +86,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
>  
>  void mem_hotplug_begin(void)
>  {
> -	cpus_read_lock();
>  	percpu_down_write(&mem_hotplug_lock);
>  }
>  
>  void mem_hotplug_done(void)
>  {
>  	percpu_up_write(&mem_hotplug_lock);
> -	cpus_read_unlock();
>  }
>  
>  u64 max_mem_size = U64_MAX;
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
