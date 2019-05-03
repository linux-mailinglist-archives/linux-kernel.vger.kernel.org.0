Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB513389
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfECSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 14:15:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:44738 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfECSPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:15:36 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x43IF9Dv008894;
        Fri, 3 May 2019 13:15:09 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x43IF8rU008889;
        Fri, 3 May 2019 13:15:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 3 May 2019 13:15:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Remove memory clobber asm constraint on dcbX() functions
Message-ID: <20190503181508.GQ8599@gate.crashing.org>
References: <20180109065759.4E54B6C73D@localhost.localdomain> <e482662f-254c-4ab7-b0a8-966a3159d705@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e482662f-254c-4ab7-b0a8-966a3159d705@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Fri, May 03, 2019 at 04:14:13PM +0200, Christophe Leroy wrote:
> A while ago I proposed the following patch, and didn't get any comment 
> back on it.

I didn't see it.  Maybe because of holiday :-)

> Do you have any opinion on it ? Is it good and worth it ?

> Le 09/01/2018 à 07:57, Christophe Leroy a écrit :
> >Instead of just telling GCC that dcbz(), dcbi(), dcbf() and dcbst()
> >clobber memory, tell it what it clobbers:
> >* dcbz(), dcbi() and dcbf() clobbers one cacheline as output
> >* dcbf() and dcbst() clobbers one cacheline as input

You cannot "clobber input".

Seen another way, only dcbi clobbers anything; dcbz zeroes it instead,
and dcbf and dcbst only change in what caches the data hangs out.

> >--- a/arch/powerpc/include/asm/cache.h
> >+++ b/arch/powerpc/include/asm/cache.h
> >@@ -82,22 +82,31 @@ extern void _set_L3CR(unsigned long);
> >  
> >  static inline void dcbz(void *addr)
> >  {
> >-	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
> >+	__asm__ __volatile__ ("dcbz 0, %1" :
> >+			      "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
> >+			      "r"(addr) :);
> >  }

The instruction does *not* work on the memory pointed to by addr.  It
works on the cache line containing the address addr.

If you want to have addr always aligned, you need to document this, and
check all callers, etc.

> >  static inline void dcbf(void *addr)
> >  {
> >-	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
> >+	__asm__ __volatile__ ("dcbf 0, %1" :
> >+			      "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
> >+			      "r"(addr), "m"(*(char 
> >(*)[L1_CACHE_BYTES])addr) :
> >+			     );
> >  }

Newline damage...  Was that your mailer?


Also, you may want a "memory" clobber anyway, to get ordering correct
for the synchronisation instructions.

I think your changes make things less robust than they were before.


[ Btw.  Instead of

	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");

you can do

	__asm__ __volatile__ ("dcbf %0" : : "Z"(addr) : "memory");

to save some insns here and there. ]


Segher
