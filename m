Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B604C85B19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfHHGxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 02:53:25 -0400
Received: from ozlabs.org ([203.11.71.1]:60309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730903AbfHHGxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:53:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463zbk1Dm3z9sMr;
        Thu,  8 Aug 2019 16:53:22 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alastair D'Silva <alastair@d-silva.org>
Subject: powerpc flush_inval_dcache_range() was buggy until v5.3-rc1 (was Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline flush_dcache_range())
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr> <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
Date:   Thu, 08 Aug 2019 16:53:21 +1000
Message-ID: <87ef1wtafy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ deliberately broke threading so this doesn't get buried ]

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index a4fd536efb44..1b0a42c50ef1 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -115,35 +115,6 @@ _ASM_NOKPROBE_SYMBOL(flush_icache_range)
>  EXPORT_SYMBOL(flush_icache_range)
>  
>  /*
> - * Like above, but only do the D-cache.
> - *
> - * flush_dcache_range(unsigned long start, unsigned long stop)
> - *
> - *    flush all bytes from start to stop-1 inclusive
> - */
> -
> -_GLOBAL_TOC(flush_dcache_range)
> - 	ld	r10,PPC64_CACHES@toc(r2)
> -	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
> -	addi	r5,r7,-1
> -	andc	r6,r3,r5		/* round low to line bdy */
> -	subf	r8,r6,r4		/* compute length */
> -	add	r8,r8,r5		/* ensure we get enough */
> -	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)/* Get log-2 of dcache block size */
> -	srw.	r8,r8,r9		/* compute line count */
          ^
> -	beqlr				/* nothing to do? */

Alastair noticed that this was a 32-bit right shift.

Meaning if you called flush_dcache_range() with a range larger than 4GB,
it did nothing and returned.

That code (which was previously called flush_inval_dcache_range()) was
merged back in 2005:

  https://github.com/mpe/linux-fullhistory/commit/faa5ee3743ff9b6df9f9a03600e34fdae596cfb2#diff-67c7ffa8e420c7d4206cae4a9e888e14


Back then it was only used by the smu.c driver, which presumably wasn't
flushing more than 4GB.

Over time it grew more users:

  v4.17 (Apr 2018): fb5924fddf9e ("powerpc/mm: Flush cache on memory hot(un)plug")
  v4.15 (Nov 2017): 6c44741d75a2 ("powerpc/lib: Implement UACCESS_FLUSHCACHE API")
  v4.15 (Nov 2017): 32ce3862af3c ("powerpc/lib: Implement PMEM API")
  v4.8  (Jul 2016): c40785ad305b ("powerpc/dart: Use a cachable DART")

The DART case doesn't matter, but the others probably could. I assume
the lack of bug reports is due to the fact that pmem stuff is still in
development and the lack of flushing usually doesn't actually matter? Or
are people flushing/hotplugging < 4G at a time?

Anyway we probably want to backport the fix below to various places?

cheers


diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 1ad4089dd110..802f5abbf061 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -148,7 +148,7 @@ _GLOBAL(flush_inval_dcache_range)
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	sync
 	isync
