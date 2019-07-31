Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A47C90B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfGaQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:43:37 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55476 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfGaQng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:43:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3E805FB05;
        Wed, 31 Jul 2019 18:43:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DuVvq0P8aW1u; Wed, 31 Jul 2019 18:43:33 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6F50746D8B; Wed, 31 Jul 2019 18:43:31 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] reset: imx7: Fix IMX8MQ_RESET_MIPI_DSI_ defines
Date:   Wed, 31 Jul 2019 18:43:31 +0200
Message-Id: <bd1504122f6797536a253a37f3604f5c46f02ab2.1564591352.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564591352.git.agx@sigxcpu.org>
References: <cover.1564591352.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the mipi dsi resets were called

  IMX8MQ_RESET_MIPI_DIS_

instead of

  IMX8MQ_RESET_MIPI_DSI_

Since they're DSI related this looks like a typo.

I wasn't sure if this should be a single patch since it otherwise breaks
bisectability. I couldn't find any device trees using this yet.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/reset/reset-imx7.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 3ecd770f910b..1443a55a0c29 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -169,9 +169,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
 	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
 	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
-	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
-	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
-	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
+	[IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
+	[IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
 	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
 						    BIT(2) | BIT(1) },
 	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
@@ -220,9 +220,9 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 
 	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
 	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
 	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
 	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
 		value = assert ? 0 : bit;
-- 
2.20.1

