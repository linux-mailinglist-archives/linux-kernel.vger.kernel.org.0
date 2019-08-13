Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660E28ADB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHME2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 00:28:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfHME2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:28:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 089BAF5CF0F1E40671D2;
        Tue, 13 Aug 2019 12:28:29 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 12:28:23 +0800
Subject: Re: [PATCH] nbd: add a missed nbd_config_put() in nbd_xmit_timeout()
To:     Mike Christie <mchristi@redhat.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>
References: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
 <5D518714.5000408@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <c2ca0231-b981-d01f-8d03-3cc392c7aa27@huawei.com>
Date:   Tue, 13 Aug 2019 12:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5D518714.5000408@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review.

在 2019/8/12 23:34, Mike Christie 写道:
> On 08/12/2019 07:31 AM, Sun Ke wrote:
>> When try to get the lock failed, before return, execute the
>> nbd_config_put() to decrease the nbd->config_refs.
>>
>> If the nbd->config_refs is added but not decreased. Then will not
>> execute nbd_clear_sock() in nbd_config_put(). bd->task_setup will
>> not be cleared away. Finally, print"Device being setup by another
>> task" in nbd_add_sock() and nbd device can not be reused.
>>
>> Fixes: 8f3ea35929a0 ("nbd: handle unexpected replies better")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   drivers/block/nbd.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index e21d2de..a69a90a 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -357,8 +357,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>>   	}
>>   	config = nbd->config;
>>   
>> -	if (!mutex_trylock(&cmd->lock))
>> +	if (!mutex_trylock(&cmd->lock)) {
>> +		nbd_config_put(nbd);
>>   		return BLK_EH_RESET_TIMER;
>> +	}
>>   
>>   	if (config->num_connections > 1) {
>>   		dev_err_ratelimited(nbd_to_dev(nbd),
>>
> 
> I just sent the same patch
> 
> https://www.spinics.net/lists/linux-block/msg43718.html
> 
> here
> 
> https://www.spinics.net/lists/linux-block/msg43715.html
> 
> so it looks good to me.
> 
> Reviewed-by: Mike Christie <mchristi@redhat.com>
> 
> .
> 

