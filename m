Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF7DBF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442177AbfJRIPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbfJRIPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A8377E424;
        Fri, 18 Oct 2019 08:15:50 +0000 (UTC)
Received: from [10.36.118.57] (unknown [10.36.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93E8B600C1;
        Fri, 18 Oct 2019 08:15:48 +0000 (UTC)
Subject: Re: [RFC PATCH v2 16/16] mm, soft-offline: convert parameter to pfn
To:     Oscar Salvador <osalvador@suse.de>, n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-17-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <62eb5232-1e4d-22cf-0026-3e37ac06f3a3@redhat.com>
Date:   Fri, 18 Oct 2019 10:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017142123.24245-17-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 18 Oct 2019 08:15:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.19 16:21, Oscar Salvador wrote:
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> Currently soft_offline_page() receives struct page, and its sibling
> memory_failure() receives pfn. This discrepancy looks weird and makes
> precheck on pfn validity tricky. So let's align them.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   drivers/base/memory.c |  7 +------
>   include/linux/mm.h    |  2 +-
>   mm/madvise.c          |  2 +-
>   mm/memory-failure.c   | 17 +++++++++--------
>   4 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b3cae2eb1c4f..b510b4d176c9 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -538,12 +538,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
>   	if (kstrtoull(buf, 0, &pfn) < 0)
>   		return -EINVAL;
>   	pfn >>= PAGE_SHIFT;
> -	if (!pfn_valid(pfn))
> -		return -ENXIO;
> -	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> -	if (!pfn_to_online_page(pfn))
> -		return -EIO;
> -	ret = soft_offline_page(pfn_to_page(pfn));
> +	ret = soft_offline_page(pfn);
>   	return ret == 0 ? count : ret;
>   }
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0f80a1ce4e86..40722854d357 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2791,7 +2791,7 @@ extern int sysctl_memory_failure_early_kill;
>   extern int sysctl_memory_failure_recovery;
>   extern void shake_page(struct page *p, int access);
>   extern atomic_long_t num_poisoned_pages __read_mostly;
> -extern int soft_offline_page(struct page *page);
> +extern int soft_offline_page(unsigned long pfn);
>   
>   
>   /*
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9ca48345ce45..f83b7d4c68c1 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -890,7 +890,7 @@ static int madvise_inject_error(int behavior,
>   		if (behavior == MADV_SOFT_OFFLINE) {
>   			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>   				 pfn, start);
> -			ret = soft_offline_page(page);
> +			ret = soft_offline_page(pfn);
>   		} else {
>   			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>   				 pfn, start);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c038896bedf0..bfecb61fc064 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1521,7 +1521,7 @@ static void memory_failure_work_func(struct work_struct *work)
>   		if (!gotten)
>   			break;
>   		if (entry.flags & MF_SOFT_OFFLINE)
> -			soft_offline_page(pfn_to_page(entry.pfn));
> +			soft_offline_page(entry.pfn);
>   		else
>   			memory_failure(entry.pfn, entry.flags);
>   	}
> @@ -1834,7 +1834,7 @@ static int soft_offline_free_page(struct page *page)
>   
>   /**
>    * soft_offline_page - Soft offline a page.
> - * @page: page to offline
> + * @pfn: pfn to soft-offline
>    *
>    * Returns 0 on success, otherwise negated errno.
>    *
> @@ -1853,16 +1853,17 @@ static int soft_offline_free_page(struct page *page)
>    * This is not a 100% solution for all memory, but tries to be
>    * ``good enough'' for the majority of memory.
>    */
> -int soft_offline_page(struct page *page)
> +int soft_offline_page(unsigned long pfn)
>   {
>   	int ret;
> -	unsigned long pfn = page_to_pfn(page);
> +	struct page *page;
>   
> -	if (is_zone_device_page(page)) {
> -		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
> -				pfn);
> +	if (!pfn_valid(pfn))
> +		return -ENXIO;
> +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> +	page = pfn_to_online_page(pfn);
> +	if (!page)
>   		return -EIO;
> -	}
>   
>   	if (PageHWPoison(page)) {
>   		pr_info("soft offline: %#lx page already poisoned\n", pfn);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
