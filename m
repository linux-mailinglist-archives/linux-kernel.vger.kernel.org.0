Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99A714E92D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 08:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgAaHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 02:40:24 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:54646 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728076AbgAaHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:40:23 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 31 Jan 2020 13:09:24 +0530
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg01-blr.qualcomm.com with ESMTP; 31 Jan 2020 13:08:58 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 3E45820498; Fri, 31 Jan 2020 13:08:57 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, robh@kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, tientzu@chromium.org,
        seanpaul@chromium.org, rjliao@codeaurora.org, yshavit@google.com,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip WCN3991
Date:   Fri, 31 Jan 2020 13:08:55 +0530
Message-Id: <1580456335-7317-2-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
References: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the Qualcomm WCN3991 Bluetooth controller

Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 68b67d9..e72045d 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -11,6 +11,7 @@ Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
    * "qcom,wcn3990-bt"
+   * "qcom,wcn3991-bt"
    * "qcom,wcn3998-bt"
 
 Optional properties for compatible string qcom,qca6174-bt:
@@ -30,6 +31,7 @@ Optional properties for compatible string qcom,wcn399x-bt:
 
  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
  - firmware-name: specify the name of nvm firmware to load
+ - clocks: clock provided to the controller
 
 Examples:
 
@@ -56,5 +58,6 @@ serial@898000 {
 		vddch0-supply = <&vreg_l25a_3p3>;
 		max-speed = <3200000>;
 		firmware-name = "crnv21.bin";
+		clocks = <&rpmhcc>;
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

