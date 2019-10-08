Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27487CF870
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfJHLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 07:34:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35657 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730683AbfJHLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:34:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C46B221AF1;
        Tue,  8 Oct 2019 07:34:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=IomXpyVOXZ8Uv
        1dPMisUUdf86QeS1crpf/LOXGB55i0=; b=dIgBzducLtm3bjO9Leg5vJzPwNDZA
        tD3kxhrpI+XDTH4bNxgAYJb23dsHyzJQAp39K5TEMP5ilJjObK5wkBZSHea6mEwh
        7sHbTuw0IAUCD1bwZ1sJpvgpa0qYvcuWrdhkEFw6/NMXuDHmLuiaCtGj+JwZtTrq
        +RLvW1+ampAFaghMuHzTuFTVAxdzW7XBGTLGT2AAAEmzZSa9zuMdsXpXlZr2Ntfh
        Fd/iPM+vS2aE2HyFSvVmAggOcYYcrK9hoZ/Xf6VEsgvyyWJEA7uAIX0NenHQ65Gr
        xr/AvWCpg/ayCkerE0ULc8NwwIU9Ri774XG4V8zsF+g53MJ1HkQUy3lFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=IomXpyVOXZ8Uv1dPMisUUdf86QeS1crpf/LOXGB55i0=; b=Mvlrt3Tc
        WpZePURq8P27c6YFdUo8xibi6zt7wN4rHEOGaZEThpmYXOiSpyrQa234C8KBcsf5
        DgzLwtorIZykfr+ZrPFz6vOrwuY6+8nMBdvZErHf19D5eYt6vq7kebUz6QVq1Rv5
        0gFDl6jekAXvkUMRc1DuqVe36k1q8LKQeo1k3Su0xPRz/AccWukw4wgYqtee9C+U
        tG7Uy+v6Rex3bJeqGLLF1IBIQzSxIpZvq8ruFLUvHfM/1CK1BwdLF4ywOA8d6kJv
        Xv0LYoF+3sdy+OwQjj77YBj975e8TwaH6DsW1GOovL0EVm+Atm1ecshlX16GHqga
        SKKp4f1l0lEA8w==
X-ME-Sender: <xms:R3ScXXewqj993nwdvy0W9R9zdTXZH7uZcxxC2q5SIwlY4z4uVXXRsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepud
X-ME-Proxy: <xmx:R3ScXU1dR1Bwcvkr4RpIDdfRxdiSD7XOcELq7uR29_Pj-uiIrQCPRA>
    <xmx:R3ScXX72jGXhSp9et4Ozz8fLijIADE2FOAGkly9RVWGnVmCZpibj2g>
    <xmx:R3ScXTcVyfIMYvYIORliDqx3idVHfkqApo0sKBaavfyGMizkx1Sgvw>
    <xmx:R3ScXfojpt_Rnuw48x2uiNvV2OK7aeA6NrKTls2tfOWU6JiXlw_g3A>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1EBCD6005B;
        Tue,  8 Oct 2019 07:34:27 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
Date:   Tue,  8 Oct 2019 22:05:23 +1030
Message-Id: <20191008113523.13601-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008113523.13601-1-andrew@aj.id.au>
References: <20191008113523.13601-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCLK is a fixed 50MHz clock derived from HPLL that is described by a
single gate for each MAC.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/clk/clk-aspeed.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index abf06fb6453e..867d8771bb1e 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -14,7 +14,7 @@
 
 #include "clk-aspeed.h"
 
-#define ASPEED_NUM_CLKS		36
+#define ASPEED_NUM_CLKS		38
 
 #define ASPEED_RESET2_OFFSET	32
 
@@ -28,6 +28,7 @@
 #define  AST2400_HPLL_BYPASS_EN	BIT(17)
 #define ASPEED_MISC_CTRL	0x2c
 #define  UART_DIV13_EN		BIT(12)
+#define ASPEED_MAC_CLK_DLY	0x48
 #define ASPEED_STRAP		0x70
 #define  CLKIN_25MHZ_EN		BIT(23)
 #define  AST2400_CLK_SOURCE_SEL	BIT(18)
@@ -462,6 +463,30 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_MAC] = hw;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-scu")) {
+		/* RMII 50MHz RCLK */
+		hw = clk_hw_register_fixed_rate(dev, "mac12rclk", "hpll", 0,
+						50000000);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		/* RMII1 50MHz (RCLK) output enable */
+		hw = clk_hw_register_gate(dev, "mac1rclk-gate", "mac12rclk", 0,
+				scu_base + ASPEED_MAC_CLK_DLY, 29, 0,
+				&aspeed_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+		aspeed_clk_data->hws[ASPEED_CLK_GATE_MAC1RCLK] = hw;
+
+		/* RMII2 50MHz (RCLK) output enable */
+		hw = clk_hw_register_gate(dev, "mac2rclk-gate", "mac12rclk", 0,
+				scu_base + ASPEED_MAC_CLK_DLY, 30, 0,
+				&aspeed_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+		aspeed_clk_data->hws[ASPEED_CLK_GATE_MAC2RCLK] = hw;
+	}
+
 	/* LPC Host (LHCLK) clock divider */
 	hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
 			scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
-- 
2.20.1

