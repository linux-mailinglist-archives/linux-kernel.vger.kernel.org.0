Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E443122964
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQLAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:00:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:00:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHB0IeJ024842;
        Tue, 17 Dec 2019 05:00:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576580418;
        bh=WFu2bhCsbcS8Ji82jkf6TOz+cf1OP42p/0gNDCCLLiE=;
        h=From:To:CC:Subject:Date;
        b=hN2EmYI6fo8B+cctFerAaiz7Y/5cT2kRgVpERx3LSNeWW4epYL0YwV/pZMYGwr4TJ
         Mwv4wO71mEDxsAefEvsP2Svv9lFkUNKEOxi9goTj9YJ5hL3WRWDzWl85p6GcPrqZgq
         LnmWA8VrF0W8LG9Xz4YULh2hPMrH2W+MSfU3Mufc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHB0I3D080597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 05:00:18 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:00:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:00:17 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHB0F7x038240;
        Tue, 17 Dec 2019 05:00:16 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>
CC:     <vkoul@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: musb/ux500: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:00:30 +0200
Message-ID: <20191217110030.26887-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/usb/musb/ux500_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index d19bb3e89da6..d5cf5e8bb1ca 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -310,9 +310,9 @@ static int ux500_dma_controller_start(struct ux500_dma_controller *controller)
 			dma_channel->max_len = SZ_16M;
 
 			ux500_channel->dma_chan =
-				dma_request_slave_channel(dev, chan_names[ch_num]);
+				dma_request_chan(dev, chan_names[ch_num]);
 
-			if (!ux500_channel->dma_chan)
+			if (IS_ERR(ux500_channel->dma_chan))
 				ux500_channel->dma_chan =
 					dma_request_channel(mask,
 							    data ?
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

