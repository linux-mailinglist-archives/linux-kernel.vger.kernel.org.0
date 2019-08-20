Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D99677C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfHTRZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 13:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfHTRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:25:40 -0400
Received: from localhost.localdomain (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA80C2064A;
        Tue, 20 Aug 2019 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321939;
        bh=M+6+1x75KEPkx+lE9S3iYX+zdQsZ2R3sBYFxh6yUG3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQRor0YIYP5xBWVAgTUreofT/cOEiu8hA+HPwcfrUX9Jkwat9+9sucecw0Q/4mqul
         YCjtb5JMSttS54+aXKWuDgMEi2NBMOnFCsZ1HlrLHn4hNeS30gJ+vxMKAQGWNFWfLC
         VphOaZcY2KHELiVc5JzTCAoreJIjRjc502SYDIuI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] arm64: dts: qcom: sm8150-mtp: add base dts file
Date:   Tue, 20 Aug 2019 22:53:48 +0530
Message-Id: <20190820172351.24145-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820172351.24145-1-vkoul@kernel.org>
References: <20190820172351.24145-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add base DTS file for sm8150-mtp and enables boot to console, adds
tlmm reserved range, resin node, volume down key and also includes pmic
file.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |  1 +
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 51 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 0a7e5dfce6f7..1964dacaf19b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -12,5 +12,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
new file mode 100644
index 000000000000..6f5777f530ae
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8150 MTP";
+	compatible = "qcom,sm8150-mtp";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&pon {
+	pwrkey {
+		status = "okay";
+	};
+
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <126 4>;
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.20.1

