Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599A015502C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 02:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBGB7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 20:59:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45688 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgBGB7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so740156wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+D4B2/b6iuMMctw3DJ/Qvn6fdBFldvYEUcyhIreNWc=;
        b=iANebn6J+cWw8DNkmjIevDTStDdTWyvlKc+j2sUFC20IO3mpOpbgPJz+bkumI5qlEm
         19gQIf2FkImml/qYnFOMh66VWOIUhDB5FYTL3BKIeZabqrZgOQNPahh4/Nxp/M+jVvgm
         mLH/1imw927YRfZNDcy9cHBrRZk3KjzW+7o7kNPzfMbLN1m9F8kvEfU7vkx3lPIFM1Tt
         dTh6n7zJgL7/bcgsMJvLgpYnwRjZyJuG16rCo6VJqWJXO7auYlJX0jgjn3ljnSNS3DLJ
         DNXYouhLDzcqR0X9lc3TFPtQSithnKH+USCC8V0RLDhrDcVb2cJG28i9/jqcSuI7tllY
         7L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+D4B2/b6iuMMctw3DJ/Qvn6fdBFldvYEUcyhIreNWc=;
        b=XaFn08xQc8F6TW6wnTlbC8xO86R7dLReLg42y40Q2lsZmDJ3cQJJb4XScD8fnYKB0K
         aUJk7I7zwO2eNswEYPPM0vZ1elDV/MkYkUL4jVOUMkkWfkp8hLiNtJHOEfLZuN3flScM
         DG2Itlkw99RY9rORU2E/Uib3rI2hfEJa40DrVfXS30WqRV3TVuJkFSrT/QwlTrRovUvd
         rlUy1ysBIGfWwx3WueQwGjdPHOpTvHsY1Gbn2xeMwArsdnQ84qI1RqS+DtgNIXwI1kX/
         jC72D+vsr2VB9tjBSmfFjgf1yUMKLh9yTe8eMoUB1Lb0uJTAh4GNHTehUw81zobZfXGo
         TTww==
X-Gm-Message-State: APjAAAV8VM7P2ncOYDn3ZoF8JPeSceD2bLSRMX1Ck0WW99d0mZtiBOcp
        4t1A1f7tAR+GGMGNOLsB4GVrlw==
X-Google-Smtp-Source: APXvYqyOly3hII6E2lxUaW9RfyMcOLzelD3TulYhuFQF6qGDByAUcBCDzxz4HuUAG3ZF7YBskjwmPQ==
X-Received: by 2002:adf:e8c9:: with SMTP id k9mr1244346wrn.168.1581040769619;
        Thu, 06 Feb 2020 17:59:29 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:29 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 18/18] arm64: dts: qcom: qcs404-evb: Enable primary USB controller
Date:   Fri,  7 Feb 2020 01:59:07 +0000
Message-Id: <20200207015907.242991-19-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the primary USB controller which has

- One USB3 SS PHY using gpio-usb-conn
- One USB2 HS PHY in device mode only and no connector driver
  associated.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 07d6d793a922..4045d3000da6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -329,6 +329,35 @@ &usb2_phy_sec {
 	status = "okay";
 };
 
+&usb3 {
+	status = "okay";
+	dwc3@7580000 {
+		usb-role-switch;
+		usb_con: connector {
+			compatible = "gpio-usb-b-connector";
+			label = "USB-C";
+			id-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+			vbus-supply = <&usb3_vbus_reg>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb3_id_pin>, <&usb3_vbus_pin>;
+			status = "okay";
+		};
+	};
+};
+
+&usb2_phy_prim {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3_phy {
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.0

