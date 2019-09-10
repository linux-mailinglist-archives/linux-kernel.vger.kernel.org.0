Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F86AE8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfIJKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:50:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:48776 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfIJKuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:50:50 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i7djC-0007sY-TJ; Tue, 10 Sep 2019 13:50:31 +0300
Subject: Re: [PATCH v2 0/2] mm/kasan: dump alloc/free stack for page allocator
To:     Vlastimil Babka <vbabka@suse.cz>, walter-zh.wu@mediatek.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20190909082412.24356-1-walter-zh.wu@mediatek.com>
 <d53d88df-d9a4-c126-32a8-4baeb0645a2c@suse.cz>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a7863965-90ab-5dae-65e7-8f68f4b4beb5@virtuozzo.com>
Date:   Tue, 10 Sep 2019 13:50:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d53d88df-d9a4-c126-32a8-4baeb0645a2c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/19 4:07 PM, Vlastimil Babka wrote:
> On 9/9/19 10:24 AM, walter-zh.wu@mediatek.com wrote:
>> From: Walter Wu <walter-zh.wu@mediatek.com>
>>
>> This patch is KASAN report adds the alloc/free stacks for page allocator
>> in order to help programmer to see memory corruption caused by page.
>>
>> By default, KASAN doesn't record alloc and free stack for page allocator.
>> It is difficult to fix up page use-after-free or dobule-free issue.
>>
>> Our patchsets will record the last stack of pages.
>> It is very helpful for solving the page use-after-free or double-free.
>>
>> KASAN report will show the last stack of page, it may be:
>> a) If page is in-use state, then it prints alloc stack.
>>     It is useful to fix up page out-of-bound issue.
> 
> I still disagree with duplicating most of page_owner functionality for the sake of using a single stack handle for both alloc and free (while page_owner + debug_pagealloc with patches in mmotm uses two handles). It reduces the amount of potentially important debugging information, and I really doubt the u32-per-page savings are significant, given the rest of KASAN overhead.
> 
>> BUG: KASAN: slab-out-of-bounds in kmalloc_pagealloc_oob_right+0x88/0x90
>> Write of size 1 at addr ffffffc0d64ea00a by task cat/115
>> ...
>> Allocation stack of page:
>>   set_page_stack.constprop.1+0x30/0xc8
>>   kasan_alloc_pages+0x18/0x38
>>   prep_new_page+0x5c/0x150
>>   get_page_from_freelist+0xb8c/0x17c8
>>   __alloc_pages_nodemask+0x1a0/0x11b0
>>   kmalloc_order+0x28/0x58
>>   kmalloc_order_trace+0x28/0xe0
>>   kmalloc_pagealloc_oob_right+0x2c/0x68
>>
>> b) If page is freed state, then it prints free stack.
>>     It is useful to fix up page use-after-free or double-free issue.
>>
>> BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x70/0x80
>> Write of size 1 at addr ffffffc0d651c000 by task cat/115
>> ...
>> Free stack of page:
>>   kasan_free_pages+0x68/0x70
>>   __free_pages_ok+0x3c0/0x1328
>>   __free_pages+0x50/0x78
>>   kfree+0x1c4/0x250
>>   kmalloc_pagealloc_uaf+0x38/0x80
>>
>> This has been discussed, please refer below link.
>> https://bugzilla.kernel.org/show_bug.cgi?id=203967
> 
> That's not a discussion, but a single comment from Dmitry, which btw contains "provide alloc *and* free stacks for it" ("it" refers to page, emphasis mine). It would be nice if he or other KASAN guys could clarify.
> 

For slab objects we memorize both alloc and free stacks. You'll never know in advance what information will be usefull
to fix an issue, so it usually better to provide more information. I don't think we should do anything different for pages.

Given that we already have the page_owner responsible for providing alloc/free stacks for pages, all that we should in KASAN do is to
enable the feature by default. Free stack saving should be decoupled from debug_pagealloc into separate option so that it can be enabled 
by KASAN and/or debug_pagealloc.

 


