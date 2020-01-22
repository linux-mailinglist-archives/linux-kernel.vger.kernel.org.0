Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7142C145226
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAVKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 05:09:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAVKJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:09:45 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3ECC2269739C716551D0;
        Wed, 22 Jan 2020 10:09:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 22 Jan 2020 10:09:42 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Jan
 2020 10:09:42 +0000
From:   John Garry <john.garry@huawei.com>
Subject: About irq_create_affinity_masks() for a platform device driver
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Message-ID: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
Date:   Wed, 22 Jan 2020 10:09:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

A question about the function in the $subject:

Would there be any issue with a SCSI platform device driver referencing 
this function?

So I have a multi-queue platform device, and I want to spread interrupts 
over all possible CPUs, just like we can do for PCI MSI vectors. This 
topic was touched on in [0].

And, if so it's ok, could we export that same symbol?

Cheers,
John

[0] 
https://lore.kernel.org/lkml/88d64d51-4344-e908-b55b-0583b0137ddf@huawei.com/
