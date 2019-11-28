Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9457610C732
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfK1Ksb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 05:48:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfK1KsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:48:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAlwKA096714;
        Thu, 28 Nov 2019 04:47:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938078;
        bh=xsoCMaeYo5YfhzTn+vSlcz0XqN7p8MMRE1rbf+zv3po=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hok4NCldInjJBbpF9gCmiWQPM9QgU/r0FoEHrqhASoUxwBWqOv576eh9y/bC1LVPq
         GJP6tBPA+pm7Z0TroK56xFOC+z+pTUW5MgLPi6gqfR/I5w+TT/4+els9koxE7g31pK
         LxFQNfVvHjVp57A9VeHfEljtZh8mjClABnnkeGyI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASAlwCM126506
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 04:47:58 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:47:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:47:57 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAlX45098163;
        Thu, 28 Nov 2019 04:47:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 08/14] phy: cadence: Sierra: Get reset control "array" for each link
Date:   Thu, 28 Nov 2019 16:16:42 +0530
Message-ID: <20191128104648.21894-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128104648.21894-1-kishon@ti.com>
References: <20191128104648.21894-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A link may have multiple lanes each with a separate reset. Get
reset control "array" in order to reset all the lanes associated
with the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index fdca3bd178c6..497c83827670 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -499,7 +499,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		struct phy *gphy;
 
 		sp->phys[node].lnk_rst =
-			of_reset_control_get_exclusive_by_index(child, 0);
+			of_reset_control_array_get_exclusive(child);
 
 		if (IS_ERR(sp->phys[node].lnk_rst)) {
 			dev_err(dev, "failed to get reset %s\n",
-- 
2.17.1

