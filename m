Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C47182C70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:27:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54912 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:27:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C9RmOs129981;
        Thu, 12 Mar 2020 04:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584005268;
        bh=GqVcNEGCSqO43d8JjVZhJGIosXmnS9GliY5ZdDU3wF4=;
        h=From:To:CC:Subject:Date;
        b=ZWu4/WVCtugPrmgV1hR9v9eOvWZ41Fv98z1j7rM4L6OSulrB1ccu4sbYynb8gWi0V
         3sqvta4Gyh0781QQ5oziCZKDV3B/8mlcSPAC7rdF6BQP3FhF+r6cfElMDSx6tJ6Eeu
         R0SDJGr8rtJw6AIwrOzeaStrkdH/RXk/rd7Dqiig=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02C9Rm5x097588;
        Thu, 12 Mar 2020 04:27:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 04:27:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 04:27:47 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02C9Rjpb036158;
        Thu, 12 Mar 2020 04:27:45 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65-main: Add DMA entries for main_spi0
Date:   Thu, 12 Mar 2020 14:58:22 +0530
Message-ID: <20200312092823.21587-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA entry for main_spi0, that has SPI flash connected, for better
throughput and reduced CPU load.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e5df20a2d2f9..0ff291ef2950 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -189,6 +189,8 @@ main_spi0: spi@2100000 {
 		power-domains = <&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
+		dma-names = "tx0", "rx0";
 	};
 
 	main_spi1: spi@2110000 {
-- 
2.25.1

