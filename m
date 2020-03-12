Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841CB182C73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCLJ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:27:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33298 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:27:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C9RoYx050647;
        Thu, 12 Mar 2020 04:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584005270;
        bh=93Ozw0w3LdMCurx6cSWHKlJdaVIKSKUirOz+tIwd5Us=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a0UXAzmTDP0go4sAocD8McRdDKrtf2BGKWAjmMa2GxRhGTOz/nLKWZdZiFs+p//Sr
         PdcnNQAI/xtfy6ia944ma6Y37ecyFcwnmYwK4RroXpWfwXFH7ukvvJlnNVYk47LNyn
         DTsg8X9JtzXAp5f/TdnNDGdhCCs045zIzKIWww4s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C9RoEV096529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 04:27:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 04:27:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 04:27:50 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02C9Rjpc036158;
        Thu, 12 Mar 2020 04:27:48 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65-mcu: Add DMA entries for ADC
Date:   Thu, 12 Mar 2020 14:58:23 +0530
Message-ID: <20200312092823.21587-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312092823.21587-1-vigneshr@ti.com>
References: <20200312092823.21587-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA entries for ADC nodes

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 92629cbdc184..e85498f0dd05 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -82,6 +82,9 @@ tscadc0: tscadc@40200000 {
 		assigned-clocks = <&k3_clks 0 2>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "adc_tsc_fck";
+		dmas = <&mcu_udmap 0x7100>,
+			<&mcu_udmap 0x7101 >;
+		dma-names = "fifo0", "fifo1";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -97,6 +100,9 @@ tscadc1: tscadc@40210000 {
 		assigned-clocks = <&k3_clks 1 2>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "adc_tsc_fck";
+		dmas = <&mcu_udmap 0x7102>,
+			<&mcu_udmap 0x7103>;
+		dma-names = "fifo0", "fifo1";
 
 		adc {
 			#io-channel-cells = <1>;
-- 
2.25.1

