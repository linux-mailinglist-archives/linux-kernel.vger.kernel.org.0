Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCA13DFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgAPQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 11:18:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgAPQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=FAorhE+rg3xPw/s0lIe1s2HKS7F+2w463zj+sOO9P8E=;
        b=i2xepV2FoKSPzUUaKmPbyZV8a6pMk7gXxQH0CfvMDy/Qo4q86U291EGFGntFHYsPlpJp56
        M8oT5WCxuCurQszEK/lcjGQx4FHbtSh5sThI1HWvbsfvYiNc3n4+UqvLGcKtGFuC2tslCG
        nf6vjCoSx4hUsAjYwYj/iw/kI2BZjeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Y7lS2vynNSqZQhctCqJ-ZQ-1; Thu, 16 Jan 2020 11:17:59 -0500
X-MC-Unique: Y7lS2vynNSqZQhctCqJ-ZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A9A8017CC;
        Thu, 16 Jan 2020 16:17:57 +0000 (UTC)
Received: from [10.36.116.232] (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B72DC858B4;
        Thu, 16 Jan 2020 16:17:55 +0000 (UTC)
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
From:   David Hildenbrand <david@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Donald Dutile <ddutile@redhat.com>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
 <20200116152214.GX19428@dhcp22.suse.cz>
 <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <fe92b4f0-0cd7-c705-1ed9-239175689051@redhat.com>
Date:   Thu, 16 Jan 2020 17:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.20 16:28, David Hildenbrand wrote:
> On 16.01.20 16:22, Michal Hocko wrote:
>> On Wed 15-01-20 20:09:48, David Hildenbrand wrote:
>>> On 09.01.20 22:25, Scott Cheloha wrote:
>>>> Searching for a particular memory block by id is an O(n) operation
>>>> because each memory block's underlying device is kept in an unsorted
>>>> linked list on the subsystem bus.
>>>>
>>>> We can cut the lookup cost to O(log n) if we cache the memory blocks in
>>>> a radix tree.  With a radix tree cache in place both memory subsystem
>>>> initialization and memory hotplug run palpably faster on systems with a
>>>> large number of memory blocks.
>>>>
>>>> Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> Soooo,
>>>
>>> I just learned that radix trees are nowadays only a wrapper for xarray
>>> (for quite a while already!), and that the xarray interface shall be
>>> used in new code.
>>
>> Good point. I somehow didn't realize this would add more work for a
>> later code refactoring. The mapping should be pretty straightforward.
> 
> Yes it is. @Scott, care to send a fixup that does the mapping?

Never having used an xarray, I gave it a quick shot. The following
should do the trick:


diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c6d288fad493..c75dec35de43 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -19,7 +19,7 @@
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
-#include <linux/radix-tree.h>
+#include <linux/xarray.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 
@@ -58,11 +58,11 @@ static struct bus_type memory_subsys = {
 };
 
 /*
- * Memory blocks are cached in a local radix tree to avoid
+ * Memory blocks are cached in a local xarray to avoid
  * a costly linear search for the corresponding device on
  * the subsystem bus.
  */
-static RADIX_TREE(memory_blocks, GFP_KERNEL);
+static DEFINE_XARRAY(memory_blocks);
 
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
@@ -566,7 +566,7 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
        struct memory_block *mem;
 
-       mem = radix_tree_lookup(&memory_blocks, block_id);
+       mem = xa_load(&memory_blocks, block_id);
        if (mem)
                get_device(&mem->dev);
        return mem;
@@ -621,7 +621,8 @@ int register_memory(struct memory_block *memory)
                put_device(&memory->dev);
                return ret;
        }
-       ret = radix_tree_insert(&memory_blocks, memory->dev.id, memory);
+       ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
+                             GFP_KERNEL));
        if (ret) {
                put_device(&memory->dev);
                device_unregister(&memory->dev);
@@ -683,7 +684,7 @@ static void unregister_memory(struct memory_block *memory)
        if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
                return;
 
-       WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) == NULL);
+       WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
 
        /* drop the ref. we got via find_memory_block() */
        put_device(&memory->dev);


-- 
Thanks,

David / dhildenb

