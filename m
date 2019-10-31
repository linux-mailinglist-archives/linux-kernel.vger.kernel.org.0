Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916B1EAAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 08:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJaHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 03:25:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfJaHZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:25:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAE22AEAF;
        Thu, 31 Oct 2019 07:25:55 +0000 (UTC)
Date:   Thu, 31 Oct 2019 08:25:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191031072555.GA13102@dhcp22.suse.cz>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
 <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
 <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
 <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030173123.GK31513@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent, could you give this a try please? It would be even better if
you could add some debugging to measure the overhead. Let me know if you
need any help with a debugging patch.

Thanks!

On Wed 30-10-19 18:31:23, Michal Hocko wrote:
[...]
> What about this? It still aligns to the size but that should be
> correctly done to the section size level.
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d9bff5..ab1e6175ac9a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
>  	if (map)
>  		return map;
>  
> -	map = memblock_alloc_try_nid(size,
> -					  PAGE_SIZE, addr,
> +	map = memblock_alloc_try_nid(size, size, addr,
>  					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  	if (!map)
>  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>  {
>  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
>  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> +	/*
> +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> +	 * and we want it to be properly aligned to the section size - this is
> +	 * especially the case for VMEMMAP which maps memmap to PMDs
> +	 */
>  	sparsemap_buf =
> -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> +		memblock_alloc_try_nid_raw(size, section_map_size(),
>  						addr,
>  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  	sparsemap_buf_end = sparsemap_buf + size;
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
