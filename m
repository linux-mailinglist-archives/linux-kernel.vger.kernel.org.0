Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96A19982E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgCaOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:10:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730358AbgCaOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585663816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zaDvsYN8BRJn6uzt9vBaEcPBXIxrW6ki6PG9mgIOd/0=;
        b=KNzi5Q/ptSpAlKSl4pcxJQk1s6o8KEjIlv4nDnBOEOOIlRLZLpWEeXTjbfkRbt2OZecLr+
        t+Df/Sq6ihHQ/PjhjM/3ghlSB75GRVZqhCBikWZyuJ8QIxgVTCdz7jULxvP1Pyw6uUZHqF
        S1YvL/DLbJrHOOcB74MqtL16ur5uLxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-rDuJkBoBOOCVSDWMqShx_A-1; Tue, 31 Mar 2020 10:10:12 -0400
X-MC-Unique: rDuJkBoBOOCVSDWMqShx_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5780A801E74;
        Tue, 31 Mar 2020 14:10:11 +0000 (UTC)
Received: from [10.36.114.0] (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C2795C1C5;
        Tue, 31 Mar 2020 14:10:00 +0000 (UTC)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
Date:   Tue, 31 Mar 2020 16:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331100359-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.20 16:07, Michael S. Tsirkin wrote:
> On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
>> On 31.03.20 15:37, Michael S. Tsirkin wrote:
>>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
>>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
>>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote=
:
>>>>>>>>
>>>>>>>>
>>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.c=
om>:
>>>>>>>>>
>>>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hilden=
brand wrote:
>>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand w=
rote:
>>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fa=
stest
>>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be =
able to make
>>>>>>>>>>>> use of THP where it previously was able to. I can imagine th=
is implies a
>>>>>>>>>>>> performance degradation for some workloads. This needs a pro=
per
>>>>>>>>>>>> performance evaluation.
>>>>>>>>>>>
>>>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>>>
>>>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>>>>>>>> Along the lines of
>>>>>>>>>>>
>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_=
order,
>>>>>>>>>>>                    unsigned int max_order, unsigned int *orde=
r)
>>>>>>>>>>>
>>>>>>>>>>> the idea would then be to return at a number of pages in the =
given
>>>>>>>>>>> range.
>>>>>>>>>>>
>>>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>>>
>>>>>>>>>> You can just start with the highest order and decrement the or=
der until
>>>>>>>>>> your allocation succeeds using alloc_pages(), which would be e=
nough for
>>>>>>>>>> a first version. At least I don't see the immediate need for a=
 new
>>>>>>>>>> kernel API.
>>>>>>>>>
>>>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim=
 is
>>>>>>>>> completely disabled, any of these calls can sleep. After it wak=
es up,
>>>>>>>>> we would like to get the larger order that has become available
>>>>>>>>> meanwhile.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
>>>>>>>> So I think we should do a trivial implementation first and then =
see what we gain from a new allocator API. Then we might also be able to =
justify it using real numbers.
>>>>>>>>
>>>>>>>
>>>>>>> Well how do you propose implement the necessary semantics?
>>>>>>> I think we are both agreed that alloc_page_range is more or
>>>>>>> less what's necessary anyway - so how would you approximate it
>>>>>>> on top of existing APIs?
>>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/ba=
lloon_compaction.h
>>>
>>> .....
>>>
>>>
>>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>>> index 26de020aae7b..067810b32813 100644
>>>>>> --- a/mm/balloon_compaction.c
>>>>>> +++ b/mm/balloon_compaction.c
>>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct ball=
oon_dev_info *b_dev_info,
>>>>>>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>>> =20
>>>>>>  /*
>>>>>> - * balloon_page_alloc - allocates a new page for insertion into t=
he balloon
>>>>>> - *			page list.
>>>>>> + * balloon_pages_alloc - allocates a new page (of at most the giv=
en order)
>>>>>> + * 			 for insertion into the balloon page list.
>>>>>>   *
>>>>>>   * Driver must call this function to properly allocate a new ball=
oon page.
>>>>>>   * Driver must call balloon_page_enqueue before definitively remo=
ving the page
>>>>>>   * from the guest system.
>>>>>>   *
>>>>>> + * Will fall back to smaller orders if allocation fails. The orde=
r of the
>>>>>> + * allocated page is stored in page->private.
>>>>>> + *
>>>>>>   * Return: struct page for the allocated page or NULL on allocati=
on failure.
>>>>>>   */
>>>>>> -struct page *balloon_page_alloc(void)
>>>>>> +struct page *balloon_pages_alloc(int order)
>>>>>>  {
>>>>>> -	struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
>>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>> -				       __GFP_NOWARN);
>>>>>> -	return page;
>>>>>> +	struct page *page;
>>>>>> +
>>>>>> +	while (order >=3D 0) {
>>>>>> +		page =3D alloc_pages(balloon_mapping_gfp_mask() |
>>>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>> +				   __GFP_NOWARN, order);
>>>>>> +		if (page) {
>>>>>> +			set_page_private(page, order);
>>>>>> +			return page;
>>>>>> +		}
>>>>>> +		order--;
>>>>>> +	}
>>>>>> +	return NULL;
>>>>>>  }
>>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>>> =20
>>>>>>  /*
>>>>>>   * balloon_page_enqueue - inserts a new page into the balloon pag=
e list.
>>>>>
>>>>>
>>>>> I think this will try to invoke direct reclaim from the first itera=
tion
>>>>> to free up the max order.
>>>>
>>>> %__GFP_NORETRY: The VM implementation will try only very lightweight
>>>> memory direct reclaim to get some memory under memory pressure (thus=
 it
>>>> can sleep). It will avoid disruptive actions like OOM killer.
>>>>
>>>> Certainly good enough for a first version I would say, no?
>>>
>>> Frankly how well that behaves would depend a lot on the workload.
>>> Can regress just as well.
>>>
>>> For the 1st version I'd prefer something that is the least disruptive=
,
>>> and that IMHO means we only trigger reclaim at all in the same config=
uration
>>> as now - when we can't satisfy the lowest order allocation.
>>
>> Agreed.
>>
>>>
>>> Anything else would be a huge amount of testing with all kind of
>>> workloads.
>>>
>>
>> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
>> GFP_TRANSHUGE_LIGHT)
>=20
> That will improve the situation when reclaim is not needed, but leave
> the problem in place for when it's needed: if reclaim does trigger, we
> can get a huge free page and immediately break it up.
>=20
> So it's ok as a first step but it will make the second step harder as
> we'll need to test with reclaim :).

I expect the whole "steal huge pages from your guest" to be problematic,
as I already mentioned to Alex. This needs a performance evaluation.

This all smells like a lot of workload dependent fine-tuning. :)

--=20
Thanks,

David / dhildenb

