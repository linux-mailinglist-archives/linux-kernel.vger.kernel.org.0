Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FBC56242
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 02:21:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZGVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:21:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3619AAD47;
        Wed, 26 Jun 2019 06:21:15 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:21:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
Message-ID: <20190626062113.GF17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626061124.16013-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> If a memory section comes in where the physical address is greater than
> that which is managed by the kernel, this function would not trigger the
> bug and instead return a bogus section number.
> 
> This patch tracks whether the section was actually found, and triggers the
> bug if not.

Why do we want/need that? In other words the changelog should contina
WHY and WHAT. This one contains only the later one.
 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/base/memory.c | 18 +++++++++++++++---
>  mm/sparse.c           |  7 ++++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f180427e48f4..9244c122abf1 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -585,13 +585,21 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>  struct memory_block *find_memory_block_hinted(struct mem_section *section,
>  					      struct memory_block *hint)
>  {
> -	int block_id = base_memory_block_id(__section_nr(section));
> +	int block_id, section_nr;
>  	struct device *hintdev = hint ? &hint->dev : NULL;
>  	struct device *dev;
>  
> +	section_nr = __section_nr(section);
> +	if (section_nr < 0) {
> +		if (hintdev)
> +			put_device(hintdev);
> +		return NULL;
> +	}
> +
> +	block_id = base_memory_block_id(section_nr);
>  	dev = subsys_find_device_by_id(&memory_subsys, block_id, hintdev);
> -	if (hint)
> -		put_device(&hint->dev);
> +	if (hintdev)
> +		put_device(hintdev);
>  	if (!dev)
>  		return NULL;
>  	return to_memory_block(dev);
> @@ -664,6 +672,10 @@ static int init_memory_block(struct memory_block **memory,
>  		return -ENOMEM;
>  
>  	scn_nr = __section_nr(section);
> +
> +	if (scn_nr < 0)
> +		return scn_nr;
> +
>  	mem->start_section_nr =
>  			base_memory_block_id(scn_nr) * sections_per_block;
>  	mem->end_section_nr = mem->start_section_nr + sections_per_block - 1;
> diff --git a/mm/sparse.c b/mm/sparse.c
> index fd13166949b5..57a1a3d9c1cf 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -113,10 +113,15 @@ int __section_nr(struct mem_section* ms)
>  			continue;
>  
>  		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
> -		     break;
> +			break;
>  	}
>  
>  	VM_BUG_ON(!root);
> +	if (root_nr == NR_SECTION_ROOTS) {
> +		VM_BUG_ON(true);
> +
> +		return -EINVAL;
> +	}
>  
>  	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
>  }
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
