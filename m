Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7D174491
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 03:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB2CvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 21:51:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgB2CvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 21:51:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B90E63DB0D87F8AAB135;
        Sat, 29 Feb 2020 10:51:08 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Feb 2020
 10:50:58 +0800
Subject: Re: [PATCH V2] block: rename 'q->debugfs_dir' and 'q->blk_trace->dir'
 in blk_unregister_queue()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <bvanassche@acm.org>,
        <dhowells@redhat.com>, <asml.silence@gmail.com>,
        <ajay.joshi@wdc.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <luoshijie1@huawei.com>
References: <20200213081252.32395-1-yukuai3@huawei.com>
 <20200228231557.GA18123@ming.t460p>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <96287511-a121-02f5-c5e0-24873fd30179@huawei.com>
Date:   Sat, 29 Feb 2020 10:50:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200228231557.GA18123@ming.t460p>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/29 7:15, Ming Lei wrote:
> If blk_trace->dir isn't same with .debugfs_dir, you will just rename
> blk_trace->dir, this way can't avoid the failure in step3, can it?
Thank you for your response!
It's true that the problem still exist if they are not the same��I
thougt they can't both exist��. Perhaps I can do the renaming for both.
> 
> I understand that we just need to rename .debugfs_dir, meantime making
> sure blktrace code removes correct debugfs dir, is that enough for fixing
> this issue?
> 
>> +	if (old == NULL)
>> +		return;
>> +	while (new == NULL) {
>> +		sprintf(name, "ready_to_remove_%s_%d",
>> +				kobject_name(q->kobj.parent), i++);
>> +		new = debugfs_rename(blk_debugfs_root, *old,
>> +				     blk_debugfs_root, name);
>> +	}
> The above code can be run concurrently with blktrace shutdown, so race might
> exit between the two code paths, then bt->dir may has been renamed or being
> renamed in debugfs_remove(bt->dir), can this function work as expected or
> correct?
To avoid the race, I think we can take the lock 'blk_trace_mutex' while
renaming 'bt->dir'.
> 
> And there is dead loop risk, so suggest to not rename this way.
The deap loop will exist if 'debugfs_rename' keep failing for some
reason. I thougt about setting a limit for max loop count, however, It's
probably not a good solution.

Thanks!
Yu Kuai
> 

