Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC90A10F70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEAW5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 18:57:36 -0400
Received: from node.akkea.ca ([192.155.83.177]:38844 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfEAW5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 18:57:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 508164E2058;
        Wed,  1 May 2019 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556751450; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gbdM/BQ9jNiQRCvk2otmlil195H2V1jepEj37hyx3SLNnoQFgqHJa5I2GwQzVBKTY
         +5S138S3sKMJZDHOVHatAkdbp043eLLAZEnTx17AxYhx9xr/dBZDng1zbZLWXtTKYP
         nhmDBr/owvCGNpL3GyrVozjNMomwMF8lu6Y/HZ20=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OiES10vSFaVB; Wed,  1 May 2019 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 5D8764E204E;
        Wed,  1 May 2019 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556751450; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gbdM/BQ9jNiQRCvk2otmlil195H2V1jepEj37hyx3SLNnoQFgqHJa5I2GwQzVBKTY
         +5S138S3sKMJZDHOVHatAkdbp043eLLAZEnTx17AxYhx9xr/dBZDng1zbZLWXtTKYP
         nhmDBr/owvCGNpL3GyrVozjNMomwMF8lu6Y/HZ20=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Wed,  1 May 2019 16:57:19 -0600
Message-Id: <20190501225719.3257-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501225719.3257-1-angus@akkea.ca>
References: <20190501225719.3257-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for imx8mq based boards

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..41364b127200 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -177,6 +177,13 @@ properties:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
           - const: fsl,imx8mm
 
+      - description: i.MX8MQ based Boards
+        items:
+          - enum:
+              - fsl,imx8mq-evk            # i.MX8MQ EVK Board
+              - purism,librem5-devkit     # Purism Librem5 devkit
+          - const: fsl,imx8mq
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
-- 
2.17.1

