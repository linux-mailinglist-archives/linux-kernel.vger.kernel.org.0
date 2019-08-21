Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A423297B18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfHUNjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:39:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728567AbfHUNjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:39:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 654F640D1167F25D5595;
        Wed, 21 Aug 2019 21:39:19 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 21:39:09 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
To:     Mark Brown <broonie@kernel.org>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
 <6c4bb892-6cf5-af46-3ace-b333fd47ef14@huawei.com>
 <9b074db7-b95d-a081-2fba-7b2b82997332@kontron.de>
 <ab2d3c29-982f-cb13-e2a2-e6d8da8f1438@huawei.com>
 <b2a475eb-58e6-e7c7-7b8f-b1be04cf27c0@ti.com>
 <c5e063e8-5025-8206-f819-6ce5228ef0fb@huawei.com>
 <20190820165826.GF4738@sirena.co.uk>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Message-ID: <bd9109c6-8f25-f674-4a7b-c659c4c368df@huawei.com>
Date:   Wed, 21 Aug 2019 14:39:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190820165826.GF4738@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 17:58, Mark Brown wrote:
> On Tue, Aug 20, 2019 at 03:09:15PM +0100, John Garry wrote:
>> On 19/08/2019 05:39, Vignesh Raghavendra wrote:
>>> On 16/08/19 3:50 PM, John Garry wrote:
>
>>>> About the child spi flash devices, is the recommendation to just use
>>>> PRP0001 HID and "jedec,spi-nor" compatible?
>
>>> I am not quite familiar with ACPI systems, but child flash device should
>>> use "jedec,spi-nor" as compatible.
>
>> Right, so to use SPI MEM framework, it looks like I will have to use PRP0001
>> and "jedec,spi-nor" as compatible.
>
>> My reluctance in using PRP0001 and compatible "jedec,spi-nor" is how other
>> OS can understand this.
>

Hi Mark,

> Last I heard Windows wasn't doing anything with PRP0001 but on the other
> hand the idiomatic way to handle this for ACPI is as far as I can tell
> to have what is essentially a board file loaded based on DMI information
> without any real enumerability so there's no real conflict between the
> two methods.

Fine, I'll consider this alt method further.

Thanks,
John

>



