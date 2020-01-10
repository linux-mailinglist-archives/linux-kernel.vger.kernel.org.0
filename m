Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371E01368CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 09:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgAJILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 03:11:31 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40816 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgAJILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:11:31 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 697392E14AA;
        Fri, 10 Jan 2020 11:11:25 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id HIOfp8l2J0-BOd0mKWJ;
        Fri, 10 Jan 2020 11:11:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578643885; bh=Td6n3LmkYF6te1Ej8XPdG2Jz8fiufglcj685eis30sw=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=IhrVs0rJmCUiqjoy8rNANIP9XgQD6DGlWAVtFRIYeNUheRbQBzgAkT7TwRptQmY+l
         ZX8wUNXMFy+c5OYmTeaYTe7Us6iycpiFzlqnD8bkCIudGJo9GSAP1zJg/YvRM2HyNt
         PTFgFKEaB2sw27TB6kw41nkvSCS6UJ98ynKm9CMs=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zdLm6dw9KS-BOWOHJ3F;
        Fri, 10 Jan 2020 11:11:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
To:     Wei Yang <richardw.yang@linux.intel.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
References: <157839239609.694.10268055713935919822.stgit@buzz>
 <20200108023211.GC13943@richard>
 <b019b294-61fa-85fc-cf43-c6d3e9fddc71@yandex-team.ru>
 <20200109025240.GA2000@richard>
 <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard> <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
