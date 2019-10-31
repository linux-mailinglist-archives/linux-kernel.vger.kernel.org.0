Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6CEADEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfJaKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:55:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:52219 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfJaKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:55:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 03:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="400456526"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2019 03:55:38 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org,
        pawell@cadence.com
Cc:     peter.chen@nxp.com, nsekhar@ti.com, kurahul@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
In-Reply-To: <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com>
References: <20191029151514.28495-1-rogerq@ti.com> <20191030121607.21739-1-rogerq@ti.com> <87pnide1k7.fsf@gmail.com> <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com>
Date:   Thu, 31 Oct 2019 12:55:37 +0200
Message-ID: <875zk5dw0m.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Roger Quadros <rogerq@ti.com> writes:

> Hi,
>
> On 31/10/2019 10:55, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Roger Quadros <rogerq@ti.com> writes:
>> 
>>> Take into account gadget driver's speed limit when programming
>>> controller speed.
>>>
>>> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>> ---
>>>
>>> Changelog:
>>> v2
>>> - Add Fixes line
>>>
>>>   drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>> index 40dad4e8d0dc..1c724c20d468 100644
>>> --- a/drivers/usb/cdns3/gadget.c
>>> +++ b/drivers/usb/cdns3/gadget.c
>>> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>>>   {
>>>   	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>>   	unsigned long flags;
>>> +	enum usb_device_speed max_speed = driver->max_speed;
>>>   
>>>   	spin_lock_irqsave(&priv_dev->lock, flags);
>>>   	priv_dev->gadget_driver = driver;
>>> +
>>> +	/* limit speed if necessary */
>>> +	max_speed = min(driver->max_speed, gadget->max_speed);
>>> +
>>> +	switch (max_speed) {
>>> +	case USB_SPEED_FULL:
>>> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);

so this forces the controller to FS

>>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);

and this disconnects in superspeed? What is this supposed to do?

>>> +		break;
>>> +	case USB_SPEED_HIGH:
>>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>>> +		break;
>>> +	case USB_SPEED_SUPER:
>>> +		break;
>>> +	default:
>>> +		dev_err(priv_dev->dev,
>>> +			"invalid maximum_speed parameter %d\n",
>>> +			max_speed);
>>> +		/* fall through */
>>> +	case USB_SPEED_UNKNOWN:
>>> +		/* default to superspeed */
>>> +		max_speed = USB_SPEED_SUPER;
>>> +		break;
>>> +	}
>> 
>> I had suggested some simplification for this case statement.
>> 
>
> oops, looks like Greg picked this already.
>
> During more tests today I just observed that this patch causes
> the following regression.
>
> Connect EVM to Super-Speed host
> Load g_audio. (this enumerates as HS which is fine)
> unload g_audio
> load g_zero (this enumerates at HS instead of SS).
>
> This is because the speed limit that we set doesn't get cleared.
>
> Now the bits are write only and there is a way to undo USB_CONF_SFORCE_FS
> by writing USB_CONF_CFORCE_FS, however there is no corresponding bit
> to clear USB_CONF_USB3DIS. Only way seems to be USB_CFG_SWRST which
> is a bit harsh IMO.

Isn't bit 0 enough?

/* Reset USB device configuration. */
#define USB_CONF_CFGRST		BIT(0)

Also, now that I look at this more carefully, you should move that code
to udc_set_speed().

-- 
balbi
