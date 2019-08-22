Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2443998965
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfHVCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 22:21:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42082 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfHVCVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:21:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 018101A02AC;
        Thu, 22 Aug 2019 04:21:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FA661A0595;
        Thu, 22 Aug 2019 04:21:33 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8523040296;
        Thu, 22 Aug 2019 10:21:25 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v4 1/2] dt/bindings: display: Add optional property node define for Mali DP500
Date:   Thu, 22 Aug 2019 10:11:34 +0800
Message-Id: <20190822021135.10288-1-wen.he_1@nxp.com>
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
index 2f7870983ef1..7a97a2b48c2a 100644
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
+		arm,malidp-arqos-high-level = <0xd000d000>;
 		port {
 			dp0_output: endpoint {
 				remote-endpoint = <&tda998x_2_input>;
-- 
2.17.1

