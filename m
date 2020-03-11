Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63938181B87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 15:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgCKOl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 10:41:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgCKOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:41:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02BEfKo7103742;
        Wed, 11 Mar 2020 09:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583937680;
        bh=oRjWnok7UIPiyxHIO3B2i6YgljHO5Qr97OJNTqojet0=;
        h=From:To:CC:Subject:Date;
        b=Wf2ahhejV+C15Njyw4PX/2XHJji0YKivKzqwaNr24pOxTtjx1puUwy/uqi0JTdey3
         2RF0kfnGQl5AzH0x4Z+7MCWHyteyy+geUY8wUxbt4/L5RnbgJIRdz6A1kBGLu48y9C
         dkght+ys7KH0KHFwCiDOQBhQMeKuOD2iVMogIiOI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02BEfKDS022778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 09:41:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 09:41:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 09:41:19 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02BEfH6F043022;
        Wed, 11 Mar 2020 09:41:17 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <d-gerlach@ti.com>, <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, <stable@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am65: Add clocks to dwc3 nodes
Date:   Wed, 11 Mar 2020 16:41:11 +0200
Message-ID: <20200311144111.7112-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

The TI sci-clk driver can scan the DT for all clocks provided by system
firmware and does this by checking the clocks property of all nodes, so
we must add this to the dwc3 nodes so USB clocks are available.

Without this USB does not work with latest system firmware i.e.
[    1.714662] clk: couldn't get parent clock 0 for /interconnect@100000/dwc3@4020000

Fixes: cc54a99464ccd ("arm64: dts: ti: k3-am6: add USB suppor")
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Cc: stable@kernel.org
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e5df20a2d2f9..d86c5c7b82fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -296,6 +296,7 @@
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		dma-coherent;
 		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
 		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
 		assigned-clock-parents = <&k3_clks 151 4>,	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
 					 <&k3_clks 151 9>;	/* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
@@ -335,6 +336,7 @@
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 		dma-coherent;
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 152 2>;
 		assigned-clocks = <&k3_clks 152 2>;
 		assigned-clock-parents = <&k3_clks 152 4>;	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

