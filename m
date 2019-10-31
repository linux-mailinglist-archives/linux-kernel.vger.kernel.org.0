Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5AEAD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfJaKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:35:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49604 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfJaKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:35:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9VAZVoK052368;
        Thu, 31 Oct 2019 05:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572518131;
        bh=xd2K39TyiMvWdSDnfYme+ySDuANuSzgdm8f4zU5iyKo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C731e85PGHnlEdQ6Bp90Oflss7JrtrkvgooNeVjzvxx00PvxT6przsGKWPoQnsqKC
         FimP9cjTqCeQmDkedTpLvrmfWGmz94ucp8DH8KZGja69Wsh3YPF/DYc61w1hP77ibZ
         ECe5OEbFVCwZvjh0yA2GM4aoTMdWPAX7TtRhneMg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9VAZVYe024588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Oct 2019 05:35:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 31
 Oct 2019 05:35:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 31 Oct 2019 05:35:18 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9VAZSxE028231;
        Thu, 31 Oct 2019 05:35:29 -0500
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
To:     Felipe Balbi <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <pawell@cadence.com>
CC:     <peter.chen@nxp.com>, <nsekhar@ti.com>, <kurahul@cadence.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com> <87pnide1k7.fsf@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com>
Date:   Thu, 31 Oct 2019 12:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pnide1k7.fsf@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2019 10:55, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
>> Take into account gadget driver's speed limit when programming
>> controller speed.
>>
>> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>
>> Changelog:
>> v2
>> - Add Fixes line
>>
>>   drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 40dad4e8d0dc..1c724c20d468 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>>   {
>>   	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>   	unsigned long flags;
>> +	enum usb_device_speed max_speed = driver->max_speed;
>>   
>>   	spin_lock_irqsave(&priv_dev->lock, flags);
>>   	priv_dev->gadget_driver = driver;
>> +
>> +	/* limit speed if necessary */
>> +	max_speed = min(driver->max_speed, gadget->max_speed);
>> +
>> +	switch (max_speed) {
>> +	case USB_SPEED_FULL:
>> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> +		break;
>> +	case USB_SPEED_HIGH:
>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> +		break;
>> +	case USB_SPEED_SUPER:
>> +		break;
>> +	default:
>> +		dev_err(priv_dev->dev,
>> +			"invalid maximum_speed parameter %d\n",
>> +			max_speed);
>> +		/* fall through */
>> +	case USB_SPEED_UNKNOWN:
>> +		/* default to superspeed */
>> +		max_speed = USB_SPEED_SUPER;
>> +		break;
>> +	}
> 
> I had suggested some simplification for this case statement.
> 

oops, looks like Greg picked this already.

During more tests today I just observed that this patch causes
the following regression.

Connect EVM to Super-Speed host
Load g_audio. (this enumerates as HS which is fine)
unload g_audio
load g_zero (this enumerates at HS instead of SS).

This is because the speed limit that we set doesn't get cleared.

Now the bits are write only and there is a way to undo USB_CONF_SFORCE_FS
by writing USB_CONF_CFORCE_FS, however there is no corresponding bit
to clear USB_CONF_USB3DIS. Only way seems to be USB_CFG_SWRST which
is a bit harsh IMO.

Pawel,

could you please confirm what is the best way to undo the high-speed
limit?

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
