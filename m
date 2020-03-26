Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA81938F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCZGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 02:49:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40300 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgCZGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so6342072wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0idw5B6PcVqWUxIoMkNt7TgZxctDSgOOI59ozY4oTHM=;
        b=eOzaFwpapO566KIN7o8CtBngABKyDb0NQEUbuybM+vBuUJ6pSDk6ZXtpd0TBG5lVde
         ptxih3E2lZ1YpIPRurd1aXbCr2bn4XHT3tOHFPBrImMzJVGQbsVkQvVLIW7OHtnTo8fe
         OvcoHrjVDGAENbGCR2UwXUevVKaeUk//26t/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0idw5B6PcVqWUxIoMkNt7TgZxctDSgOOI59ozY4oTHM=;
        b=ij0MIwekqaEB1/Cmo6lHl/q1Rc8yR/c7z8VyyYFUic+IUt4bjy7bSzoFq2W5y6NQsX
         0pBJ9x1WaXjoYcXFgnNWon97fa9EjJPRF/2tk6NcedGwygnTBX0KfrzJT54cDOt/rvWE
         uwCMIuE90c51rB0cZXASsXMMbvw/9yOrRAFSGCdHUcu45X0ld4x/hYhiX5F1JKm12Kt3
         EuwZnLWQ5D3WXCdFWsNohXCoLJQuZP71PXBMFkVS3ZTdzfbyLkNSDFIE0M3Bg3PMiwbu
         5I5T3gdT5lbaQe/gCeZHJsSaBsTeJlvx1RG/+9Dngth2SPIJgyZnVg0YHRJTB5Zq7Hdz
         9MbA==
X-Gm-Message-State: ANhLgQ1WuezppNz8x2W2TeGI64bK3454p2pA047kMIhh12DCjrgv8YTr
        gXwEPpr+wiMj9B3GTW62NZilMg==
X-Google-Smtp-Source: ADFU+vsQTR/kVV+uSwHzxwJhKiVFKKuIbCfDf2JW2zqZaGt6ru+SMQ31s/bTu6v99Ao07jypy+Wdrw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr7182823wrp.23.1585205387945;
        Wed, 25 Mar 2020 23:49:47 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v21sm2069137wmj.8.2020.03.25.23.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 23:49:47 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date:   Thu, 26 Mar 2020 12:18:46 +0530
Message-Id: <1585205326-25326-7-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 28 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 15f7b0e..489bfd5 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -117,8 +117,11 @@
 		dma-coherent;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -140,6 +143,13 @@
 		phy-names = "pcie-phy";
 
 		msi-parent = <&v2m0>;
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie4: pcie@50020000 {
@@ -148,8 +158,11 @@
 		dma-coherent;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie4_intc 0>,
+				<0 0 0 2 &pcie4_intc 1>,
+				<0 0 0 3 &pcie4_intc 2>,
+				<0 0 0 4 &pcie4_intc 3>;
 
 		linux,pci-domain = <4>;
 
@@ -171,6 +184,13 @@
 		phy-names = "pcie-phy";
 
 		msi-parent = <&v2m0>;
+		pcie4_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie8: pcie@60c00000 {
-- 
2.7.4

