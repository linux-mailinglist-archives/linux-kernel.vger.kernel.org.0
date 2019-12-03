Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617FA10F68C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLCE6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 23:58:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfLCE6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 23:58:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so2021008wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 20:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovwMqTunBsTOC/CqSHDUi6kBW0F5coIGszg1T7U+mmc=;
        b=JyHSTtEqJjBunwy7X6C8u0emC8YOkh//6Huc6rS1+xcedJ3UizEM5ZQ/oF0Z3ZbzoG
         LBMVE4VHnS2u5w9kuBLc9nuYTSq+3/h+m+K1OMNqtstxQaMjMMTjUjWCNSVmwSAjx5TS
         o/Vb5DygLM1Qe07q6f75jMdySlqCy26WdiP2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovwMqTunBsTOC/CqSHDUi6kBW0F5coIGszg1T7U+mmc=;
        b=V8Ru501tq3AlA/jEXYBMFGPuTdWsyYJ0xGY0LK0GZRJAmO+Q7Im5o8hu5Om7/rnq89
         9Lz8wH3XU96eUzB9HujcprDzUZgYZgdwCvB0af7YRdWzmo6awK3KBg4mUVYDppUaBp4N
         f4H0i/3QHYWQm4OETAQCzcmPSLxhdbec6hBf40Z90RsbP1mpj0ZrVXhKcRELPQQXZN/L
         Ie7uxms3UEX+x8+IVIGpu+HKsVZWzq9ckKl+D6oQOyxOQ0gz6E77k7m761jlJC7fO3NF
         ubMmcfNgIq4JAJ4lQBDWAYG5+f6arxoXr5+7nEFZlwx4rTCokoq4FKZbxr07adf7nghr
         wGgQ==
X-Gm-Message-State: APjAAAWb27MlyH6AHedfqG4i59v/uwgvU4fz7Hdwgy9o+MVSACWARTwh
        iNZ4F6plyIBFpjr0H/UHf8mHXw==
X-Google-Smtp-Source: APXvYqz9UG6+uRLARgRC4h9K9ngpNM/yLeVYRm7UAEuQb7CC8hxxsUUj/XOI97lXY4CwxOy7a5RBnw==
X-Received: by 2002:adf:f108:: with SMTP id r8mr2821276wro.390.1575349082332;
        Mon, 02 Dec 2019 20:58:02 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm1667807wmk.26.2019.12.02.20.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 20:58:01 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date:   Tue,  3 Dec 2019 10:27:06 +0530
Message-Id: <1575349026-8743-7-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

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

