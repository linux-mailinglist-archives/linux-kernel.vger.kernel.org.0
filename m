Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DEDBB76A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfIWPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 11:01:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43755 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727515AbfIWPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:01:16 -0400
Received: (qmail 27837 invoked by uid 500); 23 Sep 2019 11:01:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2019 11:01:15 -0400
Date:   Mon, 23 Sep 2019 11:01:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub add filter for device with specific VID&PID
In-Reply-To: <20190923105102.37413-1-ran.wang_1@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1909231059260.24712-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Ran Wang wrote:

> USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT "Unsupported
> Device" Message require to stop enumerating device with VID=0x1a0a PID=0x0201
> and pop message to declare this device is not supported.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/core/hub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bbcfa63..3cda0da 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4982,6 +4982,18 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  		if (status < 0)
>  			goto loop;
>  
> +		 /* USB 2.0 Embedded Host PET Automated Test (CH6)
> +		 * 6.7.23 A-UUT "Unsupported Device" Message
> +		 * require to filter out below device when enumeration
> +		 */
> +		if ((udev->descriptor.idVendor == 0x1a0a)
> +		 && (udev->descriptor.idProduct == 0x0201)) {
> +			dev_err(&udev->dev, "This device is not supported: idVendor=0x%x idProduct=0x%x\n",
> +				udev->descriptor.idVendor,
> +				udev->descriptor.idProduct);

There's no need to write out the Vendor and Product IDs.  They already 
appear in the "New device" message.

> +			goto done;
> +		}
> +
>  		if (udev->quirks & USB_QUIRK_DELAY_INIT)
>  			msleep(2000);

Shouldn't this be implemented as a device quirk?

Alan Stern

