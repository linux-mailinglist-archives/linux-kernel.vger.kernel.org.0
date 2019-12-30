Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615CD12CFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 12:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfL3LuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 06:50:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57736 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3LuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:50:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUBnrjk051760;
        Mon, 30 Dec 2019 05:49:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577706593;
        bh=dk8JOyg8TLt6nJrrW0m7Ombvrj/tTXz/hWTqmHoM7FA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=agi7xx89ugH9OklDjQiAxTR5sVW7sGPrWWnQ8wC4sLEZjTavTKMdIHQE2uQ/eY+0b
         XyM+iOTx0RGdjgbLwiVEEYAlKFjcbmJaStA59yiWin/mWoiKGF142kD/iac5damZoH
         RjFRhsRV86VZLVXBOkpbKamXvGx0bPqP3QdoJP8g=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUBnrYl039633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 05:49:53 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 05:49:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 05:49:53 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUBnnhK056669;
        Mon, 30 Dec 2019 05:49:49 -0600
Subject: Re: [PATCH 0/2] phy: brcm-sata: Support for 7216
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
References: <20191210200852.24945-1-f.fainelli@gmail.com>
 <9ede5ded-9ca2-e0c8-0b81-e43b08f99b29@broadcom.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0df5ca74-0a52-b229-a6b1-f72944d56441@ti.com>
Date:   Mon, 30 Dec 2019 17:21:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9ede5ded-9ca2-e0c8-0b81-e43b08f99b29@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/12/19 9:06 AM, Florian Fainelli wrote:
> 
> 
> On 12/10/2019 12:08 PM, Florian Fainelli wrote:
>> Hi Kishon,
>>
>> This patch series adds support for our latest 7216 class of devices
>> which are taped out in a 16nm process and use a different SATA PHY AFE
>> that requires a custom initialization sequence.
> 
> Kishon, is this looking good to you for merging? Thanks!

Patch looks good. I've merged them now.

Thanks
Kishon
> 
>>
>> Thanks!
>>
>> Florian Fainelli (2):
>>   dt-bindings: phy: Document BCM7216 SATA PHY compatible string
>>   phy: brcm-sata: Implement 7216 initialization sequence
>>
>>  .../devicetree/bindings/phy/brcm-sata-phy.txt |   1 +
>>  drivers/phy/broadcom/phy-brcm-sata.c          | 120 ++++++++++++++++++
>>  2 files changed, 121 insertions(+)
>>
> 
