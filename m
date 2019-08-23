Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC019AABC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393233AbfHWIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:53:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389120AbfHWIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:53:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7N8rL2n039346;
        Fri, 23 Aug 2019 03:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566550401;
        bh=AygYke9eev/ace09mklN8ehfRR+GaHjHMEoeOSlv2ko=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RuDlomvHA+ozFBm2seWvqjWHsD4d5bUc8SLiA3BbFf31RdvtoNgulPq4c/Hy6faz8
         gWSFWMsgTBvBYyRe+Qzd1l92xIRKzwbVpP2r7ViAAkjvDlrjhus7mpEUfE9HT8O8Ry
         dfT0y1b+FY5K0YOhYcWyODGZ1n3qnHyy4JSuDC3s=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7N8rLhh112033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 03:53:21 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 03:53:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 03:53:21 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7N8rGdo010932;
        Fri, 23 Aug 2019 03:53:16 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c5067780-9dfe-2a3e-3498-22f3c1dadb87@ti.com>
Date:   Fri, 23 Aug 2019 14:23:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563733939-21214-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/07/19 12:02 AM, Pawel Laszczak wrote:
> +
> +/**
> + * cdns3_req_ep0_get_status - Handling of GET_STATUS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
> +				    struct usb_ctrlrequest *ctrl)
> +{
> +	__le16 *response_pkt;
> +	u16 usb_status = 0;
> +	u32 recip;
> +	u32 reg;
> +
> +	recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recip) {
> +	case USB_RECIP_DEVICE:
> +		/* self powered */
> +		if (priv_dev->is_selfpowered)
> +			usb_status = BIT(USB_DEVICE_SELF_POWERED);
> +
> +		if (priv_dev->wake_up_flag)
> +			usb_status |= BIT(USB_DEVICE_REMOTE_WAKEUP);
> +
> +		if (priv_dev->gadget.speed != USB_SPEED_SUPER)
> +			break;
> +
> +		reg = readl(&priv_dev->regs->usb_sts);

I see usb_sts is read, but never used in this function?

> +
> +		if (priv_dev->u1_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U1_ENABLED);
> +
> +		if (priv_dev->u2_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U2_ENABLED);
> +
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		return cdns3_ep0_delegate_req(priv_dev, ctrl);
> +	case USB_RECIP_ENDPOINT:
> +		/* check if endpoint is stalled */
> +		cdns3_select_ep(priv_dev, ctrl->wIndex);
> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +			usb_status =  BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	response_pkt = (__le16 *)priv_dev->setup_buf;
> +	*response_pkt = cpu_to_le16(usb_status);
> +
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +			       sizeof(*response_pkt), 1, 0);
> +	return 0;
> +}
> +

-- 
Regards
Vignesh
