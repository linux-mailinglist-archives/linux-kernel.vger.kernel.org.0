Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04340E1B83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbfJWM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:58:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52228 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404484AbfJWM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwDKq120273;
        Wed, 23 Oct 2019 07:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835493;
        bh=VhJSSgKonMP8J+UZxJu16JLCrKr2Kl8xqPLRdnV/E1E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b7Q+JfpSXY8FVjpXj+BgWjp1cgFxPW+HCCU/Ld9fW1YEC9QVHvzy+X3UjGDuQdChN
         CuaerA1RHXXbBpiA04uyIaLDvLDKdF9ft5AgGEAG0GAKjrkC1v8xueyTYKQhQ4ddjy
         c9P7BLWO0cFKfzWPCoq1KrZNAnUfnFYkiAGOXYCM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwDE6042371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:02 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o6061147;
        Wed, 23 Oct 2019 07:58:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 02/14] phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional resources
Date:   Wed, 23 Oct 2019 18:27:23 +0530
Message-ID: <20191023125735.4713-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain platforms like TI J721E using Cadence Sierra Serdes
doesn't provide explicit phy_clk and reset (APB reset) control.
Make them optional here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index de10402f2931..bed68c25682f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -193,7 +193,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	sp->clk = devm_clk_get(dev, "phy_clk");
+	sp->clk = devm_clk_get_optional(dev, "phy_clk");
 	if (IS_ERR(sp->clk)) {
 		dev_err(dev, "failed to get clock phy_clk\n");
 		return PTR_ERR(sp->clk);
@@ -205,7 +205,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(sp->phy_rst);
 	}
 
-	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
+	sp->apb_rst = devm_reset_control_get_optional(dev, "sierra_apb");
 	if (IS_ERR(sp->apb_rst)) {
 		dev_err(dev, "failed to get apb reset\n");
 		return PTR_ERR(sp->apb_rst);
-- 
2.17.1

