Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A200E29080
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 07:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbfEXFtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 01:49:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54862 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388206AbfEXFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:49:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC6472000FF;
        Fri, 24 May 2019 07:49:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F019B2000AC;
        Fri, 24 May 2019 07:49:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A1D74029F;
        Fri, 24 May 2019 13:49:04 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hyc.nju@gmail.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put() in error handling
Date:   Fri, 24 May 2019 13:51:00 +0800
Message-Id: <20190524055101.3424-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

of_node_put() is called after of_match_node() successfully called,
then in the following error handling, of_node_put() is called again
which is unnecessary, this patch adjusts the location of of_node_put()
to avoid such scenario.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 02988bd..d5badde 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -115,8 +115,6 @@ static int __init imx8_soc_init(void)
 	if (!id)
 		goto free_soc;
 
-	of_node_put(root);
-
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
@@ -135,6 +133,8 @@ static int __init imx8_soc_init(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
 
+	of_node_put(root);
+
 	return 0;
 
 free_rev:
-- 
2.7.4

