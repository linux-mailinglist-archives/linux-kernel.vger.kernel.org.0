Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC3D8F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404986AbfJPLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:31:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34130 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJPLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:31:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVpiR081740;
        Wed, 16 Oct 2019 06:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571225512;
        bh=e0YayVxzp9YRkb/qZ5M6BWpMFRqKluTwEWlVTH+xULs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QjaNmx484A0/My3VCebaQEofBHk/TRiNX77Q06hLQex3hTZPd7cFS+irKO+cNjkco
         hGJ4xWaJRg4kNT7kMje2UIw31BHuSZPB4bqNxmpGtOHLgIgoZk8KLQ+RYjZDHs7UxL
         scchlHyhzy9M0B3phP4rVxmKt/MaiqGsAO3acAbU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GBVp4Y037502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 06:31:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 06:31:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 06:31:51 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVkm5097485;
        Wed, 16 Oct 2019 06:31:49 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 01/13] dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
Date:   Wed, 16 Oct 2019 17:01:05 +0530
Message-ID: <20191016113117.12370-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016113117.12370-1-kishon@ti.com>
References: <20191016113117.12370-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY IP used in TI's J721E
SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.txt  | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
index 6e1b47bfce43..bf90ef7e005e 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
@@ -2,21 +2,24 @@ Cadence Sierra PHY
 -----------------------
 
 Required properties:
-- compatible:	cdns,sierra-phy-t0
-- clocks:	Must contain an entry in clock-names.
-		See ../clocks/clock-bindings.txt for details.
-- clock-names:	Must be "phy_clk"
+- compatible:	Must be "cdns,sierra-phy-t0" for Sierra in Cadence platform
+		Must be "ti,sierra-phy-t0" for Sierra in TI's J721E SoC.
 - resets:	Must contain an entry for each in reset-names.
 		See ../reset/reset.txt for details.
 - reset-names:	Must include "sierra_reset" and "sierra_apb".
 		"sierra_reset" must control the reset line to the PHY.
 		"sierra_apb" must control the reset line to the APB PHY
-		interface.
+		interface ("sierra_apb" is optional).
 - reg:		register range for the PHY.
 - #address-cells: Must be 1
 - #size-cells:	Must be 0
 
 Optional properties:
+- clocks:		Must contain an entry in clock-names.
+			See ../clocks/clock-bindings.txt for details.
+- clock-names:		Must be "phy_clk". Must contain "cmn_refclk" and
+			"cmn_refclk1" for configuring the frequency of the
+			clock to the lanes.
 - cdns,autoconf:	A boolean property whose presence indicates that the
 			PHY registers will be configured by hardware. If not
 			present, all sub-node optional properties must be
-- 
2.17.1

