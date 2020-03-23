Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90318FA50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCWQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgCWQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:48:36 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D93920714;
        Mon, 23 Mar 2020 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584982115;
        bh=t8+x687h2Ketf0pGWNaRxGnJrESZWVY7p63yvqMYPcM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zFVnTv2dS1Tg5JfraLPTE+MnQnCsQxdse6y2O4IejG0xNRSzHWKp8Ru4e2lvCdoSZ
         hHq5cWtW8qN+TtKWGf0PcOaAWLOC4s7/FkxzgKWQ7dZzVodo2+2oBNFRoOngyobAri
         jQ5c/U1mw2NKNYDXmxvLKKEyTT6uB23Ki3pZzWt0=
Subject: Re: [PATCH] usbip: vhci_hcd: slighly simplify code in
 'vhci_urb_dequeue()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200321152938.19580-1-christophe.jaillet@wanadoo.fr>
From:   shuah <shuah@kernel.org>
Message-ID: <c8e319c8-cd65-2c2c-df5d-e75908ca63b7@kernel.org>
Date:   Mon, 23 Mar 2020 10:48:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200321152938.19580-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/20 9:29 AM, Christophe JAILLET wrote:
> The allocation of 'unlink' can be moved before a spin_lock.
> This slighly simplifies the error handling if the memory allocation fails,

slightly (spelling nit)

> aligns the code structure with what is done in 'vhci_tx_urb()' and reduces
> potential lock contention.
> 

Are you seeing any problems or is this a potential lock contention?
If you are seeing issues, please share the problem seen.


> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 65850e9c7190..b909a634260c 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -905,17 +905,16 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>   		/* tcp connection is alive */
>   		struct vhci_unlink *unlink;
>   
> -		spin_lock(&vdev->priv_lock);
> -

This change might simplify the error path, however it could
open a race window with the unlink activity during 
vhci_shutdown_connection() when the connection is being taken
down. It would be safer to hold both locks as soon as the
connection check is done.

>   		/* setup CMD_UNLINK pdu */
>   		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
>   		if (!unlink) {
> -			spin_unlock(&vdev->priv_lock);
>   			spin_unlock_irqrestore(&vhci->lock, flags);
>   			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
>   			return -ENOMEM;
>   		}
>   
> +		spin_lock(&vdev->priv_lock);
> +
>   		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
>   		if (unlink->seqnum == 0xffff)
>   			pr_info("seqnum max\n");
> 

thanks,
-- Shuah
