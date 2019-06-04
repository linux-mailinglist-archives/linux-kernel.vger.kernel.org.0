Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552EB3409C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfFDHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:46:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51672 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:46:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x547kG9S007930;
        Tue, 4 Jun 2019 02:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559634376;
        bh=UpgmdeZyCTRIwhuCuN32EY5nvq17K3TOta5SIK7paXY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AhznUoab3S89GGZ6N2WWwEGRLlDH429QSWHzDrufkfHAmSI37dtQ6rUNefzvIsVEL
         Y+600RHZvALUOYtwvm99WCWPIvfVjuWm1plhECrorBnTnGGDXcUKlEDPSZwah1HcGN
         2UpWw/Cz2IULZtwzreL0VlIhkWTGRGHkSbQ6dR2g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x547kGvN045289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 02:46:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 02:46:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 02:46:15 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x547k9fZ035276;
        Tue, 4 Jun 2019 02:46:10 -0500
Subject: Re: [PATCH v6 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <kurahul@cadence.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-6-git-send-email-pawell@cadence.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b768bde9-d6c8-f655-aecb-d08bcb9286a6@ti.com>
Date:   Tue, 4 Jun 2019 13:16:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1554882504-9010-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/19 1:18 PM, Pawel Laszczak wrote:
> +static void cdns3_wa1_tray_restore_cycle_bit(struct cdns3_device *priv_dev,
> +					     struct cdns3_endpoint *priv_ep)
> +{
> +	int dma_index;
> +	u32 doorbell;
> +
> +	doorbell = !!(readl(&priv_dev->regs->ep_cmd) & EP_CMD_DRDY);

> +	dma_index = (readl(&priv_dev->regs->ep_traddr) -
> +		    priv_ep->trb_pool_dma) / TRB_SIZE;

This gets upgraded to 64-bit by 64-bit division whenever dma_addr_t is 
64-bit. That should be avoided. Following diff should fix it. 
But please review the logic itself. You are subtracting a 64 bit entity 
from a 32-bit entity. What is guaranteeing that priv_ep->trb_pool_dma is 
32-bit?

There is one more instance of same issue in cdns3_request_handled().

Thanks,
Sekhar

[1]
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index bfd5dbf40c7e..e73b618501fb 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -749,8 +749,8 @@ static void cdns3_wa1_tray_restore_cycle_bit(struct cdns3_device *priv_dev,
 	u32 doorbell;
 
 	doorbell = !!(readl(&priv_dev->regs->ep_cmd) & EP_CMD_DRDY);
-	dma_index = (readl(&priv_dev->regs->ep_traddr) -
-		    priv_ep->trb_pool_dma) / TRB_SIZE;
+	dma_index = readl(&priv_dev->regs->ep_traddr) - priv_ep->trb_pool_dma;
+	dma_index /= TRB_SIZE;
