Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5C9DDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfH0G2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 02:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfH0G2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D72E8B0B6;
        Tue, 27 Aug 2019 06:28:45 +0000 (UTC)
Date:   Tue, 27 Aug 2019 08:28:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Perform a bounds check in arch_add_memory
Message-ID: <20190827062844.GQ7538@dhcp22.suse.cz>
References: <20190827052047.31547-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827052047.31547-1-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 15:20:46, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> It is possible for firmware to allocate memory ranges outside
> the range of physical memory that we support (MAX_PHYSMEM_BITS).

Doesn't that count as a FW bug? Do you have any evidence of that in the
field? Just wondering...

> This patch adds a bounds check to ensure that any hotplugged
> memory is addressable.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/mm/mem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9191a66b3bc5..de18fb73de30 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -111,6 +111,9 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	int rc;
>  
> +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> +		return -EINVAL;
> +
>  	resize_hpt_for_hotplug(memblock_phys_mem_size());
>  
>  	start = (unsigned long)__va(start);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
