Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27221BEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 23:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEMVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 17:07:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34262 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfEMVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:07:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so7102075plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VyWcWjrZXEyD6w07tvHm50fVGWK7lK6mM8u98FcSYoY=;
        b=GGGhRxCLGCDe1tt+2HecuE4u75ZdWTyADg0qZXEsWP6EA7hGLVcgJgyKy41jgfrNgR
         ZU50QVg1F3c2QdeRgYlOKY3O5aFVv0pNIwqw/ajzRsklhVFsguNbBpd8ElghBnVIb+33
         xe8eBd32gzjcFINDMtM5uGleiX7/hFAPComeweZL4XDbUYnhO6dVdgtmEea1w/3l/15d
         dv//EQsWEC+llGw6tX1s9F38gB1wpVJezOtAcXMRPjpe9RLKIKcpGgNmc+xuHkYDk876
         +UVpckEfGohYz4oaDHpcpEaVTb+GP7cPQ9SHr+e3N7y9EgQiXt7oWn/INWuXzcIwGNPR
         Z0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VyWcWjrZXEyD6w07tvHm50fVGWK7lK6mM8u98FcSYoY=;
        b=EIJL4hcASowmNzT8QLnZMXxqfls1kk8mMFOmjD2WUtRjwR9MNq3Km5So3AxDoy/1lg
         mYXpDyQc1Up7Ct3S/Va9AdECFxvz+D7vYICh/E2VelRxhO9ZrAIKRIxFmVRtitiyI5N7
         9Zd+9DNZWKpyIU3J5DeEiNIDkj5BfU3jl/RxWd1OoY0bV+gFvOFp27TQ7JV48zLyeD+2
         bvbXws00Tlcu+4lHXpP+XYOFd1c2kIoXHIXeCLR6tRRVtNBCCigKRIrANykguyCfuxjL
         HVktYmOUAaVE0ob9Eec/t1hoWH63plUB/xf/grR3pO9XCxA6yEXpLUBDHlLjbDLu062K
         PTFQ==
X-Gm-Message-State: APjAAAWHhJjPKCo/0vzysHsQb84sartpN4cEjdR4/b/ZoCsq9Me7MQYV
        2683ICwXcA+nNVj3WSmLmGfKMw==
X-Google-Smtp-Source: APXvYqy4RdMGzwqzFo1V/pbxH61eNqRNaPswK4JglVAPvy+TtjrmAjqxmKK8n1mSWWT4UrrI6/L6JQ==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr5883784plq.306.1557781671009;
        Mon, 13 May 2019 14:07:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 85sm6939980pgb.52.2019.05.13.14.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:07:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-mtp: Add Truly display
Date:   Mon, 13 May 2019 14:07:47 -0700
Message-Id: <20190513210747.22429-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring in the Truly display and enable the DSI channels to make the
mdss/gpu probe, even though we're lacking LABIB, preventing us from
seeing anything on the screen.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 02b8357c8ce8..83198a19ff57 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -352,6 +352,77 @@
 	status = "okay";
 };
 
+&dsi0 {
+	status = "okay";
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+
+	qcom,dual-dsi-mode;
+	qcom,master-dsi;
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&truly_in_0>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+
+	panel@0 {
+		compatible = "truly,nt35597-2K-display";
+		reg = <0>;
+		vdda-supply = <&vreg_l14a_1p88>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+		mode-gpios = <&tlmm 52 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				truly_in_0: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				truly_in_1: endpoint {
+					remote-endpoint = <&dsi1_out>;
+				};
+			};
+		};
+	};
+};
+
+&dsi0_phy {
+	status = "okay";
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+};
+
+&dsi1 {
+	status = "okay";
+	vdda-supply = <&vdda_mipi_dsi1_1p2>;
+
+	qcom,dual-dsi-mode;
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&truly_in_1>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dsi1_phy {
+	status = "okay";
+	vdds-supply = <&vdda_mipi_dsi1_pll>;
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
@@ -365,6 +436,14 @@
 	clock-frequency = <400000>;
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.18.0

