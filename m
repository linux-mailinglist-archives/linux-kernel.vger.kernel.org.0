Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F63B78A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbfISLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 07:43:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388688AbfISLni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:43:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28BDE19F94551683E666;
        Thu, 19 Sep 2019 19:43:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 19:43:33 +0800
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     <akpm@linux-foundation.org>, <osalvador@suse.de>, <mhocko@suse.co>,
        <dan.j.williams@intel.com>, <david@redhat.com>,
        <richardw.yang@linux.intel.com>, <cai@lca.pw>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
 <20190919044753.GA20548@linux.ibm.com>
 <6d23d00c-f400-f486-dc6d-31b6f141d913@huawei.com>
 <20190919092836.GA22691@linux.ibm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <19cb9d42-f237-5534-371b-af31e40b0f39@huawei.com>
Date:   Thu, 19 Sep 2019 19:43:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190919092836.GA22691@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/19 17:28, Mike Rapoport wrote:
> On Thu, Sep 19, 2019 at 03:14:22PM +0800, Yunfeng Ye wrote:
>>
>>
>> On 2019/9/19 12:47, Mike Rapoport wrote:
>>> Hi,
>>>
>>> On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
>>>> Currently, when memblock_find_in_range_node() fail on the exact node, it
>>>> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
>>>> the work is good, but when the large memory is insufficient and the
>>>> small memory is enough, we want to allocate the small memory of this
>>>> node first, and do not need to allocate large memory from other nodes.
>>>>
>>>> In sparse_buffer_init(), it will prepare large chunks of memory for page
>>>> structure. The page management structure requires a lot of memory, but
>>>> if the node does not have enough memory, it can be converted to a small
>>>> memory allocation without having to allocate it from other nodes.
>>>>
>>>> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
>>>> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
>>>> not allocate from other nodes when a single node fails to allocate.
>>>>
>>>> If large contiguous block memory allocated fail in sparse_buffer_init(),
>>>> it will allocates small block memmory section by section later.
>>>
>>> Did you see the sparse_buffer_init() actually falling back to allocate from a
>>> different node? If a node does not have enough memory to hold it's own
>>> memory map, filling only it with parts of the memory map will not make such
>>> node usable.
>>>  
>> Normally, it won't happen that sparse_buffer_init() falling back from a different
>> node, because page structure size is 64 bytes per 4KB of memory, no more than 2%
>> of total available memory. But in the special cases, for eaxmple, memory address
>> is isolated by BIOS when memory failure, split the total memory many pieces,
>> although we have enough memory, but no large contiguous block memory in one node.
>> sparse_buffer_init() needs large contiguous block memory to be alloc in one time,
>>
>> Eg, the size of memory is 1TB, sparse_buffer_init() need 1TB * 64/4096 = 16GB, but
>> we have 100 blocks memory which every block only have 10GB, although total memory
>> have almost 100*10GB=1TB, but no contiguous 16GB block.
>  
> An explanation that a node memory may become highly fragmented should be a
> part of the changelog.
> 
ok, thanks for your advice.

>> Before commit 2a3cb8baef71 ("mm/sparse: delete old sparse_init and enable new one"),
>> we have %CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER config to meeting this situation,
>> after that, it fall back to allocate memory from other nodes, so have the performance
>> impact by remote numa access.
>>
>> commit 85c77f791390 ("mm/sparse: add new sparse_init_nid() and sparse_init()") wrote
>> that:
>>     "
>>     sparse_init_nid(), which only
>>     operates within one memory node, and thus allocates memory either in large
>>     contiguous block or allocates section by section
>>     "
>> it means that allocates section by section is a normal choice too, so I think add
>> %MEMBLOCK_ALLOC_EXACT_NODE is also a choice for this situation. Most cases,
>> sparse_buffer_init() works good and not allocated from other nodes at present.
> 
> I'd prefer to see memblock_alloc_exact_nid_raw() wrapper for
> memblock_find_in_range_node() rather than using a flag.
>  
I've also thought about this modification method, I will modify as you suggest. thanks.

>> thanks.
>> Yunfeng Ye
>>
>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>> ---
>>>>  include/linux/memblock.h | 1 +
>>>>  mm/memblock.c            | 3 ++-
>>>>  mm/sparse.c              | 2 +-
>>>>  3 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>>> index f491690..9a81d9c 100644
>>>> --- a/include/linux/memblock.h
>>>> +++ b/include/linux/memblock.h
>>>> @@ -339,6 +339,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>>>>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>>>>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
>>>>  #define MEMBLOCK_ALLOC_KASAN		1
>>>> +#define MEMBLOCK_ALLOC_EXACT_NODE	2
>>>>
>>>>  /* We are using top down, so it is safe to use 0 here */
>>>>  #define MEMBLOCK_LOW_LIMIT 0
>>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>>> index 7d4f61a..dbd52c3c 100644
>>>> --- a/mm/memblock.c
>>>> +++ b/mm/memblock.c
>>>> @@ -277,6 +277,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>>>>
>>>>  	/* pump up @end */
>>>>  	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
>>>> +	    end == MEMBLOCK_ALLOC_EXACT_NODE ||
>>>>  	    end == MEMBLOCK_ALLOC_KASAN)
>>>>  		end = memblock.current_limit;
>>>>
>>>> @@ -1365,7 +1366,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>>>  	if (found && !memblock_reserve(found, size))
>>>>  		goto done;
>>>>
>>>> -	if (nid != NUMA_NO_NODE) {
>>>> +	if (end != MEMBLOCK_ALLOC_EXACT_NODE && nid != NUMA_NO_NODE) {
>>>>  		found = memblock_find_in_range_node(size, align, start,
>>>>  						    end, NUMA_NO_NODE,
>>>>  						    flags);
>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>> index 72f010d..828db46 100644
>>>> --- a/mm/sparse.c
>>>> +++ b/mm/sparse.c
>>>> @@ -477,7 +477,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>>>>  	sparsemap_buf =
>>>>  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>>>>  						addr,
>>>> -						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>>> +						MEMBLOCK_ALLOC_EXACT_NODE, nid);
>>>>  	sparsemap_buf_end = sparsemap_buf + size;
>>>>  }
>>>>
>>>> -- 
>>>> 2.7.4.huawei.3
>>>>
>>>>
>>>
>>
> 

