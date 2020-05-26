Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16D719A8D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbgDAJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 05:48:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgDAJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585734504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sKOg3cVaEaKdsaC5nuhu/PwPgLHCkghU/5N6r8sWHIM=;
        b=Ds04/oc7Wek/GBvse/6toi/C60mO7QFkotvo1vOIblDekpaTG21VRHoXCDf8icGBjgYAZN
        a5gW66FaZt3hJaVDpvUFka+SI+6G4NT7SKm9xI67QCKQPdTaq7VjbZUggUNmzco/IGu6rb
        qnhg9tYdRwbKvtFhzMYGDxCUw7Cgot4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-aYOZXPjxP6q1-GDEH_wrxw-1; Wed, 01 Apr 2020 05:48:20 -0400
X-MC-Unique: aYOZXPjxP6q1-GDEH_wrxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82ECB92AE1;
        Wed,  1 Apr 2020 09:48:18 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFF9ADA0E0;
        Wed,  1 Apr 2020 09:48:09 +0000 (UTC)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
To:     Nadav Amit <namit@vmware.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Hui Zhu <teawater@gmail.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <BABD09DC-217E-4F00-9C05-74ABB4B1E13D@vmware.com>
From:   David Hildenbrand <david@redhat.com>
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
Message-ID: <5e0e0659-5f70-2162-96be-5fcd0d3f46ad@redhat.com>
Date:   Wed, 1 Apr 2020 11:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BABD09DC-217E-4F00-9C05-74ABB4B1E13D@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.20 18:37, Nadav Amit wrote:
>> On Mar 31, 2020, at 7:09 AM, David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 31.03.20 16:07, Michael S. Tsirkin wrote:
>>> On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
>>>> On 31.03.20 15:37, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
>>>>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote=
:
>>>>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wro=
te:
>>>>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat=
.com>:
>>>>>>>>>>>
>>>>>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hild=
enbrand wrote:
>>>>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand=
 wrote:
>>>>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the =
fastest
>>>>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't b=
e able to make
>>>>>>>>>>>>>> use of THP where it previously was able to. I can imagine =
this implies a
>>>>>>>>>>>>>> performance degradation for some workloads. This needs a p=
roper
>>>>>>>>>>>>>> performance evaluation.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>>>>>
>>>>>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new AP=
I.
>>>>>>>>>>>>> Along the lines of
>>>>>>>>>>>>>
>>>>>>>>>>>>>   struct page *alloc_page_range(gfp_t gfp, unsigned int min=
_order,
>>>>>>>>>>>>>                   unsigned int max_order, unsigned int *ord=
er)
>>>>>>>>>>>>>
>>>>>>>>>>>>> the idea would then be to return at a number of pages in th=
e given
>>>>>>>>>>>>> range.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>>>>>
>>>>>>>>>>>> You can just start with the highest order and decrement the =
order until
>>>>>>>>>>>> your allocation succeeds using alloc_pages(), which would be=
 enough for
>>>>>>>>>>>> a first version. At least I don't see the immediate need for=
 a new
