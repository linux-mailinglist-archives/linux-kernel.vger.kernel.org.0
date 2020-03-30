Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66121976DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgC3Iow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:44:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728759AbgC3Iow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:44:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75258CA3697BEB96955C;
        Mon, 30 Mar 2020 16:44:45 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 16:44:34 +0800
Subject: Re: [PATCH] mtd:clear cache_state to avoid writing to bad clocks
 repeatedly
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
References: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
 <20200330095341.284048c3@xps13>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <a012c55f-e7c4-fd6d-3e3f-f132474a0b06@huawei.com>
Date:   Mon, 30 Mar 2020 16:44:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200330095341.284048c3@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/30 15:53, Miquel Raynal wrote:
> Hi Xiaoming,
> 
> Xiaoming Ni <nixiaoming@huawei.com> wrote on Sat, 28 Mar 2020 21:01:17
> +0800:
> 
>> The function call process is as follows:
>> 	mtd_blktrans_work()
>> 	  while (1)
....

>> +	 *
>> +	 * if this cache_offset points to a bad block
> 
> Can you start your sentences with a capital letter please?
> 
> 	 * If
> 
>> +	 * data cannot be written to the device.
>> +	 * clear cache_state to avoid writing to bad clocks repeatedly
> 
> 	 * Clear
> 
> And also please break your lines à 80, not 70.
> 
>>   	 */
>> -	mtdblk->cache_state = STATE_EMPTY;
>> -	return 0;
>> +	if (ret == 0 || ret == -EIO)
>> +		mtdblk->cache_state = STATE_EMPTY;
Should I add a warning print for EIO here


>> +	return ret;
>>   }
>>   
>>   
> 
> Otherwise looks good to me.
> 
> With the above addressed:
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> 
> Thanks,
> Miquèl
> 
> .

Thanks for your advice, I will send v2 patch later

Thanks,
Xiaoming Ni



