Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151943AF99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfFJH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 03:27:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387982AbfFJH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B06FAE5A;
        Mon, 10 Jun 2019 07:26:56 +0000 (UTC)
Date:   Mon, 10 Jun 2019 09:26:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ChenGang <cg.chen@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        pavel.tatashin@microsoft.com, mgorman@techsingularity.net,
        rppt@linux.ibm.com, richard.weiyang@gmail.com,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Message-ID: <20190610072655.GB30967@dhcp22.suse.cz>
References: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-06-19 17:10:28, ChenGang wrote:
> Usually the value of min_free_kbytes is multiply of 4,
> and in this case ,the right shift is ok.
> But if it's not, the right-shifting operation will lose the low 2 bits,
> and this cause kernel don't reserve enough memory.
> So it's necessary to align the value of min_free_kbytes to multiply of 4.
> For example, if min_free_kbytes is 64, then should keep 16 pages,
> but if min_free_kbytes is 65 or 66, then should keep 17 pages.

Could you describe the actual problem? Do we ever generate
min_free_kbytes that would lead to unexpected reserves or is this trying
to compensate for those values being configured from the userspace? If
later why do we care at all?

Have you seen this to be an actual problem or is this mostly motivated
by the code reading?

> Signed-off-by: ChenGang <cg.chen@huawei.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8a..1baeeba 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
>  
>  static void __setup_per_zone_wmarks(void)
>  {
> -	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
> +	unsigned long pages_min =
> +		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
>  	unsigned long lowmem_pages = 0;
>  	struct zone *zone;
>  	unsigned long flags;
> -- 
> 1.8.5.6
> 

-- 
Michal Hocko
SUSE Labs
