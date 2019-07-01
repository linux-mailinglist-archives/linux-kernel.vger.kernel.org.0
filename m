Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8624870
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEUGxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:53:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14879 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfEUGxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:53:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 457RLK0qmVz9tyky;
        Tue, 21 May 2019 08:53:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RWg5v/0n; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zZ2AhrY8pjzv; Tue, 21 May 2019 08:53:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 457RLJ6stjz9tykt;
        Tue, 21 May 2019 08:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558421609; bh=pmaiN8J5Ym0ioInPLVMER7oqbn8dqC0ancP3yOcPwqU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RWg5v/0ng+xXCfVQGTmaLGZcdjub2jTULl9pDDStyP0tYVNOTfgTDrJe90FrM8Xv2
         uNm1Nb4xu5Te55BkyFO+5vQKzIsJipCjSrWRhupTZsd7jl/aqvGYJap3hU/WJrKKNK
         uI6CDmH+p6oqgzNw2bjNh/OmXRJ8eJRlJcs/+vbE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E33458B7EA;
        Tue, 21 May 2019 08:53:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ukI0T5QBRGaZ; Tue, 21 May 2019 08:53:29 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C52F8B74F;
        Tue, 21 May 2019 08:53:28 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <20190521061659.6073-1-yamada.masahiro@socionext.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
Date:   Tue, 21 May 2019 08:53:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521061659.6073-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/05/2019 à 08:16, Masahiro Yamada a écrit :
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
> 
>    arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
>    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
>      104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>          |  ^~~
>    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
> 
> Fixing _tlbiel_pid() is enough to address the warning above, but I
> inlined more functions to fix all potential issues.
> 
> To meet the 'i' (immediate) constraint for the asm operands, functions
> propagating propagated 'ric' must be always inlined.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>   arch/powerpc/mm/book3s64/hash_native.c |  8 +++--
>   arch/powerpc/mm/book3s64/radix_tlb.c   | 44 +++++++++++++++-----------
>   2 files changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
> index aaa28fd918fe..bc2c35c0d2b1 100644
> --- a/arch/powerpc/mm/book3s64/hash_native.c
> +++ b/arch/powerpc/mm/book3s64/hash_native.c
> @@ -60,9 +60,11 @@ static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
>    * tlbiel instruction for hash, set invalidation
>    * i.e., r=1 and is=01 or is=10 or is=11
>    */
> -static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
> -					unsigned int pid,
> -					unsigned int ric, unsigned int prs)
> +static __always_inline void tlbiel_hash_set_isa300(unsigned int set,
> +						   unsigned int is,
> +						   unsigned int pid,
> +						   unsigned int ric,
> +						   unsigned int prs)

Please don't split the line more than it is.

powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl

>   {
>   	unsigned long rb;
>   	unsigned long rs;
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 4d841369399f..91c4242c1be3 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -29,9 +29,11 @@
>    * tlbiel instruction for radix, set invalidation
>    * i.e., r=1 and is=01 or is=10 or is=11
>    */
> -static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
> -					unsigned int pid,
> -					unsigned int ric, unsigned int prs)
> +static __always_inline void tlbiel_radix_set_isa300(unsigned int set,
> +						    unsigned int is,
> +						    unsigned int pid,
> +						    unsigned int ric,
> +						    unsigned int prs)

Please don't split the line more than it is.

>   {
>   	unsigned long rb;
>   	unsigned long rs;
> @@ -150,8 +152,8 @@ static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
>   	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> -				unsigned long ric)
> +static __always_inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> +						unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -167,8 +169,8 @@ static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
>   }
>   
>   
> -static inline void __tlbiel_va(unsigned long va, unsigned long pid,
> -			       unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbiel_va(unsigned long va, unsigned long pid,
> +					unsigned long ap, unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -183,8 +185,8 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
>   	trace_tlbie(0, 1, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbie_va(unsigned long va, unsigned long pid,
> -			      unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
> +				       unsigned long ap, unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -199,8 +201,10 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
>   	trace_tlbie(0, 0, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
> -			      unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_lpid_va(unsigned long va,
> +					    unsigned long lpid,
> +					    unsigned long ap,
> +					    unsigned long ric)

Please don't split the line more than it is.


>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -239,7 +243,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
>   /*
>    * We use 128 set in radix mode and 256 set in hpt mode.
>    */
> -static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
> +static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>   {
>   	int set;
>   
> @@ -341,7 +345,8 @@ static inline void _tlbie_lpid(unsigned long lpid, unsigned long ric)
>   	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>   }
>   
> -static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
> +static __always_inline void _tlbiel_lpid_guest(unsigned long lpid,
> +					       unsigned long ric)

Please don't split the line more than it is.

>   {
>   	int set;
>   
> @@ -381,8 +386,8 @@ static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
>   		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
>   }
>   
> -static inline void _tlbiel_va(unsigned long va, unsigned long pid,
> -			      unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbiel_va(unsigned long va, unsigned long pid,
> +				       unsigned long psize, unsigned long ric)
>   {
>   	unsigned long ap = mmu_get_ap(psize);
>   
> @@ -413,8 +418,8 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
>   		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
>   }
>   
> -static inline void _tlbie_va(unsigned long va, unsigned long pid,
> -			      unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
> +				      unsigned long psize, unsigned long ric)
>   {
>   	unsigned long ap = mmu_get_ap(psize);
>   
> @@ -424,8 +429,9 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
>   	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>   }
>   
> -static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
> -			      unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
> +					   unsigned long psize,
> +					   unsigned long ric)

Please don't split the line more than it is.

>   {
>   	unsigned long ap = mmu_get_ap(psize);
>   
> 

Christophe
