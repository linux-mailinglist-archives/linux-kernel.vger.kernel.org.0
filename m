Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6802E12AA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 07:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLZGnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 01:43:20 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59600 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfLZGnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 01:43:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 32426200130;
        Thu, 26 Dec 2019 07:43:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49CD620034B;
        Thu, 26 Dec 2019 07:43:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 05B6B402B3;
        Thu, 26 Dec 2019 14:43:06 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: Add i.MX8MP SoC driver support
Date:   Thu, 26 Dec 2019 14:40:02 +0800
Message-Id: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MP SoC driver support:

root@imx8mpevk:~# cat /sys/devices/soc0/family
Freescale i.MX

root@imx8mpevk:~# cat /sys/devices/soc0/machine
FSL i.MX8MP EVK

root@imx8mpevk:~# cat /sys/devices/soc0/soc_id
i.MX8MP

root@imx8mpevk:~# cat /sys/devices/soc0/revision
1.0

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 964ff84..719e1f18 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -142,10 +142,16 @@ static const struct imx8_soc_data imx8mn_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };
 
+static const struct imx8_soc_data imx8mp_soc_data = {
+	.name = "i.MX8MP",
+	.soc_revision = imx8mm_soc_revision,
+};
+
 static const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
+	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
 	{ }
 };
 
-- 
2.7.4

