Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC46A048
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfGPBgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 21:36:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34862 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfGPBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 21:36:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so13291391qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wis9S/SAgUGN3nyp9P4Jw4JKuiL8YMgvhNcJJAA4chE=;
        b=mVXOIXzW82jan5uNg3ia1eiQg9fTtnEVmYz0o64yWbFhiB5+Q4xHK513KfHuqvDryr
         vwODsDrKw1vB2bAGOPSt63BMB9A3aAjYEIVsETP4m+QhOLsdQ4sMarQM0ZFU9VYQgncQ
         q7DUavCWs7z5SGOXdekNLxQaXarzqucq7yTfuaMT2pRQgQyj7bBkzBKy+lqJlzdNZJWV
         NA0CEMtca26tkl5HNFr3pnjSlzn53GF7AS23tUr0+KU7Lk7irtw4A8C8LNlo77Lcy6/g
         qpQfsCCymcLv8IdoZJqyKwsaYm28z+RG22IevyzPwb14Sk2YF21RO/Uaqv4/Qm8p5vrl
         /53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Wis9S/SAgUGN3nyp9P4Jw4JKuiL8YMgvhNcJJAA4chE=;
        b=Z/klIfHSXMJrt+/6eIZY7Ixi4qAUO8v/ustDZfSDQ+/ESyZG+IaPWIhVTOdo25oiUX
         KxjNaRMxQmqD0sfJRAyiKRZNwhoqudnf/sZnRNOsEOQfxzf3XMV9KKKbbeWyW+DiW0i6
         KY5loVHwm/xuZEXd9NMJ8stAdXnrYAv46ysnomw5qtw4uLYNktsvaoO3mGDfCF24U6CE
         z0wNuUG2V+lwrS6j6cXJPA6CsOt/DAQC8yMXm1UWmJiz/L9i1JOItHfSzYrPl/EtwmdK
         PX7qpuCTkLlOUoykGlT6QHSNJGbzP99wHsTNbQxTQKGc1BfVo8JtardhyovXt5fBbGcI
         uhGQ==
X-Gm-Message-State: APjAAAXv04Jz/prjX3i7O8juG9noUlsVIYMIBjTrf9ITx+TuCIQjN1VX
        QRb9zFuHJFLfcG440rceoi+4Ce0CLyWPDw==
X-Google-Smtp-Source: APXvYqymBQsu+ONJcTHsMQpKsIrukbUyolmdjIiePFlUGqsZPh/JGNr4rZru4Ej5g9tG3n04i0Qb+Q==
X-Received: by 2002:a05:620a:1034:: with SMTP id a20mr19467788qkk.165.1563240978932;
        Mon, 15 Jul 2019 18:36:18 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h18sm7759267qkk.93.2019.07.15.18.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 18:36:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: list corruption in deferred_split_scan()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <5c853e6e-6367-d83c-bb97-97cd67320126@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 21:36:17 -0400
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A64D551-FF5B-4068-853E-9E31AF323517@lca.pw>
References: <1562795006.8510.19.camel@lca.pw>
 <cd6e10bc-cb79-65c5-ff2b-4c244ae5eb1c@linux.alibaba.com>
 <1562879229.8510.24.camel@lca.pw>
 <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
 <1563225798.4610.5.camel@lca.pw>
 <5c853e6e-6367-d83c-bb97-97cd67320126@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 15, 2019, at 8:22 PM, Yang Shi <yang.shi@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> On 7/15/19 2:23 PM, Qian Cai wrote:
>> On Fri, 2019-07-12 at 12:12 -0700, Yang Shi wrote:
>>>> Another possible lead is that without reverting the those commits =
below,
>>>> kdump
>>>> kernel would always also crash in shrink_slab_memcg() at this line,
>>>>=20
>>>> map =3D =
rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map, true);
>>> This looks a little bit weird. It seems nodeinfo[nid] is NULL? I =
didn't
>>> think of where nodeinfo was freed but memcg was still online. Maybe =
a
>>> check is needed:
>> Actually, "memcg" is NULL.
>=20
> It sounds weird. shrink_slab() is called in mem_cgroup_iter which does =
pin the memcg. So, the memcg should not go away.

Well, the commit =E2=80=9Cmm: shrinker: make shrinker not depend on =
memcg kmem=E2=80=9D changed this line in shrink_slab_memcg(),

-	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+	if (!mem_cgroup_online(memcg))
		return 0;

