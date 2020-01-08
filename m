Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B2134041
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgAHLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:18:48 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45310 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgAHLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:18:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008BIiOi125874;
        Wed, 8 Jan 2020 05:18:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578482324;
        bh=SP4EnpeM6GGBv5vJGSKWMvGveJi/0lQQ/mLpvMFlKa8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u2cauyRl6FSe2eAiALYEAf7qHVidCGqfPIw9zhUUI1I2znqSJ1bKOe4oSbzXIuyLg
         P8A2YttJty2OeDSzBvtIwxhB81JggkRhCFu2VpxtxEHOaI9lcEdMttpDH/O0KNCUMu
         Mm6zzFwRKR/42KXAmslehTAfuRGJbfY+zsZZP7R8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008BIicK019473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 05:18:44 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 05:18:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 05:18:42 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008BIWBs087830;
        Wed, 8 Jan 2020 05:18:40 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <kishon@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/5] arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
Date:   Wed, 8 Jan 2020 13:18:28 +0200
Message-ID: <20200108111830.8482-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108111830.8482-1-rogerq@ti.com>
References: <20200108111830.8482-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controllers can be connected to one of the 2 SERDESes
using a MUX. Add a MUX controller node fot that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 6741c1e67f50..7c60f8ec6365 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -43,6 +43,13 @@
 				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
 				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
 		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
+					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
+	    };
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

