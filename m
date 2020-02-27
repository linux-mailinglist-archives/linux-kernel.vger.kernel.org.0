Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82AE1717BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgB0MqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:46:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:56478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgB0MqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:46:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C92E2AC44;
        Thu, 27 Feb 2020 12:45:58 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: increase default min_free_kbytes bound
To:     John Hubbard <jhubbard@nvidia.com>,
        Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
References: <20200220150103.5183-1-jsavitz@redhat.com>
 <4778f04b-7ff0-0648-1ff9-dd02c79f45ea@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bd3f55cd-7aaa-f99f-1e85-dcc0072d0ae3@suse.cz>
Date:   Thu, 27 Feb 2020 13:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4778f04b-7ff0-0648-1ff9-dd02c79f45ea@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 2:53 AM, John Hubbard wrote:
> On 2/20/20 7:01 AM, Joel Savitz wrote:
>> 
>> Currently, the vm.min_free_kbytes sysctl value is capped at a hardcoded
>> 64M in init_per_zone_wmark_min (unless it is overridden by khugepaged
>> initialization).
>> 
>> This value has not been modified since 2005, and enterprise-grade
>> systems now frequently have hundreds of GB of RAM and multiple 10, 40,
>> or even 100 GB NICs. We have seen page allocation failures on heavily
>> loaded systems related to NIC drivers. These issues were resolved by an
>> increase to vm.min_free_kbytes.
>> 
>> This patch increases the hardcoded value by a factor of 4 as a temporary
>> solution.
>> 
>> Further work to make the calculation of vm.min_free_kbytes more
>> consistent throughout the kernel would be desirable.
>> 
>> As an example of the inconsistency of the current method, this value is
>> recalculated by init_per_zone_wmark_min() in the case of memory hotplug
>> which will override the value set by set_recommended_min_free_kbytes()
>> called during khugepaged initialization even if khugepaged remains
>> enabled, however an on/off toggle of khugepaged will then recalculate
>> and set the value via set_recommended_min_free_kbytes().
>> 
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> ---
>>  mm/page_alloc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3c4eb750a199..32cbfb13e958 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7867,8 +7867,8 @@ int __meminit init_per_zone_wmark_min(void)
>>  		min_free_kbytes = new_min_free_kbytes;
>>  		if (min_free_kbytes < 128)
>>  			min_free_kbytes = 128;
>> -		if (min_free_kbytes > 65536)
>> -			min_free_kbytes = 65536;
>> +		if (min_free_kbytes > 262144)
>> +			min_free_kbytes = 262144;
> 
> 
> Would it be any better to at least use symbols, instead of numbers, in the
> routine? Like this:

+1

Thanks
