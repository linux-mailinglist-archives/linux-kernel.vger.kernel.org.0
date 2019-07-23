Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FB71248
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfGWHGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGWHGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:06:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77322AE91;
        Tue, 23 Jul 2019 07:06:43 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:06:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Message-ID: <20190723070642.GC4552@dhcp22.suse.cz>
References: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-07-19 10:51:31, KarimAllah Ahmed wrote:
> Do not mark regions that are marked with nomap to be present, otherwise
> these memblock cause unnecessarily allocation of metadata.

This begs for much more information. How come nomap regions are in
usable memblocks? What if memblock allocator used that memory?
In other words, shouldn't nomap (an unusable memory iirc) be in reserved
memblocks or removed altogethher?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  mm/sparse.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index fd13166..33810b6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -256,6 +256,10 @@ void __init memblocks_present(void)
>  	struct memblock_region *reg;
>  
>  	for_each_memblock(memory, reg) {
> +
> +		if (memblock_is_nomap(reg))
> +			continue;
> +
>  		memory_present(memblock_get_region_node(reg),
>  			       memblock_region_memory_base_pfn(reg),
>  			       memblock_region_memory_end_pfn(reg));
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