Since the kdump kernel has the parameter =E2=80=9Ccgroup_disable=3Dmemory=E2=
=80=9D, shrink_slab_memcg() will no longer be able to handle NULL memcg =
from mem_cgroup_iter() as,

if (mem_cgroup_disabled())	=09
	return NULL;

>=20
>>=20
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index a0301ed..bacda49 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -602,6 +602,9 @@ static unsigned long shrink_slab_memcg(gfp_t
>>> gfp_mask, int nid,
>>>          if (!mem_cgroup_online(memcg))
>>>                  return 0;
>>>=20
>>> +       if (!memcg->nodeinfo[nid])
>>> +               return 0;
>>> +
>>>          if (!down_read_trylock(&shrinker_rwsem))
>>>                  return 0;
>>>=20
>>>> [    9.072036][    T1] BUG: KASAN: null-ptr-deref in =
shrink_slab+0x111/0x440
>>>> [    9.072036][    T1] Read of size 8 at addr 0000000000000dc8 by =
task
>>>> swapper/0/1
>>>> [    9.072036][    T1]
>>>> [    9.072036][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.2.0-next-
>>>> 20190711+ #10
>>>> [    9.072036][    T1] Hardware name: HPE ProLiant DL385 =
Gen10/ProLiant
>>>> DL385
>>>> Gen10, BIOS A40 01/25/2019
>>>> [    9.072036][    T1] Call Trace:
>>>> [    9.072036][    T1]  dump_stack+0x62/0x9a
>>>> [    9.072036][    T1]  __kasan_report.cold.4+0xb0/0xb4
>>>> [    9.072036][    T1]  ? unwind_get_return_address+0x40/0x50
>>>> [    9.072036][    T1]  ? shrink_slab+0x111/0x440
>>>> [    9.072036][    T1]  kasan_report+0xc/0xe
>>>> [    9.072036][    T1]  __asan_load8+0x71/0xa0
>>>> [    9.072036][    T1]  shrink_slab+0x111/0x440
>>>> [    9.072036][    T1]  ? mem_cgroup_iter+0x98/0x840
>>>> [    9.072036][    T1]  ? unregister_shrinker+0x110/0x110
>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.072036][    T1]  ? mem_cgroup_protected+0x39/0x260
>>>> [    9.072036][    T1]  shrink_node+0x31e/0xa30
>>>> [    9.072036][    T1]  ? shrink_node_memcg+0x1560/0x1560
>>>> [    9.072036][    T1]  ? ktime_get+0x93/0x110
>>>> [    9.072036][    T1]  do_try_to_free_pages+0x22f/0x820
>>>> [    9.072036][    T1]  ? shrink_node+0xa30/0xa30
>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.072036][    T1]  ? check_chain_key+0x1df/0x2e0
>>>> [    9.072036][    T1]  try_to_free_pages+0x242/0x4d0
>>>> [    9.072036][    T1]  ? do_try_to_free_pages+0x820/0x820
>>>> [    9.072036][    T1]  __alloc_pages_nodemask+0x9ce/0x1bc0
>>>> [    9.072036][    T1]  ? gfp_pfmemalloc_allowed+0xc0/0xc0
>>>> [    9.072036][    T1]  ? unwind_dump+0x260/0x260
>>>> [    9.072036][    T1]  ? kernel_text_address+0x33/0xc0
>>>> [    9.072036][    T1]  ? arch_stack_walk+0x8f/0xf0
>>>> [    9.072036][    T1]  ? ret_from_fork+0x22/0x40
>>>> [    9.072036][    T1]  alloc_page_interleave+0x18/0x130
>>>> [    9.072036][    T1]  alloc_pages_current+0xf6/0x110
>>>> [    9.072036][    T1]  allocate_slab+0x600/0x11f0
>>>> [    9.072036][    T1]  new_slab+0x46/0x70
>>>> [    9.072036][    T1]  ___slab_alloc+0x5d4/0x9c0
>>>> [    9.072036][    T1]  ? create_object+0x3a/0x3e0
>>>> [    9.072036][    T1]  ? fs_reclaim_acquire.part.15+0x5/0x30
>>>> [    9.072036][    T1]  ? ___might_sleep+0xab/0xc0
>>>> [    9.072036][    T1]  ? create_object+0x3a/0x3e0
>>>> [    9.072036][    T1]  __slab_alloc+0x12/0x20
>>>> [    9.072036][    T1]  ? __slab_alloc+0x12/0x20
>>>> [    9.072036][    T1]  kmem_cache_alloc+0x32a/0x400
>>>> [    9.072036][    T1]  create_object+0x3a/0x3e0
>>>> [    9.072036][    T1]  kmemleak_alloc+0x71/0xa0
>>>> [    9.072036][    T1]  kmem_cache_alloc+0x272/0x400
>>>> [    9.072036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.072036][    T1]  ? do_raw_spin_unlock+0xa8/0x140
>>>> [    9.072036][    T1]  acpi_ps_alloc_op+0x76/0x122
>>>> [    9.072036][    T1]  acpi_ds_execute_arguments+0x2f/0x18d
>>>> [    9.072036][    T1]  acpi_ds_get_package_arguments+0x7d/0x84
>>>> [    9.072036][    T1]  acpi_ns_init_one_package+0x33/0x61
>>>> [    9.072036][    T1]  acpi_ns_init_one_object+0xfc/0x189
>>>> [    9.072036][    T1]  acpi_ns_walk_namespace+0x114/0x1f2
>>>> [    9.072036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>> [    9.072036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>> [    9.072036][    T1]  acpi_walk_namespace+0x9e/0xcb
>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.072036][    T1]  acpi_ns_initialize_objects+0x99/0xed
>>>> [    9.072036][    T1]  ? acpi_ns_find_ini_methods+0xa2/0xa2
>>>> [    9.072036][    T1]  ? acpi_tb_load_namespace+0x2dc/0x2eb
>>>> [    9.072036][    T1]  acpi_load_tables+0x61/0x80
>>>> [    9.072036][    T1]  acpi_init+0x10d/0x44b
>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.072036][    T1]  ? bus_uevent_filter+0x16/0x30
>>>> [    9.072036][    T1]  ? kobject_uevent_env+0x109/0x980
>>>> [    9.072036][    T1]  ? kernfs_get+0x13/0x20
>>>> [    9.072036][    T1]  ? kobject_uevent+0xb/0x10
>>>> [    9.072036][    T1]  ? kset_register+0x31/0x50
>>>> [    9.072036][    T1]  ? kset_create_and_add+0x9f/0xd0
>>>> [    9.072036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.072036][    T1]  do_one_initcall+0xfe/0x45a
>>>> [    9.072036][    T1]  ? initcall_blacklisted+0x150/0x150
>>>> [    9.072036][    T1]  ? rwsem_down_read_slowpath+0x930/0x930
>>>> [    9.072036][    T1]  ? kasan_check_write+0x14/0x20
>>>> [    9.072036][    T1]  ? up_write+0x6b/0x190
>>>> [    9.072036][    T1]  kernel_init_freeable+0x614/0x6a7
>>>> [    9.072036][    T1]  ? rest_init+0x188/0x188
>>>> [    9.072036][    T1]  kernel_init+0x11/0x138
>>>> [    9.072036][    T1]  ? rest_init+0x188/0x188
>>>> [    9.072036][    T1]  ret_from_fork+0x22/0x40
>>>> [    9.072036][    T1]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> [    9.072036][    T1] Disabling lock debugging due to kernel taint
>>>> [    9.145712][    T1] BUG: kernel NULL pointer dereference, =
address:
>>>> 0000000000000dc8
>>>> [    9.152036][    T1] #PF: supervisor read access in kernel mode
>>>> [    9.152036][    T1] #PF: error_code(0x0000) - not-present page
>>>> [    9.152036][    T1] PGD 0 P4D 0
>>>> [    9.152036][    T1] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN =
NOPTI
>>>> [    9.152036][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted:
>>>> G    B             5.2.0-next-20190711+ #10
>>>> [    9.152036][    T1] Hardware name: HPE ProLiant DL385 =
Gen10/ProLiant
>>>> DL385
>>>> Gen10, BIOS A40 01/25/2019
>>>> [    9.152036][    T1] RIP: 0010:shrink_slab+0x111/0x440
>>>> [    9.152036][    T1] Code: c7 20 8d 44 82 e8 7f 8b e8 ff 85 c0 0f =
84 e2 02
>>>> 00
>>>> 00 4c 63 a5 4c ff ff ff 49 81 c4 b8 01 00 00 4b 8d 7c e6 08 e8 3f =
07 0e 00
>>>> <4f>
>>>> 8b 64 e6 08 49 8d bc 24 20 03 00 00 e8 2d 07 0e 00 49 8b 84 24
>>>> [    9.152036][    T1] RSP: 0018:ffff88905757f100 EFLAGS: 00010282
>>>> [    9.152036][    T1] RAX: 0000000000000000 RBX: ffff88905757f1b0 =
RCX:
>>>> ffffffff8112f288
>>>> [    9.152036][    T1] RDX: 1ffffffff049c088 RSI: dffffc0000000000 =
RDI:
>>>> ffffffff824e0440
>>>> [    9.152036][    T1] RBP: ffff88905757f1d8 R08: fffffbfff049c089 =
R09:
>>>> fffffbfff049c088
>>>> [    9.152036][    T1] R10: fffffbfff049c088 R11: ffffffff824e0443 =
R12:
>>>> 00000000000001b8
>>>> [    9.152036][    T1] R13: 0000000000000000 R14: 0000000000000000 =
R15:
>>>> ffff88905757f440
>>>> [    9.152036][    T1] FS:  0000000000000000(0000) =
GS:ffff889062800000(0000)
>>>> knlGS:0000000000000000
>>>> [    9.152036][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>>>> [    9.152036][    T1] CR2: 0000000000000dc8 CR3: 0000001070212000 =
CR4:
>>>> 00000000001406b0
>>>> [    9.152036][    T1] Call Trace:
>>>> [    9.152036][    T1]  ? mem_cgroup_iter+0x98/0x840
>>>> [    9.152036][    T1]  ? unregister_shrinker+0x110/0x110
>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.152036][    T1]  ? mem_cgroup_protected+0x39/0x260
>>>> [    9.152036][    T1]  shrink_node+0x31e/0xa30
>>>> [    9.152036][    T1]  ? shrink_node_memcg+0x1560/0x1560
>>>> [    9.152036][    T1]  ? ktime_get+0x93/0x110
>>>> [    9.152036][    T1]  do_try_to_free_pages+0x22f/0x820
>>>> [    9.152036][    T1]  ? shrink_node+0xa30/0xa30
>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.152036][    T1]  ? check_chain_key+0x1df/0x2e0
>>>> [    9.152036][    T1]  try_to_free_pages+0x242/0x4d0
>>>> [    9.152036][    T1]  ? do_try_to_free_pages+0x820/0x820
>>>> [    9.152036][    T1]  __alloc_pages_nodemask+0x9ce/0x1bc0
>>>> [    9.152036][    T1]  ? gfp_pfmemalloc_allowed+0xc0/0xc0
>>>> [    9.152036][    T1]  ? unwind_dump+0x260/0x260
>>>> [    9.152036][    T1]  ? kernel_text_address+0x33/0xc0
>>>> [    9.152036][    T1]  ? arch_stack_walk+0x8f/0xf0
>>>> [    9.152036][    T1]  ? ret_from_fork+0x22/0x40
>>>> [    9.152036][    T1]  alloc_page_interleave+0x18/0x130
>>>> [    9.152036][    T1]  alloc_pages_current+0xf6/0x110
>>>> [    9.152036][    T1]  allocate_slab+0x600/0x11f0
>>>> [    9.152036][    T1]  new_slab+0x46/0x70
>>>> [    9.152036][    T1]  ___slab_alloc+0x5d4/0x9c0
>>>> [    9.152036][    T1]  ? create_object+0x3a/0x3e0
>>>> [    9.152036][    T1]  ? fs_reclaim_acquire.part.15+0x5/0x30
>>>> [    9.152036][    T1]  ? ___might_sleep+0xab/0xc0
>>>> [    9.152036][    T1]  ? create_object+0x3a/0x3e0
>>>> [    9.152036][    T1]  __slab_alloc+0x12/0x20
>>>> [    9.152036][    T1]  ? __slab_alloc+0x12/0x20
>>>> [    9.152036][    T1]  kmem_cache_alloc+0x32a/0x400
>>>> [    9.152036][    T1]  create_object+0x3a/0x3e0
>>>> [    9.152036][    T1]  kmemleak_alloc+0x71/0xa0
>>>> [    9.152036][    T1]  kmem_cache_alloc+0x272/0x400
>>>> [    9.152036][    T1]  ? kasan_check_read+0x11/0x20
>>>> [    9.152036][    T1]  ? do_raw_spin_unlock+0xa8/0x140
>>>> [    9.152036][    T1]  acpi_ps_alloc_op+0x76/0x122
>>>> [    9.152036][    T1]  acpi_ds_execute_arguments+0x2f/0x18d
>>>> [    9.152036][    T1]  acpi_ds_get_package_arguments+0x7d/0x84
>>>> [    9.152036][    T1]  acpi_ns_init_one_package+0x33/0x61
>>>> [    9.152036][    T1]  acpi_ns_init_one_object+0xfc/0x189
>>>> [    9.152036][    T1]  acpi_ns_walk_namespace+0x114/0x1f2
>>>> [    9.152036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>> [    9.152036][    T1]  ? acpi_ns_init_one_package+0x61/0x61
>>>> [    9.152036][    T1]  acpi_walk_namespace+0x9e/0xcb
>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.152036][    T1]  acpi_ns_initialize_objects+0x99/0xed
>>>> [    9.152036][    T1]  ? acpi_ns_find_ini_methods+0xa2/0xa2
>>>> [    9.152036][    T1]  ? acpi_tb_load_namespace+0x2dc/0x2eb
>>>> [    9.152036][    T1]  acpi_load_tables+0x61/0x80
>>>> [    9.152036][    T1]  acpi_init+0x10d/0x44b
>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.152036][    T1]  ? bus_uevent_filter+0x16/0x30
>>>> [    9.152036][    T1]  ? kobject_uevent_env+0x109/0x980
>>>> [    9.152036][    T1]  ? kernfs_get+0x13/0x20
>>>> [    9.152036][    T1]  ? kobject_uevent+0xb/0x10
>>>> [    9.152036][    T1]  ? kset_register+0x31/0x50
>>>> [    9.152036][    T1]  ? kset_create_and_add+0x9f/0xd0
>>>> [    9.152036][    T1]  ? acpi_sleep_proc_init+0x36/0x36
>>>> [    9.152036][    T1]  do_one_initcall+0xfe/0x45a
>>>> [    9.152036][    T1]  ? initcall_blacklisted+0x150/0x150
>>>> [    9.152036][    T1]  ? rwsem_down_read_slowpath+0x930/0x930
>>>> [    9.152036][    T1]  ? kasan_check_write+0x14/0x20
>>>> [    9.152036][    T1]  ? up_write+0x6b/0x190
>>>> [    9.152036][    T1]  kernel_init_freeable+0x614/0x6a7
>>>> [    9.152036][    T1]  ? rest_init+0x188/0x188
>>>> [    9.152036][    T1]  kernel_init+0x11/0x138
>>>> [    9.152036][    T1]  ? rest_init+0x188/0x188
>>>> [    9.152036][    T1]  ret_from_fork+0x22/0x40
>>>> [    9.152036][    T1] Modules linked in:
>>>> [    9.152036][    T1] CR2: 0000000000000dc8
>>>> [    9.152036][    T1] ---[ end trace 568acce4eca01945 ]---
>>>> [    9.152036][    T1] RIP: 0010:shrink_slab+0x111/0x440
>>>> [    9.152036][    T1] Code: c7 20 8d 44 82 e8 7f 8b e8 ff 85 c0 0f =
84 e2 02
>>>> 00
>>>> 00 4c 63 a5 4c ff ff ff 49 81 c4 b8 01 00 00 4b 8d 7c e6 08 e8 3f =
07 0e 00
>>>> <4f>
>>>> 8b 64 e6 08 49 8d bc 24 20 03 00 00 e8 2d 07 0e 00 49 8b 84 24
>>>> [    9.152036][    T1] RSP: 0018:ffff88905757f100 EFLAGS: 00010282
>>>> [    9.152036][    T1] RAX: 0000000000000000 RBX: ffff88905757f1b0 =
RCX:
>>>> ffffffff8112f288
>>>> [    9.152036][    T1] RDX: 1ffffffff049c088 RSI: dffffc0000000000 =
RDI:
>>>> ffffffff824e0440
>>>> [    9.152036][    T1] RBP: ffff88905757f1d8 R08: fffffbfff049c089 =
R09:
>>>> fffffbfff049c088
>>>> [    9.152036][    T1] R10: fffffbfff049c088 R11: ffffffff824e0443 =
R12:
>>>> 00000000000001b8
>>>> [    9.152036][    T1] R13: 0000000000000000 R14: 0000000000000000 =
R15:
>>>> ffff88905757f440
>>>> [    9.152036][    T1] FS:  0000000000000000(0000) =
GS:ffff889062800000(0000)
>>>> knlGS:00000000
>>>>=20
>=20

