Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F96E3F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfGSKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:08:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43020 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSKIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:08:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 00CA01A0144;
        Fri, 19 Jul 2019 12:08:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41D0A1A0187;
        Fri, 19 Jul 2019 12:07:59 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F38B0402D5;
        Fri, 19 Jul 2019 18:07:51 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 2/3] dt/bindings: display: Add optional property node defined for Mali DP500
Date:   Fri, 19 Jul 2019 17:58:42 +0800
Message-Id: <20190719095842.11683-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
This property describe the ARQoS levels of DP500's QoS signaling.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 Documentation/devicetree/bindings/display/arm,malidp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/arm,malidp.txt b/Documentation/devicetree/bindings/display/arm,malidp.txt
index 2f7870983ef1..76a0e7251251 100644
--- a/Documentation/devicetree/bindings/display/arm,malidp.txt
+++ b/Documentation/devicetree/bindings/display/arm,malidp.txt
@@ -37,6 +37,8 @@ Optional properties:
     Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
     to be used for the framebuffer; if not present, the framebuffer may
     be located anywhere in memory.
+  - arm,malidp-arqos-high-level: integer of u32 value describing the ARQoS
+    levels of DP500's QoS signaling.
 
 
 Example:
@@ -54,6 +56,7 @@ Example:
 		clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
+		arm,malidp-arqos-high-level = <&rqosvalue>;
 		port {
 			dp0_output: endpoint {
 				remote-endpoint = <&tda998x_2_input>;
-- 
2.17.1

