Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310B574DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbfGYMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:15:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404497AbfGYMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:15:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 498D928AACB
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dafna.hirschfeld@collabora.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
Date:   Thu, 25 Jul 2019 14:14:52 +0200
Message-Id: <20190725121452.16607-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725121452.16607-1-dafna.hirschfeld@collabora.com>
References: <20190725121452.16607-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Bisson <gary.bisson@boundarydevices.com>

i.MX 8Quad is a quad (4x) Cortex-A53 processor with powerful
graphic and multimedia features.
This patch adds Nitrogen8M board support.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
[Dafna: porting vendor's code to mainline]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..728c41ef83bb 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -227,6 +227,12 @@ properties:
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
           - const: fsl,imx8qxp
 
+      - description: i.MX8MQ based Boards
+        items:
+          - enum:
+              - boundary,imx8mq-nitrogen8m           # i.MX8MQ NITROGEN Board
+          - const: fsl,imx8mq
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.20.1

