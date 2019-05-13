Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BA1BEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEMUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 16:23:20 -0400
Received: from node.akkea.ca ([192.155.83.177]:47980 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfEMUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:23:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B01E64E2056;
        Mon, 13 May 2019 20:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778988; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CnmgHwyjF/udFyIuyfBdisbBmYUOZ2Nr9qrW1YvRHqI8goiaIr/JD+kOCxn4zwi9X
         vgf2nheZ2Qm8W8wQ4fFbwSRw8Wgomo2ChmTaRxiG5/al8s7Oh/28HugYYWinV4Edk8
         jdGFlPs8aehY8fLQJ0vtJyzLy79dahJvojBvcLV8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KUH2Ax_BlAuw; Mon, 13 May 2019 20:23:08 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id D909C4E2050;
        Mon, 13 May 2019 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778988; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CnmgHwyjF/udFyIuyfBdisbBmYUOZ2Nr9qrW1YvRHqI8goiaIr/JD+kOCxn4zwi9X
         vgf2nheZ2Qm8W8wQ4fFbwSRw8Wgomo2ChmTaRxiG5/al8s7Oh/28HugYYWinV4Edk8
         jdGFlPs8aehY8fLQJ0vtJyzLy79dahJvojBvcLV8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v11 4/4] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Mon, 13 May 2019 13:22:58 -0700
Message-Id: <20190513202258.30949-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202258.30949-1-angus@akkea.ca>
References: <20190513202258.30949-1-angus@akkea.ca>
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

