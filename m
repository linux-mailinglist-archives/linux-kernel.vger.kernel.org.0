Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9107E8432E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHGENK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 00:13:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33086 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfHGENJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:13:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 889E31A06FE;
        Wed,  7 Aug 2019 06:13:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13A041A06E9;
        Wed,  7 Aug 2019 06:13:02 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D296402E6;
        Wed,  7 Aug 2019 12:12:54 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     srinivas.kandagatla@linaro.org
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, fugang.duan@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH nvmem v2 2/2] dt-bindings: fsl: scu: add new compatible string for ocotp
Date:   Wed,  7 Aug 2019 12:03:20 +0800
Message-Id: <20190807040320.1760-3-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190807040320.1760-1-fugang.duan@nxp.com>
References: <20190807040320.1760-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add new compatible string "fsl,imx8qm-scu-ocotp" into binding
doc  for i.MX8 SCU OCOTP driver.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index a575e42..c149fad 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -136,7 +136,9 @@ Required properties:
 OCOTP bindings based on SCU Message Protocol
 ------------------------------------------------------------
 Required properties:
-- compatible:		Should be "fsl,imx8qxp-scu-ocotp"
+- compatible:		Should be one of:
+			"fsl,imx8qm-scu-ocotp",
+			"fsl,imx8qxp-scu-ocotp".
 - #address-cells:	Must be 1. Contains byte index
 - #size-cells:		Must be 1. Contains byte length
 
-- 
2.7.4

