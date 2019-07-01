Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40581180E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 13:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEBLO7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 May 2019 07:14:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfEBLO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:14:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vt2m2kCrz9s7T;
        Thu,  2 May 2019 21:14:56 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 2/4] powerpc/mm: Move book3s64 specifics in subdirectory mm/book3s64
In-Reply-To: <7dbe8476-bfa3-29ac-5155-a67823d39ef4@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr> <c4afde657ef9e4ad0266ae62e9907313c41c4a16.1553853405.git.christophe.leroy@c-s.fr> <87sgtx5o0j.fsf@concordia.ellerman.id.au> <7dbe8476-bfa3-29ac-5155-a67823d39ef4@c-s.fr>
Date:   Thu, 02 May 2019 21:14:55 +1000
Message-ID: <87woj9xg40.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 02/05/2019 à 09:11, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> Many files in arch/powerpc/mm are only for book3S64. This patch
>>> creates a subdirectory for them.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/mm/Makefile                           | 25 +++----------------
>>>   arch/powerpc/mm/book3s64/Makefile                  | 28 ++++++++++++++++++++++
>>>   arch/powerpc/mm/{ => book3s64}/hash64_4k.c         |  0
>>>   arch/powerpc/mm/{ => book3s64}/hash64_64k.c        |  0
>>>   arch/powerpc/mm/{ => book3s64}/hash_native_64.c    |  0
>>>   arch/powerpc/mm/{ => book3s64}/hash_utils_64.c     |  0
>>>   arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c   |  0
>>>   .../powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c |  0
>>>   arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c |  0
>>>   .../mm/{ => book3s64}/mmu_context_book3s64.c       |  0
>>>   arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c |  0
>>>   arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c  |  0
>>>   arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c    |  0
>>>   arch/powerpc/mm/{ => book3s64}/pgtable-radix.c     |  0
>>>   arch/powerpc/mm/{ => book3s64}/pkeys.c             |  0
>>>   arch/powerpc/mm/{ => book3s64}/slb.c               |  0
>>>   arch/powerpc/mm/{ => book3s64}/subpage-prot.c      |  0
>>>   arch/powerpc/mm/{ => book3s64}/tlb-radix.c         |  0
>>>   arch/powerpc/mm/{ => book3s64}/tlb_hash64.c        |  0
>>>   arch/powerpc/mm/{ => book3s64}/vphn.c              |  0
>>>   arch/powerpc/mm/{ => book3s64}/vphn.h              |  0
>>>   arch/powerpc/mm/numa.c                             |  2 +-
>>>   22 files changed, 32 insertions(+), 23 deletions(-)
>>>   create mode 100644 arch/powerpc/mm/book3s64/Makefile
>>>   rename arch/powerpc/mm/{ => book3s64}/hash64_4k.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hash64_64k.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hash_native_64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hash_utils_64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/mmu_context_book3s64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/pgtable-radix.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/pkeys.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/slb.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/subpage-prot.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/tlb-radix.c (100%)
>>>   rename arch/powerpc/mm/{ => book3s64}/tlb_hash64.c (100%)
>> 
>> Do you mind if I take this but rework the destination names in the process?
>
> I don't mind, I think it's a good idea.
>
>> 
>> I don't like having eg. book3s64/pgtable-book3s64.c
>> 
>> And some of the other names could use a bit of cleanup too.
>> 
>> What about:
>> 
>>   arch/powerpc/mm/{hash64_4k.c => book3s64/hash_4k.c}
>>   arch/powerpc/mm/{hash64_64k.c => book3s64/hash_64k.c}
>>   arch/powerpc/mm/{hugepage-hash64.c => book3s64/hash_hugepage.c}
>>   arch/powerpc/mm/{hugetlbpage-hash64.c => book3s64/hash_hugetlbpage.c}
>>   arch/powerpc/mm/{hash_native_64.c => book3s64/hash_native.c}
>>   arch/powerpc/mm/{pgtable-hash64.c => book3s64/hash_pgtable.c}
>>   arch/powerpc/mm/{tlb_hash64.c => book3s64/hash_tlb.c}
>>   arch/powerpc/mm/{hash_utils_64.c => book3s64/hash_utils.c}
>>   arch/powerpc/mm/{mmu_context_iommu.c => book3s64/iommu_api.c}
>>   arch/powerpc/mm/{mmu_context_book3s64.c => book3s64/mmu_context.c}
>>   arch/powerpc/mm/{pgtable-book3s64.c => book3s64/pgtable.c}
>>   arch/powerpc/mm/{hugetlbpage-radix.c => book3s64/radix_hugetlbpage.c}
>>   arch/powerpc/mm/{pgtable-radix.c => book3s64/radix_pgtable.c}
>>   arch/powerpc/mm/{tlb-radix.c => book3s64/radix_tlb.c}
>
> Looks good

Thanks. I'll do something similar for 32-bit & nohash.

cheers
