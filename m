Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00EB10C726
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 11:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfK1KsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 05:48:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33140 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfK1KsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:48:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAm3t8019551;
        Thu, 28 Nov 2019 04:48:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938083;
        bh=uk33OX2/IRV4qk5zeJOpsDKsk+aZEVFfOmbpkxiarpY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ELP+WsRYhYM4ZjZqM86jEMcvGcEkGvCyTpgDDJzP2xlBUI3EaUtBplUnk75bHAbx7
         s5tHceJAnmIFopgvxM3BhEoQtJO40UU53KuFSYUYpEFXU5yzi6QGtufeVh/OQ7yzOk
         R7rVYs5HQ317PpqfpBWjFRNdLhlKBAjFGTrSdWXQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASAm3o6015324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 04:48:03 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:48:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:48:03 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAlX47098163;
        Thu, 28 Nov 2019 04:48:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 10/14] phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
Date:   Thu, 28 Nov 2019 16:16:44 +0530
Message-ID: <20191128104648.21894-11-kishon@ti.com>
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

Sierra SERDES IP supports upto 16 lanes (though not all of it
will be enabled in a platform). Allow Sierra driver to support a
maximum of upto 16 lanes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 62bff4b043f0..665a6dbc7816 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -141,7 +141,7 @@
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
-#define SIERRA_MAX_LANES				4
+#define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
 static const struct reg_field macro_id_type =
@@ -199,6 +199,7 @@ struct cdns_sierra_phy {
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
 	int nsubnodes;
+	u32 num_lanes;
 	bool autoconf;
 };
 
@@ -235,6 +236,18 @@ static struct regmap_config cdns_sierra_lane_cdb_config[] = {
 	SIERRA_LANE_CDB_REGMAP_CONF("1"),
 	SIERRA_LANE_CDB_REGMAP_CONF("2"),
 	SIERRA_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_LANE_CDB_REGMAP_CONF("15"),
 };
 
 static struct regmap_config cdns_sierra_common_cdb_config = {
@@ -548,6 +561,8 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 			}
 		}
 
+		sp->num_lanes += sp->phys[node].num_lanes;
+
 		gphy = devm_phy_create(dev, child, &ops);
 
 		if (IS_ERR(gphy)) {
@@ -561,6 +576,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 	sp->nsubnodes = node;
 
+	if (sp->num_lanes > SIERRA_MAX_LANES) {
+		dev_err(dev, "Invalid lane configuration\n");
+		goto put_child2;
+	}
+
 	/* If more than one subnode, configure the PHY as multilink */
 	if (!sp->autoconf && sp->nsubnodes > 1)
 		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
-- 
2.17.1

