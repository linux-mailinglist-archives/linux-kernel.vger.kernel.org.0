Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24EC47B91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfFQHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 03:47:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfFQHrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:47:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEB10AFC3;
        Mon, 17 Jun 2019 07:47:16 +0000 (UTC)
Date:   Mon, 17 Jun 2019 09:47:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Arun KS <arunks@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Juergen Gross <jgross@suse.com>,
        Oscar Salvador <osalvador@suse.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/hotplug: Avoid RCU stalls when removing large
 amounts of memory
Message-ID: <20190617074715.GE30420@dhcp22.suse.cz>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617043635.13201-5-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 14:36:30,  Alastair D'Silva  wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When removing sufficiently large amounts of memory, we trigger RCU stall
> detection. By periodically calling cond_resched(), we avoid bogus stall
> warnings.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  mm/memory_hotplug.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e096c987d261..382b3a0c9333 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -578,6 +578,9 @@ void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
>  		__remove_section(zone, __pfn_to_section(pfn), map_offset,
>  				 altmap);
>  		map_offset = 0;
> +
> +		if (!(i & 0x0FFF))
> +			cond_resched();

We already do have cond_resched before __remove_section. Why is an
additional needed?

>  	}
>  
>  	set_zone_contiguous(zone);
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
