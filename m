Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CF13A7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgANLCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:02:07 -0500
Received: from foss.arm.com ([217.140.110.172]:50706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANLCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:02:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E787B142F;
        Tue, 14 Jan 2020 03:02:05 -0800 (PST)
Received: from [10.163.1.192] (unknown [10.163.1.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A9A23F6C4;
        Tue, 14 Jan 2020 03:02:01 -0800 (PST)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
 <20200114091013.GD19428@dhcp22.suse.cz>
 <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a0564db6-2e5f-6490-9b09-c3505cc514d0@arm.com>
Date:   Tue, 14 Jan 2020 16:33:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/14/2020 03:53 PM, Vlastimil Babka wrote:
> On 1/14/20 10:10 AM, Michal Hocko wrote:
>> [Cc Ralph]
>>> The reason is dump_page() does not print page->flags universally
>>> and only does so for KSM, Anon and File pages while excluding
>>> reserved pages at boot. Wondering should not we make printing
>>> page->flags universal ?
>>
>> We used to do that and this caught me as a surprise when looking again.
>> This is a result of 76a1850e4572 ("mm/debug.c: __dump_page() prints an
>> extra line") which is a cleanup patch and I suspect this result was not
>> anticipated.
>>
>> The following will do the trick but I cannot really say I like the code
>> duplication. pr_cont in this case sounds like a much cleaner solution to
>> me.
> 
> How about this then?

This looks better than what we have right now though my initial thought
was similar to what Michal had suggested earlier.

> 
> diff --git mm/debug.c mm/debug.c
> index 0461df1207cb..6a52316af839 100644
> --- mm/debug.c
> +++ mm/debug.c
> @@ -47,6 +47,7 @@ void __dump_page(struct page *page, const char *reason)
>  	struct address_space *mapping;
>  	bool page_poisoned = PagePoisoned(page);
>  	int mapcount;
> +	char *type = "";
>  
>  	/*
>  	 * If struct page is poisoned don't access Page*() functions as that
> @@ -78,9 +79,9 @@ void __dump_page(struct page *page, const char *reason)
>  			page, page_ref_count(page), mapcount,
>  			page->mapping, page_to_pgoff(page));
>  	if (PageKsm(page))
> -		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +		type = "ksm ";
>  	else if (PageAnon(page))
> -		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +		type = "anon ";
>  	else if (mapping) {
>  		if (mapping->host && mapping->host->i_dentry.first) {
>  			struct dentry *dentry;
> @@ -88,10 +89,11 @@ void __dump_page(struct page *page, const char *reason)
>  			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
>  		} else
>  			pr_warn("%ps\n", mapping->a_ops);
> -		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
> +	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
> +
>  hex_only:
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
> 
> 
