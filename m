Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807205F1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 06:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfGDELh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 00:11:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbfGDELh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:11:37 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D969C9A920B5526DD5F2;
        Thu,  4 Jul 2019 12:11:34 +0800 (CST)
Received: from [127.0.0.1] (10.65.94.163) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 12:11:25 +0800
Subject: Re: linux-next: build failure after merge of the rdma tree
From:   wangxi <wangxi11@huawei.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <20190704120235.5914499b@canb.auug.org.au>
 <20190704020418.GC32502@mellanox.com>
 <df072872-d0c3-a030-2237-d275f1147106@huawei.com>
Message-ID: <1976b003-ed63-2638-b7d2-3d8847b960f8@huawei.com>
Date:   Thu, 4 Jul 2019 12:10:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <df072872-d0c3-a030-2237-d275f1147106@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.94.163]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2019/7/4 12:07, wangxi д��:
> 
> 
> �� 2019/7/4 10:04, Jason Gunthorpe д��:
>> On Thu, Jul 04, 2019 at 12:02:35PM +1000, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Mon, 1 Jul 2019 14:14:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> After merging the rdma tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
>>>> see include/linux/module.h for more information
>>> 	.
>>> 	.
>>> 	.
>>>> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
>>> 	.
>>> 	.
>>> 	.
>>>> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
>>>>
>>>> Presumably caused by commit
>>>>
>>>>   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
>>>>
>>>> I have used the rdma tree from next-20190628 for today.
>>>
>>> I am still getting these errors/warnings.
>>
>> I have not got a fixing patch from HNS team.
>>
>> At this late date I will revert the problematic HNS patch tomorrow.
>> There is indeed a mistake, I will append a patch as soon as possible.
> 
> The patch sent before has a problem caused by the merge of the local code. The correct one
> should be as follows :
> 
> diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
> index b956cf4..b06125f 100644
> --- a/drivers/infiniband/hw/hns/Makefile
> +++ b/drivers/infiniband/hw/hns/Makefile
> @@ -9,8 +9,8 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
>         hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
> 
>  ifdef CONFIG_INFINIBAND_HNS_HIP06
> -hns-roce-hw-v1-objs := hns_roce_hw_v1.o
> -obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o $(hns-roce-objs)
> +hns-roce-hw-v1-objs := hns_roce_hw_v1.o $(hns-roce-objs)
> +obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o
>  endif
> 

The old patch does have an error and I will append a new patch as soon as possible.

>> Jason
>> .
>>

