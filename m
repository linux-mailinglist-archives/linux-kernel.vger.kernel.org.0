Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22CAF2DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfKGLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 06:54:34 -0500
Received: from ozlabs.org ([203.11.71.1]:36053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfKGLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:54:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4781z871F7z9sP3;
        Thu,  7 Nov 2019 22:54:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573127670;
        bh=+OqaUvb1czjnKLj7FFJP1J5EwOqrmOwhqu8kZf47j3M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GK2zmzQSxVGyhgvYs0tzkcMIwkEmyTnz/zSWM6offu95DbfG3Llkgxx4r+tBceft4
         4Ta5D1+GkMRx/Ql1gnkLxmr8Chi6MvlBz8CFAzDLc8jzQAaj2xu9rVmuKsBxh6BSyJ
         EsRwQU96nHFL9dNtSAfdVYrFH/9FQVdh+dmxGIV09oL6eJSlafEFcPTw/EaUIjuJ2j
         EZVyEyPKixHo/SM+ksr0D2QqBA9eXFbt7OIILwgm6es/jD6lmuGpDd2JWSWdR8HFGv
         eYzUG6AG3LJ3Tx9WaorS4+YN5t5XUFRd0dcK1+HATaCSmEnHI2HNIJm2TqLqNrTpBc
         EIv6mdMICtKyg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
In-Reply-To: <20191104023305.9581-6-alastair@au1.ibm.com>
References: <20191104023305.9581-1-alastair@au1.ibm.com> <20191104023305.9581-6-alastair@au1.ibm.com>
Date:   Thu, 07 Nov 2019 22:54:26 +1100
Message-ID: <87y2wr52bx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alastair D'Silva" <alastair@au1.ibm.com> writes:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> When presented with large amounts of memory being hotplugged
> (in my test case, ~890GB), the call to flush_dcache_range takes
> a while (~50 seconds), triggering RCU stalls.
>
> This patch breaks up the call into 1GB chunks, calling
> cond_resched() inbetween to allow the scheduler to run.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

I'm going to mark this as:
  Fixes: fb5924fddf9e ("powerpc/mm: Flush cache on memory hot(un)plug")

Because anyone doing large memory hotplugs on older kernels is going to
want to backport this to at least that point, otherwise they will see
the softlockups/RCU stalls.

cheers

> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 54d61ba15e93..a7b662fc02c8 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -104,6 +104,27 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
>  	return -ENODEV;
>  }
>  
> +#define FLUSH_CHUNK_SIZE SZ_1G
> +/**
> + * flush_dcache_range_chunked(): Write any modified data cache blocks out to
> + * memory and invalidate them, in chunks of up to FLUSH_CHUNK_SIZE
> + * Does not invalidate the corresponding instruction cache blocks.
> + *
> + * @start: the start address
> + * @stop: the stop address (exclusive)
> + * @chunk: the max size of the chunks
> + */
> +static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
> +				       unsigned long chunk)
> +{
> +	unsigned long i;
> +
> +	for (i = start; i < stop; i += chunk) {
> +		flush_dcache_range(i, min(stop, start + chunk));
> +		cond_resched();
> +	}
> +}
> +
>  int __ref arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions)
>  {
> @@ -120,7 +141,8 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  			start, start + size, rc);
>  		return -EFAULT;
>  	}
> -	flush_dcache_range(start, start + size);
> +
> +	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>  
>  	return __add_pages(nid, start_pfn, nr_pages, restrictions);
>  }
> @@ -137,7 +159,8 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
>  
>  	/* Remove htab bolted mappings for this section of memory */
>  	start = (unsigned long)__va(start);
> -	flush_dcache_range(start, start + size);
> +	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
> +
>  	ret = remove_section_mapping(start, start + size);
>  	WARN_ON_ONCE(ret);
>  
> -- 
> 2.21.0
