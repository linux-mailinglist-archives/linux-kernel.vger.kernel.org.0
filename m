Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDF56496
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFZI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 04:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfFZI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:28:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D80AAD7E;
        Wed, 26 Jun 2019 08:28:44 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:28:41 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, david@redhat.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm,memory_hotplug: allocate memmap from the added
 memory range for sparse-vmemmap
Message-ID: <20190626082841.GE30863@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-5-osalvador@suse.de>
 <3056b153-20a3-ac86-4a49-c26f8be4b2a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3056b153-20a3-ac86-4a49-c26f8be4b2a6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:47:32PM +0530, Anshuman Khandual wrote:
> Hello Oscar,
> 
> On 06/25/2019 01:22 PM, Oscar Salvador wrote:
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 93ed0df4df79..d4b5661fa6b6 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -765,7 +765,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> >  		if (pmd_none(READ_ONCE(*pmdp))) {
> >  			void *p = NULL;
> >  
> > -			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
> > +			if (altmap)
> > +				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
> > +			else
> > +				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
> >  			if (!p)
> >  				return -ENOMEM;
> 
> Is this really required to be part of this series ? I have an ongoing work
> (reworked https://patchwork.kernel.org/patch/10882781/) enabling altmap
> support on arm64 during memory hot add and remove path which is waiting on
> arm64 memory-hot remove to be merged first.

Hi Anshuman,

I can drop this chunk in the next version.
No problem.

-- 
Oscar Salvador
SUSE L3
