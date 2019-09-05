Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6DA9AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfIEGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:49:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730914AbfIEGtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:49:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DF1744DE8704112B55E;
        Thu,  5 Sep 2019 14:49:17 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:49:10 +0800
Subject: Re: [PATCH RFC] driver core: ensure a device has valid node id in
 device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <mhocko@kernel.org>,
        <linuxarm@huawei.com>
References: <1567647230-166903-1-git-send-email-linyunsheng@huawei.com>
 <20190905055727.GB23826@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e5905af2-5a8d-7b00-d2a6-a961f3eee120@huawei.com>
Date:   Thu, 5 Sep 2019 14:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190905055727.GB23826@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/5 13:57, Greg KH wrote:
> On Thu, Sep 05, 2019 at 09:33:50AM +0800, Yunsheng Lin wrote:
>> Currently a device does not belong to any of the numa nodes
>> (dev->numa_node is NUMA_NO_NODE) when the FW does not provide
>> the node id and the device has not no parent device.
>>
>> According to discussion in [1]:
>> Even if a device's numa node is not set by fw, the device
>> really does belong to a node.
>>
>> This patch sets the device node to node 0 in device_add() if
>> the fw has not specified the node id and it either has no
>> parent device, or the parent device also does not have a valid
>> node id.
>>
>> There may be explicit handling out there relying on NUMA_NO_NODE,
>> like in nvme_probe().
>>
>> [1] https://lkml.org/lkml/2019/9/2/466
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  drivers/base/core.c  | 17 ++++++++++++++---
>>  include/linux/numa.h |  2 ++
>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 1669d41..466b8ff 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2107,9 +2107,20 @@ int device_add(struct device *dev)
>>  	if (kobj)
>>  		dev->kobj.parent = kobj;
>>  
>> -	/* use parent numa_node */
>> -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
>> -		set_dev_node(dev, dev_to_node(parent));
>> +	/* use parent numa_node or default node 0 */
>> +	if (!numa_node_valid(dev_to_node(dev))) {
>> +		int nid = parent ? dev_to_node(parent) : NUMA_NO_NODE;
> 
> Can you expand this to be a "real" if statement please?

Sure. May I ask why "? :" is not appropriate here?

> 
>> +
>> +		if (numa_node_valid(nid)) {
>> +			set_dev_node(dev, nid);
>> +		} else {
>> +			if (nr_node_ids > 1U)
>> +				pr_err("device: '%s': has invalid NUMA node(%d)\n",
>> +				       dev_name(dev), dev_to_node(dev));
> 
> dev_err() will show you the exact device properly, instead of having to
> rely on dev_name().
> 
> And what is a user to do if this message happens?  How do they fix this?
> If they can not, what good is this error message?

If user know about their system's topology well enough and node 0
is not the nearest node to the device, maybe user can readjust that by
writing the nearest node to /sys/class/pci_bus/XXXX/device/numa_node,
if not, then maybe user need to contact the vendor for info or updates.

Maybe print error message as below:

dev_err(dev, FW_BUG "has invalid NUMA node(%d). Readjust it by writing to sysfs numa_node or contact your vendor for updates.\n",
	dev_to_node(dev));

> 
> thanks,
> 
> greg k-h
> 
> .
> 

