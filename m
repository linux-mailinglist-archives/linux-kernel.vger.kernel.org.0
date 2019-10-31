Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C407FEABF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 09:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJaIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 04:55:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:45690 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfJaIz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 01:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="190558319"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2019 01:55:53 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org
Cc:     pawell@cadence.com, peter.chen@nxp.com, nsekhar@ti.com,
        kurahul@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
In-Reply-To: <20191030121607.21739-1-rogerq@ti.com>
References: <20191029151514.28495-1-rogerq@ti.com> <20191030121607.21739-1-rogerq@ti.com>
Date:   Thu, 31 Oct 2019 10:55:52 +0200
Message-ID: <87pnide1k7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Roger Quadros <rogerq@ti.com> writes:

> Take into account gadget driver's speed limit when programming
> controller speed.
>
> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Peter Chen <peter.chen@nxp.com>
> ---
>
> Changelog:
> v2
> - Add Fixes line
>
>  drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 40dad4e8d0dc..1c724c20d468 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>  {
>  	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>  	unsigned long flags;
> +	enum usb_device_speed max_speed = driver->max_speed;
>  
>  	spin_lock_irqsave(&priv_dev->lock, flags);
>  	priv_dev->gadget_driver = driver;
> +
> +	/* limit speed if necessary */
> +	max_speed = min(driver->max_speed, gadget->max_speed);
> +
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_HIGH:
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_SUPER:
> +		break;
> +	default:
> +		dev_err(priv_dev->dev,
> +			"invalid maximum_speed parameter %d\n",
> +			max_speed);
> +		/* fall through */
> +	case USB_SPEED_UNKNOWN:
> +		/* default to superspeed */
> +		max_speed = USB_SPEED_SUPER;
> +		break;
> +	}

I had suggested some simplification for this case statement.

-- 
balbi
