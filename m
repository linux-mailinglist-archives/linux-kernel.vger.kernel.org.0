Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65174A9838
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfIECFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 22:05:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbfIECFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:05:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C90804BEDD822EA701C6;
        Thu,  5 Sep 2019 10:05:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 10:05:04 +0800
Message-ID: <5D706D50.3090305@huawei.com>
Date:   Thu, 5 Sep 2019 10:05:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <akpm@linux-foundation.org>, <mhocko@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com> <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
In-Reply-To: <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/4 19:24, Vlastimil Babka wrote:
> On 9/4/19 12:26 PM, zhong jiang wrote:
>> With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
>> compare with zero. And __get_user_pages_locked will return an long value.
>> Hence, Convert the long to compare with zero is feasible.
> It would be nicer if the parameter nr_pages was long again instead of unsigned
> long (note there are two variants of the function, so both should be changed).
Yep, the parameter 'nr_pages' was changed to long. and the variants ‘i、step’ should
be changed accordingly.
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Fixes: 932f4a630a69 ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTERM")
>
> (which changed long to unsigned long)
>
> AFAICS... stable shouldn't be needed as the only "risk" is that we goto
> check_again even when we fail, which should be harmless.
Agreed, Thanks.

Sincerely,
zhong jiang
> Vlastimil
>
>> ---
>>  mm/gup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 23a9f9c..956d5a1 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1508,7 +1508,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>>  						   pages, vmas, NULL,
>>  						   gup_flags);
>>  
>> -		if ((nr_pages > 0) && migrate_allow) {
>> +		if (((long)nr_pages > 0) && migrate_allow) {
>>  			drain_allow = true;
>>  			goto check_again;
>>  		}
>>
>
> .
>


