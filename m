Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F08D593
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfHNOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:06:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfHNOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:06:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28850AFA9;
        Wed, 14 Aug 2019 14:06:09 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:06:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/4] resource: Use PFN_UP / PFN_DOWN in
 walk_system_ram_range()
Message-ID: <20190814140608.GZ17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:56:58, David Hildenbrand wrote:
> This makes it clearer that we will never call func() with duplicate PFNs
> in case we have multiple sub-page memory resources. All unaligned parts
> of PFNs are completely discarded.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7ea4306503c5..88ee39fa9103 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -487,8 +487,8 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>  	while (start < end &&
>  	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
>  				    false, &res)) {
> -		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -		end_pfn = (res.end + 1) >> PAGE_SHIFT;
> +		pfn = PFN_UP(res.start);
> +		end_pfn = PFN_DOWN(res.end + 1);
>  		if (end_pfn > pfn)
>  			ret = (*func)(pfn, end_pfn - pfn, arg);
>  		if (ret)
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
