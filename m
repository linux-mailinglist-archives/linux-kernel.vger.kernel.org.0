Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8B4227D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfFLK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 06:29:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFLK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:29:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CATu8q062201;
        Wed, 12 Jun 2019 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560335396;
        bh=m/camuLRbAZ3IcPBA6b6JbT9L7ibhWAGZHCG5yYnaN8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gwINgRPMtHskh4fiPpi4Szu533q8OgZGgXX8wGXbMkPTuVVgJtmHd4mC89s9CHwbe
         lpSjPTk2Kt5tLvXl2h0ohpKfsE20ka4dkmO5BKxH7STJlxuguIqnr0bGG5wrs262gp
         b/4S/83ZUDYPNPa22o4RAWZHHdnkuQB7R0OzsVj4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CATu9Z085435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:29:56 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:29:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:29:56 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CATTJb128310;
        Wed, 12 Jun 2019 05:29:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] phy: tegra: xusb: Add Tegra124 PLL power supplies
Date:   Wed, 12 Jun 2019 15:58:02 +0530
Message-ID: <20190612102803.25398-6-kishon@ti.com>
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

From: Thierry Reding <treding@nvidia.com>

The Tegra124 SoC has four inputs that consume power in order to supply
the PLLs that drive the various USB, PCI and SATA pads.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/tegra/xusb-tegra124.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra124.c b/drivers/phy/tegra/xusb-tegra124.c
index c45cbedc6634..254592c47b00 100644
--- a/drivers/phy/tegra/xusb-tegra124.c
+++ b/drivers/phy/tegra/xusb-tegra124.c
@@ -1721,6 +1721,13 @@ static const struct tegra_xusb_padctl_ops tegra124_xusb_padctl_ops = {
 	.hsic_set_idle = tegra124_hsic_set_idle,
 };
 
+static const char * const tegra124_xusb_padctl_supply_names[] = {
+	"avdd-pll-utmip",
+	"avdd-pll-erefe",
+	"avdd-pex-pll",
+	"hvdd-pex-pll-e",
+};
+
 const struct tegra_xusb_padctl_soc tegra124_xusb_padctl_soc = {
 	.num_pads = ARRAY_SIZE(tegra124_pads),
 	.pads = tegra124_pads,
@@ -1743,6 +1750,8 @@ const struct tegra_xusb_padctl_soc tegra124_xusb_padctl_soc = {
 		},
 	},
 	.ops = &tegra124_xusb_padctl_ops,
+	.supply_names = tegra124_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra124_xusb_padctl_supply_names),
 };
 EXPORT_SYMBOL_GPL(tegra124_xusb_padctl_soc);
 
-- 
2.17.1

