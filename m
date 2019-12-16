Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4A21201B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLPJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 04:56:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36400 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfLPJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uVDa129936;
        Mon, 16 Dec 2019 03:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490191;
        bh=HnvQVBmnp47FnJbchzKE+jfH8rWFeTqVgl7/AlfabmE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kmr3hKE0R27FjGau+nVOg+fS7q0Xg8r4yGUeCBTvQiml7/JszRaGiZ+I63/IY8FoL
         SasKO9DJYOatYC+avVngk9o6IiHom1W40Q8QxsTuKsTxrrQF6IRTblTpsAiiQR2DJJ
         cuSBPJRwOSRs81naaIZu5RJv751zsexwyb7G4zz0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uVWu038426;
        Mon, 16 Dec 2019 03:56:31 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:31 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJV084408;
        Mon, 16 Dec 2019 03:56:28 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 12/14] phy: cadence: Sierra: Use correct dev pointer in cdns_sierra_phy_remove()
Date:   Mon, 16 Dec 2019 15:27:10 +0530
Message-ID: <20191216095712.13266-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 44d30d622821d3b ("phy: cadence: Add driver for Sierra PHY"),
incorrectly used parent device pointer to get driver data. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 82466d0e9b38..eb87f1a0a596 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -625,7 +625,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 static int cdns_sierra_phy_remove(struct platform_device *pdev)
 {
-	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+	struct cdns_sierra_phy *phy = platform_get_drvdata(pdev);
 	int i;
 
 	reset_control_assert(phy->phy_rst);
-- 
2.17.1

