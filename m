Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFD127E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 15:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLTOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 09:45:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLTOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:45:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so9646155wrn.7;
        Fri, 20 Dec 2019 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pl3hFVbXh8V/pNW7LI4EULZNEnEA05Snk8lDcRO0F4I=;
        b=eCzaA1gUWIYYBIg/IQTWc7sIFKYB1GqkT8s32yc8blx3R6j6hCIgTMBBckZDLig7fP
         gp+sHfVT0yCurfEg7SKiyTLnNBa/KSfJPef0t5hUqx1vlrMGhHZuZVF91eX1N8oKMGn+
         DWdCBVwIJV76oYCUvgrtWOHj38aMNSEolWVQFkUX2nXVVyoPajrRVvH4dgZoUJPIRiAb
         3J+RRM5gKHwVo8VM6pTBAElWiaNdY4zUwzHzRKdlrQl20Oq692hBUJNOJpJeEdkum8X7
         cZzOXYPLktB+3RHudr7hTjT0LRRoS78rI8/d+02KFwcahewvN1YMT3gntD6jtMRRgJjp
         ufaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pl3hFVbXh8V/pNW7LI4EULZNEnEA05Snk8lDcRO0F4I=;
        b=OOjWAM81ajVStFTXhmmeYQFBGuoVgQ+1YoEakYq3KmjQ10yIowHNgWy0/r24x9J6Xd
         8qGxVezxulUVQyJUwXt5nDo42yB4oulUrYr2cEGZvr/eJTd28URHjAWTM+x9iVIDP832
         BCdyrZn1tDfxU1YuCiCgEupYYgpt0yas8XQ+et0NKVvPx2Z+JnRQmmfAXk6fcM6K8M7T
         +5c+bHRKv7E7WOkOy7XdWeGtF1rgi5BI5xcXpL5s4cKeX+XQqxczAd4c0aILzyEFVd7f
         eTw3FudBnKLANfPtgJ/xHlzPppfL1/cRFImLFTAqq+CZWgTTAtznjO2RgB1wRWcSD5+a
         SeTg==
X-Gm-Message-State: APjAAAWYpERI0QU070n/spdcKX8zywwIBJaRJCFwEyKRKSaxSO9I+yCh
        PI0uKKmo3W6uFzAeXDc8zTI=
X-Google-Smtp-Source: APXvYqwzSfkfp87+FaM77mK7bj+bOyD1OkSjuuKjhQwV4WixlXdcVQ1GWCN+pLWH1WcgZc5ig7ROIA==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr15388222wrn.214.1576853146255;
        Fri, 20 Dec 2019 06:45:46 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 5sm10546226wrh.5.2019.12.20.06.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:45:45 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399-evb: sort nodes in alphabetical order
Date:   Fri, 20 Dec 2019 15:45:37 +0100
Message-Id: <20191220144537.30867-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort nodes in alphabetical order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 66 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 77008dca4..6e8b63db2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -134,6 +134,39 @@
 	status = "okay";
 };
 
+&pcie0 {
+	ep-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	status = "disabled";
+};
+
+&pcie_phy {
+	status = "disabled";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins =
+				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pmic_dvs2: pmic-dvs2 {
+			rockchip,pins =
+				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	usb2 {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -154,18 +187,6 @@
 	status = "okay";
 };
 
-&pcie_phy {
-	status = "disabled";
-};
-
-&pcie0 {
-	ep-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
-	num-lanes = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>;
-	status = "disabled";
-};
-
 &u2phy0 {
 	status = "okay";
 };
@@ -203,24 +224,3 @@
 &usb_host1_ohci {
 	status = "okay";
 };
-
-&pinctrl {
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins =
-				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		pmic_dvs2: pmic-dvs2 {
-			rockchip,pins =
-				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
-	usb2 {
-		vcc5v0_host_en: vcc5v0-host-en {
-			rockchip,pins =
-				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-- 
2.11.0

