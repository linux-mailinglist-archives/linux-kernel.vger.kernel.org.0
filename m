Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1782BDC369
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633592AbfJRLAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 07:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19871 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633557AbfJRLAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34B2318C426B;
        Fri, 18 Oct 2019 11:00:47 +0000 (UTC)
Received: from [10.36.118.23] (unknown [10.36.118.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD701614EE;
        Fri, 18 Oct 2019 11:00:45 +0000 (UTC)
Subject: Re: memory offline infinite loop after soft offline
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <33946728-bdeb-494a-5db8-e279acebca47@redhat.com>
 <20191018082459.GE5017@dhcp22.suse.cz>
 <f065d998-7fa3-ef9a-c2f4-5b9116f5596b@redhat.com>
 <20191018085528.GG5017@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3ac0ad7a-7dd2-c851-858d-2986fa8d44b6@redhat.com>
Date:   Fri, 18 Oct 2019 13:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018085528.GG5017@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 18 Oct 2019 11:00:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.19 10:55, Michal Hocko wrote:
> On Fri 18-10-19 10:38:21, David Hildenbrand wrote:
>> On 18.10.19 10:24, Michal Hocko wrote:
>>> On Fri 18-10-19 10:13:36, David Hildenbrand wrote:
>>> [...]
>>>> However, if the compound page spans multiple pageblocks
>>>
>>> Although hugetlb pages spanning pageblocks are possible this shouldn't
>>> matter in__test_page_isolated_in_pageblock because this function doesn't
>>> really operate on pageblocks as the name suggests.  It is simply
>>> traversing all valid RAM ranges (see walk_system_ram_range).
>>
>> As long as the hugepages don't span memory blocks/sections, you are right. I
>> have no experience with gigantic pages in this regard.
> 
> They can clearly span sections (1GB is larger than 128MB). Why do you
> think it matters actually? walk_system_ram_range walks RAM ranges and no
> allocation should span holes in RAM right?
> 

Let's explore what I was thinking. If we can agree that any compound 
page is always aligned to its size , then what I tell here is not 
applicable. I know it is true for gigantic pages.

Some extreme example to clarify

[ memory block 0 (128MB) ][ memory block 1 (128MB) ]
               [ compound page (128MB)  ]

If you would offline memory block 1, and you detect PG_offline on the 
first page of that memory block (PageHWPoison(compound_head(page))), you 
would jump over the whole memory block (pfn += 1 << 
compound_order(page)), leaving 64MB of the memory block unchecked.

Again, if any compound page has the alignment restrictions (PFN of head 
aligned to 1 << compound_order(page)), this is not possible.


If it is, however, possible, the "clean" thing would be to only jump 
over the remaining part of the compound page, e.g., something like

pfn += (1 << compound_order(page)) - (page - compound_head(page)));



-- 

Thanks,

David / dhildenb
