Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B299A34DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfH3KWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 06:22:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43352 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3KWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:22:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7UAMUsa118099;
        Fri, 30 Aug 2019 05:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567160550;
        bh=sMtdUddDm3BxWRkgzL2yPe7GjHlr/FVEJmm1oUpWeSE=;
        h=From:To:CC:Subject:Date;
        b=dJVUFId3uQGVtwlqshRRez1ix+yF9kb5Zdwa+31ahl1HbefxMGBXCExNAufc1zGi/
         hCCYLQQaUfGGwYIXtkuoJZSq6M5eHWPwx74TbV3mh3zfXGn9yp2fOed8QCqjwdsT/G
         b85mJajD8TAV2S+oLZ1g3sEa5KbARtLMZ3GU+sIc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7UAMUMl033471
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Aug 2019 05:22:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 30
 Aug 2019 05:22:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 30 Aug 2019 05:22:30 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7UAMSl6128974;
        Fri, 30 Aug 2019 05:22:28 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nsekhar@ti.com>, <bgolaszewski@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: davinci: dm365-evm: Add Fixed regulators needed for tlv320aic3101
Date:   Fri, 30 Aug 2019 13:22:52 +0300
Message-ID: <20190830102252.22488-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec driver needs correct regulators in order to probe.
Both VCC_3V3 and VCC_1V8 is always on fixed regulators on the board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 150a36f333df..2328b15ac067 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -30,6 +30,8 @@
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
 #include <linux/platform_data/ti-aemif.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -245,6 +247,19 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay	= 0	/* usec */,
 };
 
+/* Fixed regulator support */
+static struct regulator_consumer_supply fixed_supplies_3_3v[] = {
+	/* Baseboard 3.3V: 5V -> TPS767D301 -> 3.3V */
+	REGULATOR_SUPPLY("AVDD", "1-0018"),
+	REGULATOR_SUPPLY("DRVDD", "1-0018"),
+	REGULATOR_SUPPLY("IOVDD", "1-0018"),
+};
+
+static struct regulator_consumer_supply fixed_supplies_1_8v[] = {
+	/* Baseboard 1.8V: 5V -> TPS767D301 -> 1.8V */
+	REGULATOR_SUPPLY("DVDD", "1-0018"),
+};
+
 static int dm365evm_keyscan_enable(struct device *dev)
 {
 	return davinci_cfg_reg(DM365_KEYSCAN);
@@ -800,6 +815,11 @@ static __init void dm365_evm_init(void)
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
+	regulator_register_always_on(0, "fixed-dummy", fixed_supplies_1_8v,
+				     ARRAY_SIZE(fixed_supplies_1_8v), 1800000);
+	regulator_register_always_on(1, "fixed-dummy", fixed_supplies_3_3v,
+				     ARRAY_SIZE(fixed_supplies_3_3v), 3300000);
+
 	nvmem_add_cell_table(&davinci_nvmem_cell_table);
 	nvmem_add_cell_lookups(&davinci_nvmem_cell_lookup, 1);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

