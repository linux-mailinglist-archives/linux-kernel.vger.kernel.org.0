Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCB102141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 10:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKSJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 04:54:47 -0500
Received: from relay.sw.ru ([185.231.240.75]:53948 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKSJyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:54:46 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iX0DD-0002dW-Cu; Tue, 19 Nov 2019 12:54:19 +0300
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
References: <20191031093909.9228-1-dja@axtens.net>
 <20191031093909.9228-2-dja@axtens.net> <1573835765.5937.130.camel@lca.pw>
 <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com>
Date:   Tue, 19 Nov 2019 12:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/19 6:29 AM, Daniel Axtens wrote:
> Qian Cai <cai@lca.pw> writes:
> 
>> On Thu, 2019-10-31 at 20:39 +1100, Daniel Axtens wrote:
>>>  	/*
>>>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
>>>  	 * flag. It means that vm_struct is not fully initialized.
>>> @@ -3377,6 +3411,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>>>  
>>>  		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>>>  				 pcpu_get_vm_areas);
>>> +
>>> +		/* assume success here */
>>> +		kasan_populate_vmalloc(sizes[area], vms[area]);
>>>  	}
>>>  	spin_unlock(&vmap_area_lock);
>>
>> Here it is all wrong. GFP_KERNEL with in_atomic().
> 
> I think this fix will work, I will do a v12 with it included.
 
You can send just the fix. Andrew will fold it into the original patch before sending it to Linus.



> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a4b950a02d0b..bf030516258c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  
>                 setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>                                  pcpu_get_vm_areas);
> +       }
> +       spin_unlock(&vmap_area_lock);
>  
> +       /* populate the shadow space outside of the lock */
> +       for (area = 0; area < nr_vms; area++) {
>                 /* assume success here */
>                 kasan_populate_vmalloc(sizes[area], vms[area]);
>         }
> -       spin_unlock(&vmap_area_lock);
>  
>         kfree(vas);
>         return vms;
> 
> 
