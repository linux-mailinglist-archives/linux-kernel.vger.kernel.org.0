Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73EBB5DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfIRHIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 03:08:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfIRHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:08:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EECFF18A2394B65530A0;
        Wed, 18 Sep 2019 15:08:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 15:08:48 +0800
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
To:     Wei Yang <richardw.yang@linux.intel.com>
CC:     <rppt@linux.ibm.com>, <akpm@linux-foundation.org>,
        <osalvador@suse.de>, <mhocko@suse.co>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <cai@lca.pw>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
 <20190918065140.GA5446@richard>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <a0cbf140-7045-81bf-4686-6e742f97ceb8@huawei.com>
Date:   Wed, 18 Sep 2019 15:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190918065140.GA5446@richard>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/18 14:51, Wei Yang wrote:
> On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
>> Currently, when memblock_find_in_range_node() fail on the exact node, it
>> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
>> the work is good, but when the large memory is insufficient and the
>> small memory is enough, we want to allocate the small memory of this
>> node first, and do not need to allocate large memory from other nodes.
>>
>> In sparse_buffer_init(), it will prepare large chunks of memory for page
>> structure. The page management structure requires a lot of memory, but
>> if the node does not have enough memory, it can be converted to a small
>> memory allocation without having to allocate it from other nodes.
>>
>> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
>> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
>> not allocate from other nodes when a single node fails to allocate.
>>
>> If large contiguous block memory allocated fail in sparse_buffer_init(),
>> it will allocates small block memmory section by section later.
>>
> 
> Looks this changes current behavior even it fall back to section based
> allocation.
> 
When fall back to section allocation, it still use %MEMBLOCK_ALLOC_ACCESSIBLE
,I think the behavior is not change, Can you tell me the detail about the
changes. thanks.


>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> include/linux/memblock.h | 1 +
>> mm/memblock.c            | 3 ++-
>> mm/sparse.c              | 2 +-
>> 3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f491690..9a81d9c 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -339,6 +339,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>> #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>> #define MEMBLOCK_ALLOC_ACCESSIBLE	0
>> #define MEMBLOCK_ALLOC_KASAN		1
>> +#define MEMBLOCK_ALLOC_EXACT_NODE	2
>>
>> /* We are using top down, so it is safe to use 0 here */
>> #define MEMBLOCK_LOW_LIMIT 0
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 7d4f61a..dbd52c3c 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -277,6 +277,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>>
>> 	/* pump up @end */
>> 	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
>> +	    end == MEMBLOCK_ALLOC_EXACT_NODE ||
>> 	    end == MEMBLOCK_ALLOC_KASAN)
>> 		end = memblock.current_limit;
>>
>> @@ -1365,7 +1366,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> 	if (found && !memblock_reserve(found, size))
>> 		goto done;
>>
>> -	if (nid != NUMA_NO_NODE) {
>> +	if (end != MEMBLOCK_ALLOC_EXACT_NODE && nid != NUMA_NO_NODE) {
>> 		found = memblock_find_in_range_node(size, align, start,
>> 						    end, NUMA_NO_NODE,
>> 						    flags);
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 72f010d..828db46 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -477,7 +477,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>> 	sparsemap_buf =
>> 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>> 						addr,
>> -						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>> +						MEMBLOCK_ALLOC_EXACT_NODE, nid);
>> 	sparsemap_buf_end = sparsemap_buf + size;
>> }
>>
>> -- 
>> 2.7.4.huawei.3
>>
> 

