Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9539151BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBDOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:15:43 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:47719 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgBDOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:15:42 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Feb 2020 19:45:39 +0530
Received: from harigovi-linux.qualcomm.com ([10.204.66.157])
  by ironmsg02-blr.qualcomm.com with ESMTP; 04 Feb 2020 19:45:39 +0530
Received: by harigovi-linux.qualcomm.com (Postfix, from userid 2332695)
        id B45A528BA; Tue,  4 Feb 2020 19:45:38 +0530 (IST)
From:   Harigovindan P <harigovi@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Harigovindan P <harigovi@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Subject: [v1] dt-bindings: msm:disp: update dsi and dpu bindings
Date:   Tue,  4 Feb 2020 19:45:37 +0530
Message-Id: <1580825737-27189-1-git-send-email-harigovi@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating bindings of dsi and dpu by adding and removing certain
properties.

Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
---

Changes in v1:
        - Adding "ahb" clock as a required property.
        - Adding "bus", "rot", "lut" as optional properties for sc7180 device.
        - Removing properties from dsi bindings that are unused.
	- Removing power-domain property since DSI is the child node of MDSS
	  and it will inherit supply from its parent.

 Documentation/devicetree/bindings/display/msm/dpu.txt | 7 +++++++
 Documentation/devicetree/bindings/display/msm/dsi.txt | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
index 551ae26..dd58472a 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
@@ -19,6 +19,7 @@ Required properties:
   The following clocks are required:
   * "iface"
   * "bus"
+  * "ahb"
   * "core"
 - interrupts: interrupt signal from MDSS.
 - interrupt-controller: identifies the node as an interrupt controller.
@@ -50,6 +51,8 @@ Required properties:
 - clock-names: device clock names, must be in same order as clocks property.
   The following clocks are required.
   * "bus"
+  For the device "qcom,sc7180-dpu":
+  * "bus" - is an optional property due to architecture change.
   * "iface"
   * "core"
   * "vsync"
@@ -70,6 +73,10 @@ Optional properties:
 - assigned-clocks: list of clock specifiers for clocks needing rate assignment
 - assigned-clock-rates: list of clock frequencies sorted in the same order as
   the assigned-clocks property.
+- For the device "qcom,sc7180-dpu":
+  clock-names: optional device clocks, needed for accessing LUT blocks.
+  * "rot"
+  * "lut"
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
index af95586..61d659a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi.txt
+++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
@@ -8,13 +8,10 @@ Required properties:
 - reg-names: The names of register regions. The following regions are required:
   * "dsi_ctrl"
 - interrupts: The interrupt signal from the DSI block.
-- power-domains: Should be <&mmcc MDSS_GDSC>.
 - clocks: Phandles to device clocks.
 - clock-names: the following clocks are required:
-  * "mdp_core"
   * "iface"
   * "bus"
-  * "core_mmss"
   * "byte"
   * "pixel"
   * "core"
@@ -156,7 +153,6 @@ Example:
 			"core",
 			"core_mmss",
 			"iface",
-			"mdp_core",
 			"pixel";
 		clocks =
 			<&mmcc MDSS_AXI_CLK>,
@@ -164,7 +160,6 @@ Example:
 			<&mmcc MDSS_ESC0_CLK>,
 			<&mmcc MMSS_MISC_AHB_CLK>,
 			<&mmcc MDSS_AHB_CLK>,
-			<&mmcc MDSS_MDP_CLK>,
 			<&mmcc MDSS_PCLK0_CLK>;
 
 		assigned-clocks =
-- 
2.7.4

