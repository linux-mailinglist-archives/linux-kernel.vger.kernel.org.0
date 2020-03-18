Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1C189DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCROZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 10:25:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2575 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbgCROZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:25:20 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 8D3C057029B21CBD24D2;
        Wed, 18 Mar 2020 14:25:18 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Mar 2020 14:25:18 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Mar
 2020 14:25:16 +0000
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>, <luojiaxing@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <2c367508-f81b-342e-eb05-8bbd1b056279@huawei.com>
 <9ce0b23455a06d92161c5302ac28152e@kernel.org>
 <8b141d09-ac11-34ec-0922-c21c22f94f36@huawei.com>
 <7b97c24ceced7560b5acb03edaf2cd70@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3601cd4f-7b01-5ec8-0f23-bc19484a7b74@huawei.com>
Date:   Wed, 18 Mar 2020 14:25:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7b97c24ceced7560b5acb03edaf2cd70@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2020 14:16, Marc Zyngier wrote:
>>
>> On my D06CS board (128 core), there seems to be something wrong, as
>> the q0 affinity mask looks incorrect:
>>
>> PCI name is 81:00.0: nvme0n1
>>
>>
>>         irq 322, cpu list 69, effective list 69
>>
>>

...

> 
> Sorry, can you explain in more detail what you find wrong in this log?
> Is it that interrupt 322 has a single CPU affinity instead of a list?
> 
>> And something stranger for my colleague Luo Jiaxing, specifically the 

Hi Marc,

Sorry, ignore this. I just realized after that the NVMe PCI driver 
reserved queue0 vector as without affinity spreading, i.e. non-managed.

Cheers,
John

