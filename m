Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40884618CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfGHBTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:19:41 -0400
Received: from ozlabs.org ([203.11.71.1]:57457 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfGHBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfs4k9gz9sNs; Mon,  8 Jul 2019 11:19:33 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6d3ca7e73642ce17398f4cd5df1780da4a1ccdaf
In-Reply-To: <1558444404-12254-1-git-send-email-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] powerpc/mm: mark more tlb functions as __always_inline
Message-Id: <45hnfs4k9gz9sNs@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 13:13:24 UTC, Masahiro Yamada wrote:
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
> 
>   arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
>   arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
>     104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>         |  ^~~
>   arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
> 
> Fixing _tlbiel_pid() is enough to address the warning above, but I
> inlined more functions to fix all potential issues.
> 
> To meet the "i" (immediate) constraint for the asm operands, functions
> propagating "ric" must be always inlined.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6d3ca7e73642ce17398f4cd5df1780da4a1ccdaf

cheers
