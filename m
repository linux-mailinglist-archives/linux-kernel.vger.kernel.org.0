Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF316A0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 05:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfGPDBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 23:01:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50558 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730391AbfGPDBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:01:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TX1Qcid_1563246051;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX1Qcid_1563246051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 11:00:54 +0800
Subject: Re: list corruption in deferred_split_scan()
To:     Qian Cai <cai@lca.pw>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1562795006.8510.19.camel@lca.pw>
 <cd6e10bc-cb79-65c5-ff2b-4c244ae5eb1c@linux.alibaba.com>
 <1562879229.8510.24.camel@lca.pw>
 <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
 <1563225798.4610.5.camel@lca.pw>
 <5c853e6e-6367-d83c-bb97-97cd67320126@linux.alibaba.com>
 <8A64D551-FF5B-4068-853E-9E31AF323517@lca.pw>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e5aa1f5b-b955-5b8e-f502-7ac5deb141a7@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 20:00:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8A64D551-FF5B-4068-853E-9E31AF323517@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/19 6:36 PM, Qian Cai wrote:
>
>> On Jul 15, 2019, at 8:22 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/15/19 2:23 PM, Qian Cai wrote:
>>> On Fri, 2019-07-12 at 12:12 -0700, Yang Shi wrote:
>>>>> Another possible lead is that without reverting the those commits below,
>>>>> kdump
>>>>> kernel would always also crash in shrink_slab_memcg() at this line,
>>>>>
>>>>> map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map, true);
>>>> This looks a little bit weird. It seems nodeinfo[nid] is NULL? I didn't
>>>> think of where nodeinfo was freed but memcg was still online. Maybe a
>>>> check is needed:
>>> Actually, "memcg" is NULL.
>> It sounds weird. shrink_slab() is called in mem_cgroup_iter which does pin the memcg. So, the memcg should not go away.
> Well, the commit “mm: shrinker: make shrinker not depend on memcg kmem” changed this line in shrink_slab_memcg(),
>
> -	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
> +	if (!mem_cgroup_online(memcg))
> 		return 0;
>
> Since the kdump kernel has the parameter “cgroup_disable=memory”, shrink_slab_memcg() will no longer be able to handle NULL memcg from mem_cgroup_iter() as,
>
> if (mem_cgroup_disabled())		
> 	return NULL;

Aha, yes. memcg_kmem_enabled() implicitly checks !mem_cgroup_disabled(). 
Thanks for figuring this out. I think we need add mem_cgroup_dsiabled() 
check before calling shrink_slab_memcg() as below:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a0301ed..2f03c61 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -701,7 +701,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int 
nid,
         unsigned long ret, freed = 0;
         struct shrinker *shrinker;

-       if (!mem_cgroup_is_root(memcg))
+       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
                 return shrink_slab_memcg(gfp_mask, nid, memcg, priority);

         if (!down_read_trylock(&shrinker_rwsem))

