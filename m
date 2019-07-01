Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA304227B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfFLK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 06:29:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44122 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfFLK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:29:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CATm2X040369;
        Wed, 12 Jun 2019 05:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560335388;
        bh=ivsc2x+9Cpl6a1E43O1kQ1pwGbkzvrUAuWeBZqbf3o4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qmn73KdFoZaYqSzzP0oL4UxSgyZ/LFJyrGDQOaSZ1UQuyIBuAThg1Iy+ibWtrDKyY
         fgKa6BygTZ3R0bukqK/UppJ6XlQFAP6A7JqW02RmanRM0qLog8B/RKF83eYdJyDhlr
         R5bs88mmIZSfhCRQnGI/LD9KEJ1kJbyq9uojQpGU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CATmdK089701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:29:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:29:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:29:48 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CATTJZ128310;
        Wed, 12 Jun 2019 05:29:44 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal
Date:   Wed, 12 Jun 2019 15:58:00 +0530
Message-ID: <20190612102803.25398-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612102803.25398-1-kishon@ti.com>
References: <20190612102803.25398-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

We are not destroying the sysfs attribute groupe we registered during
the probe function which will make subsequent probe calls to that
driver fail. Correct that with adding a remove function which only
removes those attributes since the reference counting on clocks did its
job already.

Fixes: 415060b21f31 ("phy: usb: phy-brcm-usb: Add ability to force DRD mode to host or device")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index f59b1dc30399..292d5b3fc66c 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -376,6 +376,13 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static int brcm_usb_phy_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &brcm_usb_phy_group);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int brcm_usb_phy_suspend(struct device *dev)
 {
@@ -441,6 +448,7 @@ MODULE_DEVICE_TABLE(of, brcm_usb_dt_ids);
 
 static struct platform_driver brcm_usb_driver = {
 	.probe		= brcm_usb_phy_probe,
+	.remove		= brcm_usb_phy_remove,
 	.driver		= {
 		.name	= "brcmstb-usb-phy",
 		.owner	= THIS_MODULE,
-- 
2.17.1

