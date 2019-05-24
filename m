Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2252829081
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfEXFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 01:49:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54904 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388232AbfEXFtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:49:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 052572000AC;
        Fri, 24 May 2019 07:49:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 19B9D200088;
        Fri, 24 May 2019 07:49:12 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C1288402D6;
        Fri, 24 May 2019 13:49:05 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hyc.nju@gmail.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 2/2] soc: imx: soc-imx8: Correct return value of error handle
Date:   Fri, 24 May 2019 13:51:01 +0800
Message-Id: <20190524055101.3424-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524055101.3424-1-Anson.Huang@nxp.com>
References: <20190524055101.3424-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Current implementation of i.MX8 SoC driver returns -ENODEV
for all cases of error during initialization, this is incorrect.
This patch fixes them using correct return value according
to different errors.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index d5badde..2183edf 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -102,7 +102,7 @@ static int __init imx8_soc_init(void)
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return -ENODEV;
+		return -ENOMEM;
 
 	soc_dev_attr->family = "Freescale i.MX";
 
@@ -112,8 +112,10 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 
 	id = of_match_node(imx8_soc_match, root);
-	if (!id)
+	if (!id) {
+		ret = -ENODEV;
 		goto free_soc;
+	}
 
 	data = id->data;
 	if (data) {
@@ -123,12 +125,16 @@ static int __init imx8_soc_init(void)
 	}
 
 	soc_dev_attr->revision = imx8_revision(soc_rev);
-	if (!soc_dev_attr->revision)
+	if (!soc_dev_attr->revision) {
+		ret = -ENOMEM;
 		goto free_soc;
+	}
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
+	if (IS_ERR(soc_dev)) {
+		ret = PTR_ERR(soc_dev);
 		goto free_rev;
+	}
 
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
@@ -142,6 +148,6 @@ static int __init imx8_soc_init(void)
 free_soc:
 	kfree(soc_dev_attr);
 	of_node_put(root);
-	return -ENODEV;
+	return ret;
 }
 device_initcall(imx8_soc_init);
-- 
2.7.4

