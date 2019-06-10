Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB13AE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfFJFez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 01:34:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35512 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbfFJFey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:34:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 283922006F3;
        Mon, 10 Jun 2019 07:34:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A95312006ED;
        Mon, 10 Jun 2019 07:34:46 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 78C39402D2;
        Mon, 10 Jun 2019 13:34:38 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, l.stach@pengutronix.de, ccaione@baylibre.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clk: imx: Remove __init for imx_check_clocks() API
Date:   Mon, 10 Jun 2019 13:36:33 +0800
Message-Id: <20190610053634.14339-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Some of i.MX SoCs' clock driver use platform driver model,
and they need to call imx_check_clocks() API, so
imx_check_clocks() API should NOT be in .init section.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9cd7097..b1416b2 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -23,7 +23,7 @@ void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
 	writel_relaxed(reg, ccm_base + CCM_CCDR);
 }
 
-void __init imx_check_clocks(struct clk *clks[], unsigned int count)
+void imx_check_clocks(struct clk *clks[], unsigned int count)
 {
 	unsigned i;
 
-- 
2.7.4

