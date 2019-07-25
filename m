Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8F74326
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbfGYCPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 22:15:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34944 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbfGYCPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:15:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E706020053C;
        Thu, 25 Jul 2019 04:15:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45E1B20016C;
        Thu, 25 Jul 2019 04:15:15 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E844D40302;
        Thu, 25 Jul 2019 10:15:06 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: clock: imx8mn: Fix tab indentation for yaml file
Date:   Thu, 25 Jul 2019 10:05:51 +0800
Message-Id: <20190725020551.27034-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

YAML file can NOT contain tab as indentation, fix it.

Fixes: 6d6062553e3d ("dt-bindings: imx: Add clock binding doc for i.MX8MN")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
index 454c5b4..622f365 100644
--- a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
@@ -71,7 +71,7 @@ examples:
         compatible = "fixed-clock";
         #clock-cells = <0>;
         clock-frequency = <32768>;
-	clock-output-names = "osc_32k";
+        clock-output-names = "osc_32k";
     };
 
     osc_24m: clock-osc-24m {
-- 
2.7.4

