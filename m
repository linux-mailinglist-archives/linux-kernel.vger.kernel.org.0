Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471682F9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfE3Jpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:45:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39866 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfE3Jpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:45:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C388720129F;
        Thu, 30 May 2019 11:45:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 989072000B3;
        Thu, 30 May 2019 11:45:22 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2FF044029F;
        Thu, 30 May 2019 17:45:11 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        bruno.thomsen@gmail.com, aisheng.dong@nxp.com, ping.bai@nxp.com,
        leoyang.li@nxp.com, l.stach@pengutronix.de, pankaj.bansal@nxp.com,
        bhaskar.upadhaya@nxp.com, pramod.kumar_1@nxp.com,
        vabhav.sharma@nxp.com, leonard.crestez@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] dt-bindings: arm: imx: Add the soc binding for i.MX8MN
Date:   Thu, 30 May 2019 17:47:04 +0800
Message-Id: <20190530094706.865-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

This patch adds the soc & board binding for i.MX8MN.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138e..b1a5231 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -171,6 +171,12 @@ properties:
           - const: compulab,cl-som-imx7
           - const: fsl,imx7d
 
+      - description: i.MX8MN based Boards
+        items:
+          - enum:
+              - fsl,imx8mn-ddr4-evk            # i.MX8MN DDR4 EVK Board
+          - const: fsl,imx8mn
+
       - description: i.MX8MM based Boards
         items:
           - enum:
-- 
2.7.4

