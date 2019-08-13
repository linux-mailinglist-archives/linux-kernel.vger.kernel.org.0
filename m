Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D38B928
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfHMMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:51:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41122 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHMMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:51:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id DF87028A5AE
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dafna.hirschfeld@collabora.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
Date:   Tue, 13 Aug 2019 14:51:47 +0200
Message-Id: <20190813125147.29605-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813125147.29605-1-dafna.hirschfeld@collabora.com>
References: <20190813125147.29605-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Bisson <gary.bisson@boundarydevices.com>

The Nitrogen8M is an ARM based single board computer (SBC)
designed to leverage the full capabilities of NXP’s i.MX8M
Quad processor.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
[Dafna: porting vendor's code to mainline]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 362bf827cad1..16db1c699ba7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -224,6 +224,7 @@ properties:
       - description: i.MX8MQ based Boards
         items:
           - enum:
+              - boundary,imx8mq-nitrogen8m # i.MX8MQ NITROGEN Board
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - purism,librem5-devkit     # Purism Librem5 devkit
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
-- 
2.20.1

