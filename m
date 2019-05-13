Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D121B93D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfEMO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 10:56:02 -0400
Received: from node.akkea.ca ([192.155.83.177]:37064 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbfEMOzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:55:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id BD4BC4E2050;
        Mon, 13 May 2019 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557759351; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=itvWLkrWh2wRTVHZYibki4sFm28yEaulV9aIeTXpyoSwMaJGjgl4BHIP06/0ZIEon
         z9ojfpKr20i3XOX1ktuXxHSnmXss5115jbAdmccLIoP7ouo6SsAMhmTdY6YEqKkBjv
         rv6jMhHVbYV+dwBKpmAHtzEL+qIfdGxbzyFEhMG0=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Qc7PrI2YegJ; Mon, 13 May 2019 14:55:51 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id F1F2C4E204B;
        Mon, 13 May 2019 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557759351; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=itvWLkrWh2wRTVHZYibki4sFm28yEaulV9aIeTXpyoSwMaJGjgl4BHIP06/0ZIEon
         z9ojfpKr20i3XOX1ktuXxHSnmXss5115jbAdmccLIoP7ouo6SsAMhmTdY6YEqKkBjv
         rv6jMhHVbYV+dwBKpmAHtzEL+qIfdGxbzyFEhMG0=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
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
Subject: [PATCH v9 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Mon, 13 May 2019 07:55:39 -0700
Message-Id: <20190513145539.28174-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513145539.28174-1-angus@akkea.ca>
References: <20190513145539.28174-1-angus@akkea.ca>
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

