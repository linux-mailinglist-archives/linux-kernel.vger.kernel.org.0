Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6F187792
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 02:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgCQBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 21:44:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37080 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgCQBoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:44:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B173C1A0CD2;
        Tue, 17 Mar 2020 02:44:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0661F1A0CD1;
        Tue, 17 Mar 2020 02:44:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C659402C4;
        Tue, 17 Mar 2020 09:44:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx8m: No need to put node when of_find_compatible_node() failed
Date:   Tue, 17 Mar 2020 09:37:33 +0800
Message-Id: <1584409053-23116-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to put node when of_find_compatible_node() failed, return
immediately to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 719e1f18..7b0759a 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -53,11 +53,11 @@ static u32 __init imx8mq_soc_revision(void)
 	struct device_node *np;
 	void __iomem *ocotp_base;
 	u32 magic;
-	u32 rev = 0;
+	u32 rev;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
-		goto out;
+		return 0;
 
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
@@ -78,9 +78,8 @@ static u32 __init imx8mq_soc_revision(void)
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
 	iounmap(ocotp_base);
-
-out:
 	of_node_put(np);
+
 	return rev;
 }
 
-- 
2.7.4

