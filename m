Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF557C3D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfGaNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59381 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfGaNm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84E8C811DE;
        Wed, 31 Jul 2019 13:42:56 +0000 (UTC)
Received: from [10.36.117.240] (ovpn-117-240.ams2.redhat.com [10.36.117.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9596E19C5B;
        Wed, 31 Jul 2019 13:42:54 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
 <20190731132534.GQ9330@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
Date:   Wed, 31 Jul 2019 15:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731132534.GQ9330@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 31 Jul 2019 13:42:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.19 15:25, Michal Hocko wrote:
> On Wed 31-07-19 15:12:12, David Hildenbrand wrote:
>> On 31.07.19 14:43, Michal Hocko wrote:
>>> On Wed 31-07-19 14:22:13, David Hildenbrand wrote:
>>>> Each memory block spans the same amount of sections/pages/bytes. The size
>>>> is determined before the first memory block is created. No need to store
>>>> what we can easily calculate - and the calculations even look simpler now.
>>>
>>> While this cleanup helps a bit, I am not sure this is really worth
>>> bothering. I guess we can agree when I say that the memblock interface
>>> is suboptimal (to put it mildly).  Shouldn't we strive for making it
>>> a real hotplug API in the future? What do I mean by that? Why should
>>> be any memblock fixed in size? Shouldn't we have use hotplugable units
>>> instead (aka pfn range that userspace can work with sensibly)? Do we
>>> know of any existing userspace that would depend on the current single
>>> section res. 2GB sized memblocks?
>>
>> Short story: It is already ABI (e.g.,
>> /sys/devices/system/memory/block_size_bytes) - around since 2005 (!) -
>> since we had memory block devices.
>>
>> I suspect that it is mainly manually used. But I might be wrong.
> 
> Any pointer to the real userspace depending on it? Most usecases I am
> aware of rely on udev events and either onlining or offlining the memory
> in the handler.

Yes, that's also what I know - onlining and triggering kexec().

On s390x, admins online sub-increments to selectively add memory to a VM
- but we could still emulate that by adding memory for that use case in
the kernel in the current granularity. See

https://books.google.de/books?id=afq4CgAAQBAJ&pg=PA117&lpg=PA117&dq=/sys/devices/system/memory/block_size_bytes&source=bl&ots=iYk_vW5O4G&sig=ACfU3U0s-O-SOVaQO-7HpKO5Hj866w9Pxw&hl=de&sa=X&ved=2ahUKEwjOjPqIot_jAhVPfZoKHcxpAqcQ6AEwB3oECAgQAQ#v=onepage&q=%2Fsys%2Fdevices%2Fsystem%2Fmemory%2Fblock_size_bytes&f=false

> 
> I know we have documented this as an ABI and it is really _sad_ that
> this ABI didn't get through normal scrutiny any user visible interface
> should go through but these are sins of the past...

A quick google search indicates that

Kata containers queries the block size:
https://github.com/kata-containers/runtime/issues/796

Powerpc userspace queries it:
https://groups.google.com/forum/#!msg/powerpc-utils-devel/dKjZCqpTxus/AwkstV2ABwAJ

I can imagine that ppc dynamic memory onlines only pieces of added
memory - DIMMs AFAIK (haven't looked at the details).

There might be more users.

> 
>> Long story:
>>
>> How would you want to number memory blocks? At least no longer by phys
>> index. For now, memory blocks are ordered and numbered by their block id.
> 
> memory_${mem_section_nr_of_start_pfn}
> 

Fair enough, although this could break some scripts where people
manually offline/online specific blocks. (but who knows what
people/scripts do :( )

>> Admins might want to online parts of a DIMM MOVABLE/NORMAL, to more
>> reliably use huge pages but still have enough space for kernel memory
>> (e.g., page tables). They might like that a DIMM is actually a set of
>> memory blocks instead of one big chunk.
> 
> They might. Do they though? There are many theoretical usecases but
> let's face it, there is a cost given to the current state. E.g. the
> number of memblock directories is already quite large on machines with a
> lot of memory even though they use large blocks. That has negative
> implications already (e.g. the number of events you get, any iteration
> on the /sys etc.). Also 2G memblocks are quite arbitrary and they
> already limit the above usecase some, right?

I mean there are other theoretical issues: Onlining a very big DIMM in
one shot might trigger OOM, while slowly adding/onlining would currently
works. Who knows if that is relevant in practice.

Also, it would break the current use case of memtrace, which removes
memory in a granularity that wasn't added. But luckily, memtrace is an
exception :)

> 
>> IOW: You can consider it a restriction to add e.g., DIMMs only in one
>> bigger chunks.
>>
>>>
>>> All that being said, I do not oppose to the patch but can we start
>>> thinking about the underlying memblock limitations rather than micro
>>> cleanups?
>>
>> I am pro cleaning up what we have right now, not expect it to eventually
>> change some-when in the future. (btw, I highly doubt it will change)
> 
> I do agree, but having the memblock fixed size doesn't really go along
> with variable memblock size if we ever go there. But as I've said I am
> not really against the patch.

Fair enough, for now I am not convinced that we will actually see
variable memory blocks in the near future.

Thanks for the discussion (I was thinking about the same concept a while
back when trying to find out if there could be an easy way to identify
which memory blocks belong to a single DIMM you want to eventually
unplug and therefore online it all to the MOVABLE zone).

-- 

Thanks,

David / dhildenb
