Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8984315183F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgBDJzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:55:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbgBDJzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:55:04 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2001ED00F51BCB16E63F;
        Tue,  4 Feb 2020 09:55:02 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Feb 2020 09:55:01 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 4 Feb 2020
 09:55:01 +0000
Subject: Re: About irq_create_affinity_masks() for a platform device driver
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
 <87o8uveoye.fsf@nanos.tec.linutronix.de>
 <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com>
 <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com>
 <87ftfvuww7.fsf@nanos.tec.linutronix.de>
 <2b381b20-512a-27a5-38d7-2f6a673bb621@huawei.com>
 <871rrazp31.fsf@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f680ca16-8c33-a632-8777-084d424d456b@huawei.com>
Date:   Tue, 4 Feb 2020 09:55:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <871rrazp31.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> 
>> And if we were to go this way, then we don't need to add the pointer in
>> struct platform_device to hold affinity mask descriptors as we're using
>> them immediately. Or even have a single function to do it all in the irq
>> code (create the masks and update the affinity desc).
>>
>> And since we're just updating the masks, I figure we shouldn't need to
>> add acpi_irq_get_count(), which I invented to get the irq count (without
>> creating the IRQ mapping).
> Yes, you can create and apply the masks after setting up the interrupts.
> 

So my original concern was that the changes here would be quite 
disruptive, but that does not look to be the case.

I need a couple of more things to go into the kernel before I can safely 
switch to use managed interrupts in the LLDD, like "blk-mq: improvement 
CPU hotplug" series, so I will need to wait on that for the moment.

Thanks,
John
