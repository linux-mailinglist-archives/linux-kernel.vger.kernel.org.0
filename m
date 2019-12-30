Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A912D4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 00:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfL3XUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 18:20:13 -0500
Received: from lists.gateworks.com ([108.161.130.12]:40223 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3XUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 18:20:11 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1im4ZR-0001tP-7H; Mon, 30 Dec 2019 23:35:33 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v5 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
Date:   Mon, 30 Dec 2019 15:19:49 -0800
Message-Id: <20191230231953.29646-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191230231953.29646-1-rjones@gateworks.com>
References: <20191230231953.29646-1-rjones@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible enum entries for Gateworks Ventana boards.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..8ed4c85 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -126,6 +126,22 @@ properties:
               - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
               - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
               - variscite,dt6customboard
+              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
+              - gw,imx6q-gw51xx
+              - gw,imx6q-gw52xx
+              - gw,imx6q-gw53xx
+              - gw,imx6q-gw5400-a
+              - gw,imx6q-gw54xx
+              - gw,imx6q-gw551x
+              - gw,imx6q-gw552x
+              - gw,imx6q-gw553x
+              - gw,imx6q-gw560x
+              - gw,imx6q-gw5903
+              - gw,imx6q-gw5904
+              - gw,imx6q-gw5907
+              - gw,imx6q-gw5910
+              - gw,imx6q-gw5912
+              - gw,imx6q-gw5913
           - const: fsl,imx6q
 
       - description: i.MX6QP based Boards
@@ -152,6 +168,21 @@ properties:
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
+              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
+              - gw,imx6dl-gw51xx
+              - gw,imx6dl-gw52xx
+              - gw,imx6dl-gw53xx
+              - gw,imx6dl-gw54xx
+              - gw,imx6dl-gw551x
+              - gw,imx6dl-gw552x
+              - gw,imx6dl-gw553x
+              - gw,imx6dl-gw560x
+              - gw,imx6dl-gw5903
+              - gw,imx6dl-gw5904
+              - gw,imx6dl-gw5907
+              - gw,imx6dl-gw5910
+              - gw,imx6dl-gw5912
+              - gw,imx6dl-gw5913
           - const: fsl,imx6dl
 
       - description: i.MX6SL based Boards
-- 
2.9.2

