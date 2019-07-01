Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C955866D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF0PyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:54:06 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:18603 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0PyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:54:05 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="36125207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 08:54:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 08:53:59 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 27 Jun 2019 08:53:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/7] clk: at91: sckc: improve error path for sam9x5 sck register
Date:   Thu, 27 Jun 2019 18:53:42 +0300
Message-ID: <1561650825-11213-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error path for sam9x5 slow clock registration.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 50 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 2a677c56f901..a2b905c91085 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -371,16 +371,17 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 	void __iomem *regbase = of_iomap(np, 0);
 	struct device_node *child = NULL;
 	const char *xtal_name;
-	struct clk_hw *hw;
+	struct clk_hw *slow_rc, *slow_osc, *slowck;
 	bool bypass;
+	int ret;
 
 	if (!regbase)
 		return;
 
-	hw = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
-					   50000000, rc_osc_startup_us,
-					   bits);
-	if (IS_ERR(hw))
+	slow_rc = at91_clk_register_slow_rc_osc(regbase, parent_names[0],
+						32768, 50000000,
+						rc_osc_startup_us, bits);
+	if (IS_ERR(slow_rc))
 		return;
 
 	xtal_name = of_clk_get_parent_name(np, 0);
@@ -388,7 +389,7 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 		/* DT backward compatibility */
 		child = of_get_compatible_child(np, "atmel,at91sam9x5-clk-slow-osc");
 		if (!child)
-			return;
+			goto unregister_slow_rc;
 
 		xtal_name = of_clk_get_parent_name(child, 0);
 		bypass = of_property_read_bool(child, "atmel,osc-bypass");
@@ -399,23 +400,36 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 	}
 
 	if (!xtal_name)
-		return;
-
-	hw = at91_clk_register_slow_osc(regbase, parent_names[1], xtal_name,
-					1200000, bypass, bits);
-	if (IS_ERR(hw))
-		return;
+		goto unregister_slow_rc;
 
-	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
-					   bits);
-	if (IS_ERR(hw))
-		return;
+	slow_osc = at91_clk_register_slow_osc(regbase, parent_names[1],
+					      xtal_name, 1200000, bypass, bits);
+	if (IS_ERR(slow_osc))
+		goto unregister_slow_rc;
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	slowck = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names,
+					       2, bits);
+	if (IS_ERR(slowck))
+		goto unregister_slow_osc;
 
 	/* DT backward compatibility */
 	if (child)
-		of_clk_add_hw_provider(child, of_clk_hw_simple_get, hw);
+		ret = of_clk_add_hw_provider(child, of_clk_hw_simple_get,
+					     slowck);
+	else
+		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, slowck);
+
+	if (WARN_ON(ret))
+		goto unregister_slowck;
+
+	return;
+
+unregister_slowck:
+	at91_clk_unregister_sam9x5_slow(slowck);
+unregister_slow_osc:
+	at91_clk_unregister_slow_osc(slow_osc);
+unregister_slow_rc:
+	at91_clk_unregister_slow_rc_osc(slow_rc);
 }
 
 static const struct clk_slow_bits at91sam9x5_bits = {
-- 
2.7.4

