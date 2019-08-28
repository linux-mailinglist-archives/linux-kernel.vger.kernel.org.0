Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115ED9FBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1HcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:32:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfH1Hb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4602B009;
        Wed, 28 Aug 2019 07:31:56 +0000 (UTC)
Date:   Wed, 28 Aug 2019 09:31:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Don't manually decrement num_poisoned_pages
Message-ID: <20190828073148.GA30623@linux>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
 <20190827053656.32191-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827053656.32191-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:36:54PM +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use the function written to do it instead.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/sparse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d9bff5..e41917a7e844 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -11,6 +11,8 @@
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  
>  #include "internal.h"
>  #include <asm/dma.h>
> @@ -898,7 +900,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		if (PageHWPoison(&memmap[i])) {
> -			atomic_long_sub(1, &num_poisoned_pages);
> +			num_poisoned_pages_dec();
>  			ClearPageHWPoison(&memmap[i]);
>  		}
>  	}
> -- 
> 2.21.0
> 

-- 
Oscar Salvador
SUSE L3
