Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803B01546EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 15:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBFO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 09:59:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727279AbgBFO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581001165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qKE8DtAnW6E8FOYZGPq7bwCUXlr3qjBsJI0ZuiIVcAc=;
        b=i7DI71pWFwymu3spfXJpdn6ifTWSrR9jpwmEIU10GoDPq7/+q7KBos+7PQ938STeY8eNU6
        DZbYyG88XWZ0jNFDSaEaCkMCvv1alRrGLO9lLAkLS6ga4PAzeHIYsf8bEtDhr55hvkixcL
        d587KrLUcqegUow/G8WJ23pontb9864=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-8LdsYHllMTy1lKdkBJN6jw-1; Thu, 06 Feb 2020 09:59:23 -0500
X-MC-Unique: 8LdsYHllMTy1lKdkBJN6jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D9D18B640D;
        Thu,  6 Feb 2020 14:59:22 +0000 (UTC)
Received: from [10.36.118.128] (unknown [10.36.118.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF804790EE;
        Thu,  6 Feb 2020 14:59:19 +0000 (UTC)
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Jan Kara <jack@suse.cz>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1580995070-25139-1-git-send-email-cai@lca.pw>
 <86f8eade-f2a7-75c6-0de9-9029b3b8c1e8@redhat.com>
 <20200206145501.GD26114@quack2.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <1d5a3f09-4127-4d57-e3b5-8f4a0bbc2bac@redhat.com>
Date:   Thu, 6 Feb 2020 15:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200206145501.GD26114@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.20 15:55, Jan Kara wrote:
> On Thu 06-02-20 14:33:22, David Hildenbrand wrote:
>> On 06.02.20 14:17, Qian Cai wrote:
>>> page->flags could be accessed concurrently as noticied by KCSAN,
>>>
>>>  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
>>>
>>>  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
>>>   page_cpupid_xchg_last+0x51/0x80
>>>   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
>>>   wp_page_reuse+0x3e/0xc0
>>>   wp_page_reuse at mm/memory.c:2453
>>>   do_wp_page+0x472/0x7b0
>>>   do_wp_page at mm/memory.c:2798
>>>   __handle_mm_fault+0xcb0/0xd00
>>>   handle_pte_fault at mm/memory.c:4049
>>>   (inlined by) __handle_mm_fault at mm/memory.c:4163
>>>   handle_mm_fault+0xfc/0x2f0
>>>   handle_mm_fault at mm/memory.c:4200
>>>   do_page_fault+0x263/0x6f9
>>>   do_user_addr_fault at arch/x86/mm/fault.c:1465
>>>   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
>>>   page_fault+0x34/0x40
>>>
>>>  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
>>>   put_page+0x15a/0x1f0
>>>   page_zonenum at include/linux/mm.h:923
>>>   (inlined by) is_zone_device_page at include/linux/mm.h:929
>>>   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
>>>   (inlined by) put_page at include/linux/mm.h:1023
>>>   wp_page_copy+0x571/0x930
>>>   wp_page_copy at mm/memory.c:2615
>>>   do_wp_page+0x107/0x7b0
>>>   __handle_mm_fault+0xcb0/0xd00
>>>   handle_mm_fault+0xfc/0x2f0
>>>   do_page_fault+0x263/0x6f9
>>>   page_fault+0x34/0x40
>>>
>>>  Reported by Kernel Concurrency Sanitizer on:
>>>  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
>>>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>>>
>>> Both the read and write are done only with the non-exclusive mmap_sem
>>> held. Since the read will check for specific bits (up to three bits for
>>> now) in the flag, load tearing could in theory trigger a logic bug.
>>>
>>> To fix it, it could introduce put_page_lockless() in those places but
>>> that could be an overkill, and difficult to use. Thus, just add
>>> READ_ONCE() for the read in page_zonenum() for now where it should not
>>> affect the performance and correctness with a small trade-off that
>>> compilers might generate less efficient optimization in some places.
>>>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>>  include/linux/mm.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 52269e56c514..f8529aa971c0 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -920,7 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>>>  
>>>  static inline enum zone_type page_zonenum(const struct page *page)
>>>  {
>>> -	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
>>> +	return (READ_ONCE(page->flags) >> ZONES_PGSHIFT) & ZONES_MASK;
>>
>> I can understand why other bits/flags might change, but not the zone
>> number? Nobody should be changing that without heavy locking (out of
>> memory hot(un)plug code). Or am I missing something? Can load tearing
>> actually produce an issue if these 3 bits will never change?
> 
> I don't think the problem is real. The question is how to make KCSAN happy
> in a way that doesn't silence other possibly useful things it can find and
> also which makes it most obvious to the reader what's going on... IMHO
> using READ_ONCE() fulfills these targets nicely - it is free
> performance-wise in this case, it silences the checker without impacting
> other races on page->flags, its kind of obvious we don't want the load torn
> in this case so it makes sense to the reader (although a comment may be
> nice).

Yes, I can understand that - but reading the other comments, I think I
am not the only one who doesn't like to see the code getting uglyfied
(sorry, but that's what it is) and harder to read just to make some code
checker happy.

Having that said, I don't really care. But I do think that expressing
"this is not possible but only to make $TOOL happy" in the commit
message is worth having. The patch description should be reworked.

-- 
Thanks,

David / dhildenb