Date:   Fri, 10 Jan 2020 11:11:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110053442.GA27846@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2020 08.34, Wei Yang wrote:
> On Fri, Jan 10, 2020 at 11:23:59AM +0800, Li Xinhai wrote:
>> On 2020-01-10 at 10:30 Wei Yang wrote:
>>> On Thu, Jan 09, 2020 at 11:54:21AM +0300, Konstantin Khlebnikov wrote:
>>>>
>>>>
>>>> On 09/01/2020 05.52, Wei Yang wrote:
>>>>> On Wed, Jan 08, 2020 at 01:40:44PM +0300, Konstantin Khlebnikov wrote:
>>>>>> On 08/01/2020 05.32, Wei Yang wrote:
>>>>>>> On Tue, Jan 07, 2020 at 01:19:56PM +0300, Konstantin Khlebnikov wrote:
>>>>>>>> This fixes some misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
>>>>>>>> mergeable anon_vma as parent when fork"). It merges anon-vma in unexpected
>>>>>>>> way but fortunately still produces valid anon-vma tree, so nothing crashes.
>>>>>>>>
>>>>>>>> If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
>>>>>>>> before all patches in child process related VMAs: DST1 DST2 .. DSTn will
>>>>>>>> fork indepndent anon-vmas: ANON1 ANON2 .. ANONn (each is child of ANON0).
>>>>>>>> Before this patch only DST1 will fork new ANON1 and following DST2 .. DSTn
>>>>>>>> will share parent's ANON0 (i.e. anon-vma tree is valid but isn't optimal).
>>>>>>>> With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.
>>>>>>>>
>>>>>>>> Root problem caused by initialization order in dup_mmap(): vma->vm_prev
>>>>>>>> is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
>>>>>>>> previous VMA in parent mm.
>>>>>>>>
>>>>>>>> Second problem is hidden behind first one: assumption "Parent has vm_prev,
>>>>>>>> which implies we have vm_prev" is wrong if first VMA in parent mm has set
>>>>>>>> flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
>>>>>>>> because in current code 'prev' actually is same as 'pprev'.
>>>>>>>>
>>>>>>>> Third hidden problem is linking between VMA and anon-vmas whose pages it
>>>>>>>> could contain. Loop in anon_vma_clone() attaches only parent's anon-vmas,
>>>>>>>> shared anon-vma isn't attached. But every mapped page stays reachable in
>>>>>>>> rmap because we erroneously share anon-vma from parent's previous VMA.
>>>>>>>>
>>>>>>>> This patch moves sharing logic out of anon_vma_clone() into more specific
>>>>>>>> anon_vma_fork() because this supposed to work only at fork() and simply
>>>>>>>> reuses anon_vma from previous VMA if it is forked from the same anon-vma.
>>>>>>>>
>>>>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>>>>> Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
>>>>>>>> Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
>>>>>>>> Link: https://lore.kernel.org/linux-mm/CALYGNiNzz+dxHX0g5-gNypUQc3B=8_Scp53-NTOh=zWsdUuHAw@mail.gmail.com/T/#t
>>>>>>>> ---
>>>>>>>> include/linux/rmap.h |    3 ++-
>>>>>>>> kernel/fork.c        |    2 +-
>>>>>>>> mm/rmap.c            |   23 +++++++++--------------
>>>>>>>> 3 files changed, 12 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>>>>> index 988d176472df..560e4480dcd0 100644
>>>>>>>> --- a/include/linux/rmap.h
>>>>>>>> +++ b/include/linux/rmap.h
>>>>>>>> @@ -143,7 +143,8 @@ void anon_vma_init(void);	/* create anon_vma_cachep */
>>>>>>>> int  __anon_vma_prepare(struct vm_area_struct *);
>>>>>>>> void unlink_anon_vmas(struct vm_area_struct *);
>>>>>>>> int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
>>>>>>>> -int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
>>>>>>>> +int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
>>>>>>>> +	  struct vm_area_struct *prev);
>>>>>>>>
>>>>>>>> static inline int anon_vma_prepare(struct vm_area_struct *vma)
>>>>>>>> {
>>>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>>>> index 2508a4f238a3..c33626993831 100644
>>>>>>>> --- a/kernel/fork.c
>>>>>>>> +++ b/kernel/fork.c
>>>>>>>> @@ -556,7 +556,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>> tmp->anon_vma = NULL;
>>>>>>>> if (anon_vma_prepare(tmp))
>>>>>>>> goto fail_nomem_anon_vma_fork;
>>>>>>>> -	} else if (anon_vma_fork(tmp, mpnt))
>>>>>>>> +	} else if (anon_vma_fork(tmp, mpnt, prev))
>>>>>>>> goto fail_nomem_anon_vma_fork;
>>>>>>>> tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
>>>>>>>> tmp->vm_next = tmp->vm_prev = NULL;
>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>> index b3e381919835..3c1e04389291 100644
>>>>>>>> --- a/mm/rmap.c
>>>>>>>> +++ b/mm/rmap.c
>>>>>>>> @@ -269,19 +269,6 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>>>>>>> {
>>>>>>>> struct anon_vma_chain *avc, *pavc;
>>>>>>>> struct anon_vma *root = NULL;
>>>>>>>> -	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
>>>>>>>> -
>>>>>>>> -	/*
>>>>>>>> -	* If parent share anon_vma with its vm_prev, keep this sharing in in
>>>>>>>> -	* child.
>>>>>>>> -	*
>>>>>>>> -	* 1. Parent has vm_prev, which implies we have vm_prev.
>>>>>>>> -	* 2. Parent and its vm_prev have the same anon_vma.
>>>>>>>> -	*/
>>>>>>>> -	if (!dst->anon_vma && src->anon_vma &&
>>>>>>>> -	    pprev && pprev->anon_vma == src->anon_vma)
>>>>>>>> -	dst->anon_vma = prev->anon_vma;
>>>>>>>> -
>>>>>>>>
>>>>>>>> list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>>>>>>>> struct anon_vma *anon_vma;
>>>>>>>> @@ -332,7 +319,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>>>>>>>      * the corresponding VMA in the parent process is attached to.
>>>>>>>>      * Returns 0 on success, non-zero on failure.
>>>>>>>>      */
>>>>>>>> -int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>>>>>>>> +int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
>>>>>>>> +	  struct vm_area_struct *prev)
>>>>>>>> {
>>>>>>>> struct anon_vma_chain *avc;
>>>>>>>> struct anon_vma *anon_vma;
>>>>>>>> @@ -342,6 +330,13 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>>>>>>>> if (!pvma->anon_vma)
>>>>>>>> return 0;
>>>>>>>>
>>>>>>>> +	/* Share anon_vma with previous VMA if it has the same parent. */
>>>>>>>> +	if (prev && prev->anon_vma &&
>>>>>>>> +	    prev->anon_vma->parent == pvma->anon_vma) {
>>>>>>>> +	vma->anon_vma = prev->anon_vma;
>>>>>>>> +	return anon_vma_clone(vma, prev);
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>
>>>>>>> I am afraid this one change the intended behavior. Let's put a chart to
>>>>>>> describe.
>>>>>>>
>>>>>>> Commit 4e4a9eb92133 ("mm/rmap.c: reusemergeable anon_vma as parent when
>>>>>>> fork") tries to improve the following situation.
>>>>>>>
>>>>>>> Before the commit, the behavior is like this:
>>>>>>>
>>>>>>> Parent process:
>>>>>>>
>>>>>>>           +-----+
>>>>>>>           | pav |<-----------------+----------------------+
>>>>>>>           +-----+                  |                      |
>>>>>>>                                    |                      |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>                        |pprev      |          |pvma       |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>
>>>>>>> Child Process
>>>>>>>
>>>>>>>
>>>>>>>           +-----+                     +-----+
>>>>>>>           | av1 |<-----------------+  | av2 |<------------+
>>>>>>>           +-----+                  |  +-----+             |
>>>>>>>                                    |                      |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>                        |prev       |          |vma        |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>
>>>>>>>
>>>>>>> Parent pprev and pvma share the same anon_vma due to
>>>>>>> find_mergeable_anon_vma(). While the anon_vma_clone() would pick up different
>>>>>>> anon_vma for child process's vma.
>>>>>>>
>>>>>>> The purpose of my commit is to give child process the following shape.
>>>>>>>
>>>>>>>           +-----+
>>>>>>>           | av  |<-----------------+----------------------+
>>>>>>>           +-----+                  |                      |
>>>>>>>                                    |                      |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>                        |prev       |          |vma        |
>>>>>>>                        +-----------+          +-----------+
>>>>>>>
>>>>>>> After this, we reduce the extra "av2" for child process. But yes, because of
>>>>>>> the two reasons you found, it didn't do the exact thing.
>>>>>>>
>>>>>>> While if my understanding is correct, the anon_vma_clone() would pick up any
>>>>>>> anon_vma in its process tree, except parent's. If this fails to get a reusable
>>>>>>> one, anon_vma_fork() would allocate one, whose parent is pvma->anon_vma.
>>>>>>>
>>>>>>> Let me summarise original behavior:
>>>>>>>
>>>>>>>       * if anon_vma_clone succeed, it find one anon_vma in the process tree, but
>>>>>>>         it could not be pvma->anon_vma
>>>>>>>       * if anon_vma_clone fail, it will allocate a new anon_vma and its parent is
>>>>>>>         pvma->anon_vam
>>>>>>>
>>>>>>> Then take a look into your code here.
>>>>>>>
>>>>>>> "prev->anon_vma->parent == pvma->anon_vma" means prev->anon_vma parent is
>>>>>>> pvma's anon_vma. If my understanding is correct, this just match the second
>>>>>>> case. For "prev", we didn't find a reusable anon_vma and allocate a new one.
>>>>>>>
>>>>>>> But how about the first case? prev reuse an anon_vma in the process tree which
>>>>>>> is not parent's?
>>>>>>
>>>>>> If anon_vma_clone() pick old anon-vma for first vma in sharing chain (prev)
>>>>>> then second vma (vma) will fork new anon-vma (unless pick another old anon-vma),
>>>>>> then third vma will share it. And so on.
>>>>>
>>>>> No, I am afraid you are not correct here. Or I don't understand your sentence.
>>>>>
>>>>> This is my understanding about the behavior before my commit. Suppose av1 and
>>>>> av2 are both reused from old anon_vma. And if my understanding is correct,
>>>>> they are different from pvma->anon_vma. Then how your code match this
>>>>> situatioin?
>>>>>
>>>>>            +-----+                     +-----+
>>>>>            | av1 |<-----------------+  | av2 |<------------+
>>>>>            +-----+                  |  +-----+             |
>>>>>                                     |                      |
>>>>>                         +-----------+          +-----------+
>>>>>                         |prev       |          |vma        |
>>>>>                         +-----------+          +-----------+
>>>>>
>>>>> Would you explain your understanding the second and third vma in your
>>>>> sentence? Which case you are trying to illustrate?
>>>>
>>>> series of vma in parent with shared AV:
>>>>
>>>> SRC1 - AV0
>>>> SRC2 - AV0
>>>> SRC3 - AV0
>>>> ...
>>>> SRCn - AV0
>>>>
>>>> in child after fork
>>>>
>>>> DST1 - AV_OLD_1 (some old vma, picked by anon_vma_clone) plus DST1 is attached to same AVs as SRC1
>>>> DST2 - AV_OLD_2 (other old vma) plus DST1 is attached to same AVs as SRC2
>>>> DST2 - AV1 prev AV parent does not match AV0, no old vma found for reusing -> allocate new one (child of AV0)
>>>> DST3 - AV1 - DST2->AV->parent == SRC3->AV (AV0) -> share AV with prev
>>>> DST4 - AV1 - same thing
>>>> ...
>>>> DSTn - AV1
>>>>
>>>
>>> Yes, your code works for DST3..DSTn. They will pick up AV1 since
>>> (DST2->AV->parent == SRC3->AV).
>>>
>>> My question is why DST1 and DST2 has different AV? The purpose of my patch
>>> tries to make child has the same topology and parent. So the ideal look of
>>> child is:
>>>
>>> DST1 - AV1
>>> DST2 - AV1
>>> DST2 - AV1
>>> DST3 - AV1
>>> DST4 - AV1
>>>
>>> Would you mind putting more words on DST1 and DST2? I didn't fully understand
>>> the logic here.
>>>
>>> Thanks
>>>
>>
>> I think that the first version is doing the work as you expected, but been
>> revised in second version, to limits the number of users of reused old
>> anon(which is picked in anon_vma_clone() and keep the tree structure.
>>
> 
> Any reason to reduce the reuse? Maybe I lost some point.

I've illustrated how two heuristics (reusing-old and sharing-prev) _could_ work together.
But they both are optional.

At cloning first vma SRC1 -> DST1 there is no prev to share anon vma,
thus works common code which _could_ reuse old vma because it have to.

If there is no old anon-vma which have to be reused then DST1 will allocate
new anon-vma (AV1) and it will be used by DST2 and so on like on your picture.

> 
>>> --
>>> Wei Yang
>>> Help you, Help me
> 