>>>>>>>>>>>> kernel API.
>>>>>>>>>>>
>>>>>>>>>>> OK I remember now.  The problem is with reclaim. Unless recla=
im is
>>>>>>>>>>> completely disabled, any of these calls can sleep. After it w=
akes up,
>>>>>>>>>>> we would like to get the larger order that has become availab=
le
>>>>>>>>>>> meanwhile.
>>>>>>>>>>
>>>>>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
>>>>>>>>>> So I think we should do a trivial implementation first and the=
n see what we gain from a new allocator API. Then we might also be able t=
o justify it using real numbers.
>>>>>>>>>
>>>>>>>>> Well how do you propose implement the necessary semantics?
>>>>>>>>> I think we are both agreed that alloc_page_range is more or
>>>>>>>>> less what's necessary anyway - so how would you approximate it
>>>>>>>>> on top of existing APIs?
>>>>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/=
balloon_compaction.h
>>>>>
>>>>> .....
>>>>>
>>>>>
>>>>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>>>>> index 26de020aae7b..067810b32813 100644
>>>>>>>> --- a/mm/balloon_compaction.c
>>>>>>>> +++ b/mm/balloon_compaction.c
>>>>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct ba=
lloon_dev_info *b_dev_info,
>>>>>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>>>>>
>>>>>>>> /*
>>>>>>>> - * balloon_page_alloc - allocates a new page for insertion into=
 the balloon
>>>>>>>> - *			page list.
>>>>>>>> + * balloon_pages_alloc - allocates a new page (of at most the g=
iven order)
>>>>>>>> + * 			 for insertion into the balloon page list.
>>>>>>>>  *
>>>>>>>>  * Driver must call this function to properly allocate a new bal=
loon page.
>>>>>>>>  * Driver must call balloon_page_enqueue before definitively rem=
oving the page
>>>>>>>>  * from the guest system.
>>>>>>>>  *
>>>>>>>> + * Will fall back to smaller orders if allocation fails. The or=
der of the
>>>>>>>> + * allocated page is stored in page->private.
>>>>>>>> + *
>>>>>>>>  * Return: struct page for the allocated page or NULL on allocat=
ion failure.
>>>>>>>>  */
>>>>>>>> -struct page *balloon_page_alloc(void)
>>>>>>>> +struct page *balloon_pages_alloc(int order)
>>>>>>>> {
>>>>>>>> -	struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
>>>>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>>>> -				       __GFP_NOWARN);
>>>>>>>> -	return page;
>>>>>>>> +	struct page *page;
>>>>>>>> +
>>>>>>>> +	while (order >=3D 0) {
>>>>>>>> +		page =3D alloc_pages(balloon_mapping_gfp_mask() |
>>>>>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>>>> +				   __GFP_NOWARN, order);
>>>>>>>> +		if (page) {
>>>>>>>> +			set_page_private(page, order);
>>>>>>>> +			return page;
>>>>>>>> +		}
>>>>>>>> +		order--;
>>>>>>>> +	}
>>>>>>>> +	return NULL;
>>>>>>>> }
>>>>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>>>>>
>>>>>>>> /*
>>>>>>>>  * balloon_page_enqueue - inserts a new page into the balloon pa=
ge list.
>>>>>>>
>>>>>>>
>>>>>>> I think this will try to invoke direct reclaim from the first ite=
ration
>>>>>>> to free up the max order.
>>>>>>
>>>>>> %__GFP_NORETRY: The VM implementation will try only very lightweig=
ht
>>>>>> memory direct reclaim to get some memory under memory pressure (th=
us it
>>>>>> can sleep). It will avoid disruptive actions like OOM killer.
>>>>>>
>>>>>> Certainly good enough for a first version I would say, no?
>>>>>
>>>>> Frankly how well that behaves would depend a lot on the workload.
>>>>> Can regress just as well.
>>>>>
>>>>> For the 1st version I'd prefer something that is the least disrupti=
ve,
>>>>> and that IMHO means we only trigger reclaim at all in the same conf=
iguration
>>>>> as now - when we can't satisfy the lowest order allocation.
>>>>
>>>> Agreed.
>>>>
>>>>> Anything else would be a huge amount of testing with all kind of
>>>>> workloads.
>>>>
>>>> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
>>>> GFP_TRANSHUGE_LIGHT)
>>>
>>> That will improve the situation when reclaim is not needed, but leave
>>> the problem in place for when it's needed: if reclaim does trigger, w=
e
>>> can get a huge free page and immediately break it up.
>>>
>>> So it's ok as a first step but it will make the second step harder as
>>> we'll need to test with reclaim :).
>>
>> I expect the whole "steal huge pages from your guest" to be problemati=
c,
>> as I already mentioned to Alex. This needs a performance evaluation.
>>
>> This all smells like a lot of workload dependent fine-tuning. :)
>=20
> AFAIK the hardware overheads of keeping huge-pages in the guest and bac=
king
> them with 4KB pages are non-negligible. Did you take those into account=
?

Of course, the fastest mapping will be huge pages in host and guest.
Having huge pages in your guest but not in your host cannot really be
solved using ballooning AFAIKs. Hopefully THP in the host will be doing
its job properly :)

... however, so far, we haven't done any performance comparisons at all.
The only numbers from Hui Zhu that I can spot are number of THP in the
host, which is not really expressing actual guest performance IMHO. That
definitely has to be done to evaluate the different optimizations we
might want to try out.

--=20
Thanks,

David / dhildenb

