Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313642D2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE2A5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 20:57:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45483 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfE2A5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 20:57:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so257420pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wzk0rvDelDnq+wIqmO8ngZJJ8/wBww612QEapc+1RXA=;
        b=MfPVeryc778PT7zEV1xwpuPGTGjyYqJxhIvyGN3adsXOhm4REcLbOrAnhV3ZcsOHpI
         gQ/DLRkrdv+/GU4j24r7uB7NKASh7DJ0K5JERM7KnH47fVoqJB3aTGF6BL6KoMflmINz
         U2amAfWuTyTeYrFVWp53pPo0IOYq1TFCxUJJUgch8vVd+J8LOBhEzbmtYPa4FocRqAUK
         NshTzPDnE3dDp/zKdte+n9rl8wgtc7sc+iFUTUvGBh0ngQitetDsQ4gc8CGDyKWirU48
         SAu22vSHsrv6kaFKDFiRNdqFvciWiBQJ5cIFZ3zoQRXdhRZLO8cN50mpmJeYGgHeMcSb
         1SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wzk0rvDelDnq+wIqmO8ngZJJ8/wBww612QEapc+1RXA=;
        b=tPcWcdPB9u2lAnn+/kc+M+gPp10DZE34cm09JG2vttVD06qy23Q4WvzzcbUbqbxNg9
         2S0UX2/RFCaq1t7yRuP+WKAObls3EP01rUhEubX4o5e03fEaoIIM2H6jlBCp4MPmAGUR
         p3nu8l+hNcOwm049zRZt348HEnjpOk+lpLd2RuZUJr1l7Ix5RA8bkRda20z3N394+ndR
         EhQb6RxUtqN8hC1SqGrrNH0jMWMEDkAJfQIEpKouQzvIiFWZNzeCw5YnSQSiQoR+Egpk
         bzz7giBZpzmhHLqVf/9Tyzg+AwIO1FdAb2aynOWFelGyzNDxOg+ShumOGzCdD29/Wvac
         BY+g==
X-Gm-Message-State: APjAAAUA3hmspXVbju3EnlHGLLxPJ7J79MSmNoEK2qxj1kcLfrspgVAF
        yadBR9LqxDcbmmc/F1YS9OdIaQ==
X-Google-Smtp-Source: APXvYqzJIIa0oyam4g8SFZ/c8RStRJjA/g8v7wvBbHPTNBnJwg2uYNrbctrf9bCW+d8PNJi7ftp2tA==
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr924104pll.159.1559091437527;
        Tue, 28 May 2019 17:57:17 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p16sm15434824pff.35.2019.05.28.17.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 17:57:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] PCI: qcom: Add QCS404 PCIe controller support
Date:   Tue, 28 May 2019 17:57:10 -0700
Message-Id: <20190529005710.23950-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529005710.23950-1-bjorn.andersson@linaro.org>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCS404 platform contains a PCIe controller of version 2.4.0 and a
Qualcomm PCIe2 PHY. The driver already supports version 2.4.0, for the
IPQ4019, but this support touches clocks and resets related to the PHY
as well, and there's no upstream driver for the PHY.

On QCS404 we must initialize the PHY, so a separate PHY driver is
implemented to take care of this and the controller driver is updated to
not require the PHY related resources. This is done by relying on the
fact that operations in both the clock and reset framework are nops when
passed NULL, so we can isolate this change to only the get_resource
function.

For QCS404 we also need to enable the AHB (iface) clock, in order to
access the register space of the controller, but as this is not part of
the IPQ4019 DT binding this is only added for new users of the 2.4.0
controller.

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Picked up Vinod's r-b and Stanimir's a-b

 drivers/pci/controller/dwc/pcie-qcom.c | 64 +++++++++++++++-----------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 23dc01212508..da5dd3639a49 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -112,7 +112,7 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
+#define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
 	int num_clks;
@@ -638,13 +638,16 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
 	int ret;
 
 	res->clks[0].id = "aux";
 	res->clks[1].id = "master_bus";
 	res->clks[2].id = "slave_bus";
+	res->clks[3].id = "iface";
 
-	res->num_clks = 3;
+	/* qcom,pcie-ipq4019 is defined without "iface" */
+	res->num_clks = is_ipq ? 3 : 4;
 
 	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
@@ -658,27 +661,33 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->axi_s_reset))
 		return PTR_ERR(res->axi_s_reset);
 
-	res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(res->pipe_reset))
-		return PTR_ERR(res->pipe_reset);
-
-	res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
-								 "axi_m_vmid");
-	if (IS_ERR(res->axi_m_vmid_reset))
-		return PTR_ERR(res->axi_m_vmid_reset);
-
-	res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
-								"axi_s_xpu");
-	if (IS_ERR(res->axi_s_xpu_reset))
-		return PTR_ERR(res->axi_s_xpu_reset);
-
-	res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
-	if (IS_ERR(res->parf_reset))
-		return PTR_ERR(res->parf_reset);
-
-	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-	if (IS_ERR(res->phy_reset))
-		return PTR_ERR(res->phy_reset);
+	if (is_ipq) {
+		/*
+		 * These resources relates to the PHY or are secure clocks, but
+		 * are controlled here for IPQ4019
+		 */
+		res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
+		if (IS_ERR(res->pipe_reset))
+			return PTR_ERR(res->pipe_reset);
+
+		res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
+									 "axi_m_vmid");
+		if (IS_ERR(res->axi_m_vmid_reset))
+			return PTR_ERR(res->axi_m_vmid_reset);
+
+		res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
+									"axi_s_xpu");
+		if (IS_ERR(res->axi_s_xpu_reset))
+			return PTR_ERR(res->axi_s_xpu_reset);
+
+		res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
+		if (IS_ERR(res->parf_reset))
+			return PTR_ERR(res->parf_reset);
+
+		res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
+		if (IS_ERR(res->phy_reset))
+			return PTR_ERR(res->phy_reset);
+	}
 
 	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
 								   "axi_m_sticky");
@@ -698,9 +707,11 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ahb_reset))
 		return PTR_ERR(res->ahb_reset);
 
-	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
-	if (IS_ERR(res->phy_ahb_reset))
-		return PTR_ERR(res->phy_ahb_reset);
+	if (is_ipq) {
+		res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
+		if (IS_ERR(res->phy_ahb_reset))
+			return PTR_ERR(res->phy_ahb_reset);
+	}
 
 	return 0;
 }
@@ -1268,6 +1279,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ }
 };
 
-- 
2.18.0

