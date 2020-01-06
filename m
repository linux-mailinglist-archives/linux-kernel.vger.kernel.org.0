Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EE13128C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 14:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAFNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 08:06:34 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41922 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006D6UtI036301;
        Mon, 6 Jan 2020 07:06:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578315990;
        bh=SyE3xMynqYNACOtAeuIqDSqo2RVFVogptaaKr0W5Olk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E/tMGAu69GCP/izXT8mK21qg35DZpKP4BlP9J0PEHEC77/VqoHzFdT30C9+xHxPpV
         /3iB6XWefNcKsE4TngbTwxdTFa5GO/I0xFDt/h6gld3y12LX9zb8sPyfYv6FWoYjS8
         NFNZ9DWrWxFTHUHceBr8rLt26g0XyTeeHfMFfzcY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006D6Ujn014348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 07:06:30 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 07:06:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 07:06:30 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D6PkH089522;
        Mon, 6 Jan 2020 07:06:28 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 1/3] phy: cadence: Sierra: add phy_reset hook
Date:   Mon, 6 Jan 2020 15:06:20 +0200
Message-ID: <20200106130622.29703-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106130622.29703-1-rogerq@ti.com>
References: <20200106130622.29703-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms e.g. J721e need lane swap register
to be programmed before reset is deasserted.
This patch ensures that we propagate the phy_reset
back to the reset controller driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index eb87f1a0a596..a66bea4c557f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -341,10 +341,20 @@ static int cdns_sierra_phy_off(struct phy *gphy)
 	return reset_control_assert(ins->lnk_rst);
 }
 
+static int cdns_sierra_phy_reset(struct phy *gphy)
+{
+	struct cdns_sierra_phy *sp = dev_get_drvdata(gphy->dev.parent);
+
+	reset_control_assert(sp->phy_rst);
+	reset_control_deassert(sp->phy_rst);
+	return 0;
+};
+
 static const struct phy_ops ops = {
 	.init		= cdns_sierra_phy_init,
 	.power_on	= cdns_sierra_phy_on,
 	.power_off	= cdns_sierra_phy_off,
+	.reset		= cdns_sierra_phy_reset,
 	.owner		= THIS_MODULE,
 };
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

