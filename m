Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559D2147A55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 10:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgAXJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 04:23:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46790 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:23:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00O9NIeA077545;
        Fri, 24 Jan 2020 03:23:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579857799;
        bh=PKLdQgBAWNuEFj6zeHDzEvtdhk+JONPJ53CQRbLkK7o=;
        h=From:To:CC:Subject:Date;
        b=qB2R50uM8lvgd9HrgAw1crklWgJ/1JeTDp2i4GFDVFeXJb3XmerFA9esw/q3h5yCj
         mWzp3YJ7OxErIGUTiTiz0gdxfaSAOIoCdBBkv/+3naDSnrp5vIQ47QUD8HTv/SPtfv
         MuoLB4Y49JXvqNIL0bxTX8v1aeuy2dlQLVojVVFA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00O9NIYU045144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 03:23:18 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 03:23:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 03:23:18 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O9NF73007440;
        Fri, 24 Jan 2020 03:23:16 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <olof@lixom.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <vkoul@kernel.org>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <soc@kernel.org>
Subject: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
Date:   Fri, 24 Jan 2020 11:23:59 +0200
Message-ID: <20200124092359.12429-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDMA driver is used on K3 platforms (am654 and j721e).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

The drivers for UDMA are already in linu-next and the DT patches are going to be
also heading for 5.6.
The only missing piece is to enable the drivers in defconfig so clients can use
the DMA.

Regards,
Peter

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4631a1190719..a325a296d94c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -698,6 +698,7 @@ CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
 CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=m
+CONFIG_TI_K3_UDMA=y
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

