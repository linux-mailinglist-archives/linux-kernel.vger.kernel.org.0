Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9A6CCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbfGRKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 06:25:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45702 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfGRKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:25:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7F532000C0;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB3B72000AF;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 22673205C7;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, =kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/3] firmware: imx: scu-pd: Rename mu PD range to mu_a
Date:   Thu, 18 Jul 2019 13:25:17 +0300
Message-Id: <20190718102519.31855-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718102519.31855-1-daniel.baluta@nxp.com>
References: <20190718102519.31855-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Messaging Unit module enables two processors within the SoC to
communicate and coordinate by passing messages through the MU interface.

MUs have 2 “sides” with independent programming interfaces. Rename
mu PD range to mu_a because it's actually side A of MUs.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 480cec69e2c9..950d30238186 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -92,7 +92,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "gpt", IMX_SC_R_GPT_0, 5, true, 0 },
 	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
 	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
-	{ "mu", IMX_SC_R_MU_0A, 14, true, 0 },
+	{ "mu_a", IMX_SC_R_MU_0A, 14, true, 0 },
 
 	/* CONN SS */
 	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
-- 
2.17.1

