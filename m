Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008E08CE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHNI3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 04:29:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41578 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfHNI3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:29:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 32A60200352;
        Wed, 14 Aug 2019 10:29:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24DC820034C;
        Wed, 14 Aug 2019 10:29:14 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4324D2060E;
        Wed, 14 Aug 2019 10:29:13 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: fsl_sai: Add support for imx8qm
Date:   Wed, 14 Aug 2019 11:29:10 +0300
Message-Id: <20190814082911.665-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814082911.665-1-daniel.baluta@nxp.com>
References: <20190814082911.665-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI module on imx8qm features a register map similar with imx6 series
(it doesn't have VERID and PARAM registers at the beginning
of address spece).

Also, it has one FIFO which can help up to 64 * 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 69cf3678c859..168e1c9cda5c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1031,12 +1031,19 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.reg_offset = 8,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 64,
+	.reg_offset = 0,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
 	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
+	{ .compatible = "fsl,imx8qm-sai", .data = &fsl_sai_imx8qm_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.17.1

