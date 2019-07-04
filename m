Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E45F125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 04:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGDCK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 22:10:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfGDCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:10:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C23354D145811D96A48B;
        Thu,  4 Jul 2019 10:10:55 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 10:10:44 +0800
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <20190704120235.5914499b@canb.auug.org.au>
 <20190704020418.GC32502@mellanox.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <81ceb2fe-d6c2-a0ee-cbdd-29ae4d86c965@huawei.com>
Date:   Thu, 4 Jul 2019 10:10:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190704020418.GC32502@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019/7/4 10:04, Jason Gunthorpe 写道:
> On Thu, Jul 04, 2019 at 12:02:35PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Mon, 1 Jul 2019 14:14:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi all,
>>>
>>> After merging the rdma tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
>>> see include/linux/module.h for more information
>> 	.
>> 	.
>> 	.
>>> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
>> 	.
>> 	.
>> 	.
>>> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
>>>
>>> Presumably caused by commit
>>>
>>>   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
>>>
>>> I have used the rdma tree from next-20190628 for today.
>> I am still getting these errors/warnings.
> I have not got a fixing patch from HNS team.
>
> At this late date I will revert the problematic HNS patch tomorrow.
>
> Jason
Hi， Jason
  Sorry,  our guys may not see your mail in time. I will fix it and send a email in today.

Thanks
Lijun Ou
> .
>