>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index a0301ed..bacda49 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -602,6 +602,9 @@ static unsigned long shrink_slab_memcg(gfp_t
>>>> gfp_mask, int nid,
>>>>           if (!mem_cgroup_online(memcg))
>>>>                   return 0;
>>>>
>>>> +       if (!memcg->nodeinfo[nid])
>>>> +               return 0;
>>>> +
>>>>           if (!down_read_trylock(&shrinker_rwsem))
>>>>                   return 0;
>>>>
>>>>> [    9.072036][    T1] BUG: KASAN: null-ptr-deref in shrink_slab+0x111/0x440
>>>>> [    9.072036][    T1] Read of size 8 at addr 0000000000000dc8 by task
>>>>> swapper/0/1
>>>>> [    9.072036][    T1]
>>>>> [    9.072036][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-next-
>>>>> 20190711+ #10
>>>>> [    9.072036][    T1] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
>>>>> DL385
>>>>> Gen10, BIOS A40 01/25/2019
>>>>> [    9.072036][    T1] Call Trace:
>>>>> [    9.072036][    T1]  dump_stack+0x62/0x9a
>>>>> [    9.072036][    T1]  __kasan_report.cold.4+0xb0/0xb4
>>>>> [    9.072036][    T1]  ? unwind_get_return_address+0x40/0x50
>>>>> [    9.072036][    T1]  ? shrink_slab+0x111/0x440
>>>>> [    9.072036][    T1]  kasan_report+0xc/0xe
>>>>> [    9.072036][    T1]  __asan_load8+0x71/0xa0
>>>>> [    9.072036][    T1]  shrink_slab+0x111/0x440
>>>>> [    9.072036][    T1]  ? mem_cgroup_iter+0x98/0x840
>>>>> [    9.072036][    T1]  ? unregister_shrinker+0x110/0x110
>>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.072036][    T1]  ? mem_cgroup_protected+0x39/0x260
>>>>> [    9.072036][    T1]  shrink_node+0x31e/0xa30
>>>>> [    9.072036][    T1]  ? shrink_node_memcg+0x1560/0x1560
>>>>> [    9.072036][    T1]  ? ktime_get+0x93/0x110
>>>>> [    9.072036][    T1]  do_try_to_free_pages+0x22f/0x820
>>>>> [    9.072036][    T1]  ? shrink_node+0xa30/0xa30
>>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.072036][    T1]  ? check_chain_key+0x1df/0x2e0
>>>>> [    9.072036][    T1]  try_to_free_pages+0x242/0x4d0
>>>>> [    9.072036][    T1]  ? do_try_to_free_pages+0x820/0x820
>>>>> [    9.072036][    T1]  __alloc_pages_nodemask+0x9ce/0x1bc0
>>>>> [    9.072036][    T1]  ? gfp_pfmemalloc_allowed+0xc0/0xc0
>>>>> [    9.072036][    T1]  ? unwind_dump+0x260/0x260
>>>>> [    9.072036][    T1]  ? kernel_text_address+0x33/0xc0
>>>>> [    9.072036][    T1]  ? arch_stack_walk+0x8f/0xf0
>>>>> [    9.072036][    T1]  ? ret_from_fork+0x22/0x40
>>>>> [    9.072036][    T1]  alloc_page_interleave+0x18/0x130
>>>>> [    9.072036][    T1]  alloc_pages_current+0xf6/0x110
>>>>> [    9.072036][    T1]  allocate_slab+0x600/0x11f0
>>>>> [    9.072036][    T1]  new_slab+0x46/0x70
>>>>> [    9.072036][    T1]  ___slab_alloc+0x5d4/0x9c0
>>>>> [    9.072036][    T1]  ? create_object+0x3a/0x3e0
>>>>> [    9.072036][    T1]  ? fs_reclaim_acquire.part.15+0x5/0x30
>>>>> [    9.072036][    T1]  ? ___might_sleep+0xab/0xc0
>>>>> [    9.072036][    T1]  ? create_object+0x3a/0x3e0
>>>>> [    9.072036][    T1]  __slab_alloc+0x12/0x20
>>>>> [    9.072036][    T1]  ? __slab_alloc+0x12/0x20
>>>>> [    9.072036][    T1]  kmem_cache_alloc+0x32a/0x400
>>>>> [    9.072036][    T1]  create_object+0x3a/0x3e0
>>>>> [    9.072036][    T1]  kmemleak_alloc+0x71/0xa0
>>>>> [    9.072036][    T1]  kmem_cache_alloc+0x272/0x400
>>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.072036][    T1]  ? do_raw_spin_unlock+0xa8/0x140
>>>>> [    9.072036][    T1]  acpi_ps_alloc_op+0x76/0x122
>>>>> [    9.072036][    T1]  acpi_ds_execute_arguments+0x2f/0x18d
>>>>> [    9.072036][    T1]  acpi_ds_get_package_arguments+0x7d/0x84
>>>>> [    9.072036][    T1]  acpi_ns_init_one_package+0x33/0x61
>>>>> [    9.072036][    T1]  acpi_ns_init_one_object+0xfc/0x189
>>>>> [    9.072036][    T1]  acpi_ns_walk_namespace+0x114/0x1f2
>>>>> [    9.072036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>>> [    9.072036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>>> [    9.072036][    T1]  acpi_walk_namespace+0x9e/0xcb
>>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.072036][    T1]  acpi_ns_initialize_objects+0x99/0xed
>>>>> [    9.072036][    T1]  ? acpi_ns_find_ini_methods+0xa2/0xa2
>>>>> [    9.072036][    T1]  ? acpi_tb_load_namespace+0x2dc/0x2eb
>>>>> [    9.072036][    T1]  acpi_load_tables+0x61/0x80
>>>>> [    9.072036][    T1]  acpi_init+0x10d/0x44b
>>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.072036][    T1]  ? bus_uevent_filter+0x16/0x30
>>>>> [    9.072036][    T1]  ? kobject_uevent_env+0x109/0x980
>>>>> [    9.072036][    T1]  ? kernfs_get+0x13/0x20
>>>>> [    9.072036][    T1]  ? kobject_uevent+0xb/0x10
>>>>> [    9.072036][    T1]  ? kset_register+0x31/0x50
>>>>> [    9.072036][    T1]  ? kset_create_and_add+0x9f/0xd0
>>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.072036][    T1]  do_one_initcall+0xfe/0x45a
>>>>> [    9.072036][    T1]  ? initcall_blacklisted+0x150/0x150
>>>>> [    9.072036][    T1]  ? rwsem_down_read_slowpath+0x930/0x930
>>>>> [    9.072036][    T1]  ? kasan_check_write+0x14/0x20
>>>>> [    9.072036][    T1]  ? up_write+0x6b/0x190
>>>>> [    9.072036][    T1]  kernel_init_freeable+0x614/0x6a7
>>>>> [    9.072036][    T1]  ? rest_init+0x188/0x188
>>>>> [    9.072036][    T1]  kernel_init+0x11/0x138
>>>>> [    9.072036][    T1]  ? rest_init+0x188/0x188
>>>>> [    9.072036][    T1]  ret_from_fork+0x22/0x40
>>>>> [    9.072036][    T1]
>>>>> ==================================================================
>>>>> [    9.072036][    T1] Disabling lock debugging due to kernel taint
>>>>> [    9.145712][    T1] BUG: kernel NULL pointer dereference, address:
>>>>> 0000000000000dc8
>>>>> [    9.152036][    T1] #PF: supervisor read access in kernel mode
>>>>> [    9.152036][    T1] #PF: error_code(0x0000) - not-present page
>>>>> [    9.152036][    T1] PGD 0 P4D 0
>>>>> [    9.152036][    T1] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
>>>>> [    9.152036][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted:
>>>>> G    B             5.2.0-next-20190711+ #10
>>>>> [    9.152036][    T1] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
>>>>> DL385
>>>>> Gen10, BIOS A40 01/25/2019
>>>>> [    9.152036][    T1] RIP: 0010:shrink_slab+0x111/0x440
>>>>> [    9.152036][    T1] Code: c7 20 8d 44 82 e8 7f 8b e8 ff 85 c0 0f 84 e2 02
>>>>> 00
>>>>> 00 4c 63 a5 4c ff ff ff 49 81 c4 b8 01 00 00 4b 8d 7c e6 08 e8 3f 07 0e 00
>>>>> <4f>
>>>>> 8b 64 e6 08 49 8d bc 24 20 03 00 00 e8 2d 07 0e 00 49 8b 84 24
>>>>> [    9.152036][    T1] RSP: 0018:ffff88905757f100 EFLAGS: 00010282
>>>>> [    9.152036][    T1] RAX: 0000000000000000 RBX: ffff88905757f1b0 RCX:
>>>>> ffffffff8112f288
>>>>> [    9.152036][    T1] RDX: 1ffffffff049c088 RSI: dffffc0000000000 RDI:
>>>>> ffffffff824e0440
>>>>> [    9.152036][    T1] RBP: ffff88905757f1d8 R08: fffffbfff049c089 R09:
>>>>> fffffbfff049c088
>>>>> [    9.152036][    T1] R10: fffffbfff049c088 R11: ffffffff824e0443 R12:
>>>>> 00000000000001b8
>>>>> [    9.152036][    T1] R13: 0000000000000000 R14: 0000000000000000 R15:
>>>>> ffff88905757f440
>>>>> [    9.152036][    T1] FS:  0000000000000000(0000) GS:ffff889062800000(0000)
>>>>> knlGS:0000000000000000
>>>>> [    9.152036][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    9.152036][    T1] CR2: 0000000000000dc8 CR3: 0000001070212000 CR4:
>>>>> 00000000001406b0
>>>>> [    9.152036][    T1] Call Trace:
>>>>> [    9.152036][    T1]  ? mem_cgroup_iter+0x98/0x840
>>>>> [    9.152036][    T1]  ? unregister_shrinker+0x110/0x110
>>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.152036][    T1]  ? mem_cgroup_protected+0x39/0x260
>>>>> [    9.152036][    T1]  shrink_node+0x31e/0xa30
>>>>> [    9.152036][    T1]  ? shrink_node_memcg+0x1560/0x1560
>>>>> [    9.152036][    T1]  ? ktime_get+0x93/0x110
>>>>> [    9.152036][    T1]  do_try_to_free_pages+0x22f/0x820
>>>>> [    9.152036][    T1]  ? shrink_node+0xa30/0xa30
>>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.152036][    T1]  ? check_chain_key+0x1df/0x2e0
>>>>> [    9.152036][    T1]  try_to_free_pages+0x242/0x4d0
>>>>> [    9.152036][    T1]  ? do_try_to_free_pages+0x820/0x820
>>>>> [    9.152036][    T1]  __alloc_pages_nodemask+0x9ce/0x1bc0
>>>>> [    9.152036][    T1]  ? gfp_pfmemalloc_allowed+0xc0/0xc0
>>>>> [    9.152036][    T1]  ? unwind_dump+0x260/0x260
>>>>> [    9.152036][    T1]  ? kernel_text_address+0x33/0xc0
>>>>> [    9.152036][    T1]  ? arch_stack_walk+0x8f/0xf0
>>>>> [    9.152036][    T1]  ? ret_from_fork+0x22/0x40
>>>>> [    9.152036][    T1]  alloc_page_interleave+0x18/0x130
>>>>> [    9.152036][    T1]  alloc_pages_current+0xf6/0x110
>>>>> [    9.152036][    T1]  allocate_slab+0x600/0x11f0
>>>>> [    9.152036][    T1]  new_slab+0x46/0x70
>>>>> [    9.152036][    T1]  ___slab_alloc+0x5d4/0x9c0
>>>>> [    9.152036][    T1]  ? create_object+0x3a/0x3e0
>>>>> [    9.152036][    T1]  ? fs_reclaim_acquire.part.15+0x5/0x30
>>>>> [    9.152036][    T1]  ? ___might_sleep+0xab/0xc0
>>>>> [    9.152036][    T1]  ? create_object+0x3a/0x3e0
>>>>> [    9.152036][    T1]  __slab_alloc+0x12/0x20
>>>>> [    9.152036][    T1]  ? __slab_alloc+0x12/0x20
>>>>> [    9.152036][    T1]  kmem_cache_alloc+0x32a/0x400
>>>>> [    9.152036][    T1]  create_object+0x3a/0x3e0
>>>>> [    9.152036][    T1]  kmemleak_alloc+0x71/0xa0
>>>>> [    9.152036][    T1]  kmem_cache_alloc+0x272/0x400
>>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>>> [    9.152036][    T1]  ? do_raw_spin_unlock+0xa8/0x140
>>>>> [    9.152036][    T1]  acpi_ps_alloc_op+0x76/0x122
>>>>> [    9.152036][    T1]  acpi_ds_execute_arguments+0x2f/0x18d
>>>>> [    9.152036][    T1]  acpi_ds_get_package_arguments+0x7d/0x84
>>>>> [    9.152036][    T1]  acpi_ns_init_one_package+0x33/0x61
>>>>> [    9.152036][    T1]  acpi_ns_init_one_object+0xfc/0x189
>>>>> [    9.152036][    T1]  acpi_ns_walk_namespace+0x114/0x1f2
>>>>> [    9.152036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>>> [    9.152036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>>> [    9.152036][    T1]  acpi_walk_namespace+0x9e/0xcb
>>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.152036][    T1]  acpi_ns_initialize_objects+0x99/0xed
>>>>> [    9.152036][    T1]  ? acpi_ns_find_ini_methods+0xa2/0xa2
>>>>> [    9.152036][    T1]  ? acpi_tb_load_namespace+0x2dc/0x2eb
>>>>> [    9.152036][    T1]  acpi_load_tables+0x61/0x80
>>>>> [    9.152036][    T1]  acpi_init+0x10d/0x44b
>>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.152036][    T1]  ? bus_uevent_filter+0x16/0x30
>>>>> [    9.152036][    T1]  ? kobject_uevent_env+0x109/0x980
>>>>> [    9.152036][    T1]  ? kernfs_get+0x13/0x20
>>>>> [    9.152036][    T1]  ? kobject_uevent+0xb/0x10
>>>>> [    9.152036][    T1]  ? kset_register+0x31/0x50
>>>>> [    9.152036][    T1]  ? kset_create_and_add+0x9f/0xd0
>>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>>> [    9.152036][    T1]  do_one_initcall+0xfe/0x45a
>>>>> [    9.152036][    T1]  ? initcall_blacklisted+0x150/0x150
>>>>> [    9.152036][    T1]  ? rwsem_down_read_slowpath+0x930/0x930
>>>>> [    9.152036][    T1]  ? kasan_check_write+0x14/0x20
>>>>> [    9.152036][    T1]  ? up_write+0x6b/0x190
>>>>> [    9.152036][    T1]  kernel_init_freeable+0x614/0x6a7
>>>>> [    9.152036][    T1]  ? rest_init+0x188/0x188
>>>>> [    9.152036][    T1]  kernel_init+0x11/0x138
>>>>> [    9.152036][    T1]  ? rest_init+0x188/0x188
>>>>> [    9.152036][    T1]  ret_from_fork+0x22/0x40
>>>>> [    9.152036][    T1] Modules linked in:
>>>>> [    9.152036][    T1] CR2: 0000000000000dc8
>>>>> [    9.152036][    T1] ---[ end trace 568acce4eca01945 ]---
>>>>> [    9.152036][    T1] RIP: 0010:shrink_slab+0x111/0x440
>>>>> [    9.152036][    T1] Code: c7 20 8d 44 82 e8 7f 8b e8 ff 85 c0 0f 84 e2 02
>>>>> 00
>>>>> 00 4c 63 a5 4c ff ff ff 49 81 c4 b8 01 00 00 4b 8d 7c e6 08 e8 3f 07 0e 00
>>>>> <4f>
>>>>> 8b 64 e6 08 49 8d bc 24 20 03 00 00 e8 2d 07 0e 00 49 8b 84 24
>>>>> [    9.152036][    T1] RSP: 0018:ffff88905757f100 EFLAGS: 00010282
>>>>> [    9.152036][    T1] RAX: 0000000000000000 RBX: ffff88905757f1b0 RCX:
>>>>> ffffffff8112f288
>>>>> [    9.152036][    T1] RDX: 1ffffffff049c088 RSI: dffffc0000000000 RDI:
>>>>> ffffffff824e0440
>>>>> [    9.152036][    T1] RBP: ffff88905757f1d8 R08: fffffbfff049c089 R09:
>>>>> fffffbfff049c088
>>>>> [    9.152036][    T1] R10: fffffbfff049c088 R11: ffffffff824e0443 R12:
>>>>> 00000000000001b8
>>>>> [    9.152036][    T1] R13: 0000000000000000 R14: 0000000000000000 R15:
>>>>> ffff88905757f440
>>>>> [    9.152036][    T1] FS:  0000000000000000(0000) GS:ffff889062800000(0000)
>>>>> knlGS:00000000
>>>>>

