Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4F142BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 14:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgATNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 08:15:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgATNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:15:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC48F2AC7CA908E68B80;
        Mon, 20 Jan 2020 21:15:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 21:14:52 +0800
Subject: Re: [PATCH V3] brd: check and limit max_part par
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <c8236e55-f64f-ef40-b394-8b7e86ce50df@huawei.com>
 <20200115022725.GA14585@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <ce5823ea-2183-90df-05b0-c02d1f654be3@huawei.com>
Date:   Mon, 20 Jan 2020 21:14:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115022725.GA14585@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/15 10:27, Ming Lei wrote:

> 
>>  MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
>>
>>  unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
>>  module_param(rd_size, ulong, 0444);
>>  MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
>>
>> -static int max_part = 1;
>> -module_param(max_part, int, 0444);
>> +static unsigned int max_part = 1;
>> +module_param(max_part, uint, 0444);
> 
> The above change isn't needed.
Thanks for your suggestion.
I will remove that in v4 patch.
> 
>>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>>
>>  MODULE_LICENSE("GPL");
>> @@ -393,7 +393,14 @@ static struct brd_device *brd_alloc(int i)
>>  	if (!disk)
>>  		goto out_free_queue;
>>  	disk->major		= RAMDISK_MAJOR;
>> -	disk->first_minor	= i * max_part;
>> +	/*
>> +	 * Clear .minors when running out of consecutive minor space since
>> +	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended devt.
>> +	 */
>> +	if ((i * disk->minors) & ~MINORMASK)
>> +		disk->minors = 0;
>> +	else
>> +		disk->first_minor = i * disk->minors;
> 
> The above looks a bit ugly, one nice way could be to change in
> brd_alloc():
> 
> 	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
> 		0 : max_part);

I will change it as your suggestion.

> 
>>  	disk->fops		= &brd_fops;
>>  	disk->private_data	= brd;
>>  	disk->queue		= brd->brd_queue;
>> @@ -468,6 +475,21 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
>>  	return kobj;
>>  }
>>
>> +static inline void brd_check_and_reset_par(void)
>> +{
>> +	if (unlikely(!rd_nr))
>> +		rd_nr = 1;
> 
> zero rd_nr should work as expected, given user can create dev file via
> mknod, and brd_probe() will be called for populate brd disk/queue when
> the disk file is opened.
> 
>> +static inline void brd_check_and_reset_par(void)
>> +{
>> +       if (unlikely(!rd_nr))
>> +               rd_nr = 1;
>> +
>> +       if (unlikely(!max_part))
>> +               max_part = 1;
> 
> Another limit is that 'max_part' needs to be divided exactly by (1U <<
> MINORBITS), something like:
> 
> 	max_part = 1UL << fls(max_part)

Do we have to limit that 'max_part' needs to be divided exactly by (1U <<
> MINORBITS)? As your suggestion, the i * max_part is larger than MINORMASK,
we can allocate from extended devt.

Thanks,
Zhiqiang Liu

