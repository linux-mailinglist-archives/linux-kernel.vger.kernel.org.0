Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA016350C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 22:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFDURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 16:17:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3027 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:17:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf6d1da0000>; Tue, 04 Jun 2019 13:17:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 13:17:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 13:17:43 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 20:17:43 +0000
Subject: Re: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap
 pages
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20190604164813.31514-1-ira.weiny@intel.com>
 <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
 <CAPcyv4hmN7M3Y1HzVGSi9JuYKUUmvBRgxmkdYdi_6+H+eZAyHA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4d97645c-0e55-37c0-1a16-8649706b9e78@nvidia.com>
Date:   Tue, 4 Jun 2019 13:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hmN7M3Y1HzVGSi9JuYKUUmvBRgxmkdYdi_6+H+eZAyHA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559679450; bh=Ys4ew+Gn4nTU0UcGzoVS+OBJ0Amfu2GbT4HCKGZeoDg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gx4TZAEOnnJoMkQENcIFwkJRTeWMbOPM7mRcK+8rjXNzVqKtDzpAdmm7NnBAGtfQI
         A0eEnruDTcpmH8hKXEjNLMNckgvcHOStNiReVkWzaHHb1Q/iPZFkiDxQkhArWOMGC+
         D7lv9c504aqW9XuEkLGvK+i/G2TqEq/rWS6bvB2zbHv4LjdpyUKlZvZLDo0wVQHUj8
         Hdn4Q+2ZbnsI9Qk+d4lDU2LEf+nvS5D3BIYxFpgLmNtc9ORa9cEkMonoegxqbxAV/7
         idTsoGv3ZZffMTpLFTJ6pWH+DvyHDvUPnGlSckAa0dLGLYzt1h97UYOsLMnyRPfttx
         Fsju2MaD0zNcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 1:11 PM, Dan Williams wrote:
> On Tue, Jun 4, 2019 at 12:48 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 6/4/19 9:48 AM, ira.weiny@intel.com wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
...
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index 7ede3eddc12a..6d153ce4cb8c 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
>>>               if (is_huge_zero_page(page))
>>>                       continue;
>>>
>>> -             /* Device public page can not be huge page */
>>> -             if (is_device_public_page(page)) {
>>> +             if (is_zone_device_page(page)) {
>>>                       if (locked_pgdat) {
>>>                               spin_unlock_irqrestore(&locked_pgdat->lru_lock,
>>>                                                      flags);
>>>                               locked_pgdat = NULL;
>>>                       }
>>> -                     put_devmap_managed_page(page);
>>> -                     continue;
>>> +                     /*
>>> +                      * Not all zone-device-pages require special
>>> +                      * processing.  Those pages return 'false' from
>>> +                      * put_devmap_managed_page() expecting a call to
>>> +                      * put_page_testzero()
>>> +                      */
>>
>> Just a documentation tweak: how about:
>>
>>                         /*
>>                          * ZONE_DEVICE pages that return 'false' from
>>                          * put_devmap_managed_page() do not require special
>>                          * processing, and instead, expect a call to
>>                          * put_page_testzero().
>>                          */
> 
> Looks better to me, but maybe just go ahead and list those
> expectations explicitly. Something like:
> 
>                         /*
>                          * put_devmap_managed_page() only handles
>                          * ZONE_DEVICE (struct dev_pagemap managed)
>                          * pages when the hosting dev_pagemap has the
>                          * ->free() or ->fault() callback handlers
>                          *  implemented as indicated by
>                          *  dev_pagemap.type. Otherwise the expectation
>                          *  is to fall back to a plain decrement /
>                          *  put_page_testzero().
>                          */

I like it--but not here, because it's too much internal detail in a
call site that doesn't use that level of detail. The call site looks
at the return value, only.

Let's instead put that blurb above (or in) the put_devmap_managed_page() 
routine itself. And leave the blurb that I wrote where it is. And then I
think everything will have an appropriate level of detail in the right places.


thanks,
-- 
John Hubbard
NVIDIA
