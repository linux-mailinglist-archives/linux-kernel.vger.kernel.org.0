Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6542D1030DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 01:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKTAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 19:46:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:37641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfKTAqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:46:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 16:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; 
   d="scan'208";a="237537741"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2019 16:46:29 -0800
Date:   Wed, 20 Nov 2019 08:46:20 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory-failure.c: PageHuge is handled at the
 beginning of memory_failure
Message-ID: <20191120004620.GB11061@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <1e61c115-5787-9ef4-a449-2e490c53fca7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e61c115-5787-9ef4-a449-2e490c53fca7@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 01:23:54PM +0100, David Hildenbrand wrote:
>On 18.11.19 09:20, Wei Yang wrote:
>> PageHuge is handled by memory_failure_hugetlb(), so this case could be
>> removed.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   mm/memory-failure.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 3151c87dff73..392ac277b17d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1359,10 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
>>   	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
>>   	 * correctly, we save a copy of the page flags at this time.
>>   	 */
>> -	if (PageHuge(p))
>> -		page_flags = hpage->flags;
>> -	else
>> -		page_flags = p->flags;
>> +	page_flags = p->flags;
>>   	/*
>>   	 * unpoison always clear PG_hwpoison inside page lock
>> 
>
>I somewhat miss a proper explanation why this is safe to do. We access page
>flags here, so why is it safe to refer to the ones of the sub-page?
>

Hi, David

I think your comment is on this line:

	page_flags = p->flags;

Maybe we need to use this:

	page_flags = hpage->flags;

And use hpage in the following or even the whole function?

While one thing interesting is not all "compound page" is PageCompound. For
some sub-page, we can't get the correct head. This means we may just check on
the sub-page.

>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
