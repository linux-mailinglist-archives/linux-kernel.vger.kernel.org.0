Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE7BED02
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfIZIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:01:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbfIZIBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:01:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6544E509E05ACE6FB941;
        Thu, 26 Sep 2019 16:01:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 16:00:58 +0800
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        <bvanassche@acm.org>, <bhelgaas@google.com>, <dsterba@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        <sakari.ailus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
 <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e59af8ae-bacb-2e7e-dd53-ea283960d40e@huawei.com>
Date:   Thu, 26 Sep 2019 15:58:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/25 23:20, Alexander Duyck wrote:
> On Wed, 2019-09-25 at 20:52 +0800, Yunfeng Ye wrote:
>> It's not necessary to put kfree() in the critical area of the lock, so
>> let it out.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  kernel/async.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/async.c b/kernel/async.c
>> index 4f9c1d6..1de270d 100644
>> --- a/kernel/async.c
>> +++ b/kernel/async.c
>> @@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
>>  	list_del_init(&entry->domain_list);
>>  	list_del_init(&entry->global_list);
>>
>> -	/* 3) free the entry */
>> -	kfree(entry);
>>  	atomic_dec(&entry_count);
>> -
>>  	spin_unlock_irqrestore(&async_lock, flags);
>>
>> +	/* 3) free the entry */
>> +	kfree(entry);
>> +
>>  	/* 4) wake up any waiters */
>>  	wake_up(&async_done);
>>  }
> 
> It probably wouldn't hurt to update the patch description to mention that
> async_schedule_node_domain does the allocation outside of the lock, then
> takes the lock and does the list addition and entry_count increment inside
> the critical section so this is just updating the code to match that it
> seems.
> 
> Otherwise the change itself looks safe to me, though I am not sure there
> is a performance gain to be had so this is mostly just a cosmetic patch.
> 
The async_lock is big global lock, I think it's good to put kfree() outside
to keep the critical area as short as possible.

thanks.

> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> 
> .
> 

