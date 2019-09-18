Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23CB64CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfIRNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 09:39:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48900 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIRNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:39:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IDcxka008986;
        Wed, 18 Sep 2019 08:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568813939;
        bh=GZj/q05tMCRtelXeBh7SIXT1Q35bIE60XbTSje8iEJU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fJmggcojKGfON++5HiiMlIImBKf1aezggSLmWHN0d8s6abY+J/EZtCsK6B09pj4dc
         YLyLEWHU/jEA+/wTwo6FGT07hVHU/x3HGmisQcjzg8bJ8u4bsCesKNyv8HhZAZfQD9
         hZIntqnlPJaV28U/Ah1ZXFRb/ihbJGQ3uVCr1yus=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IDcxUa023542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 08:38:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 08:38:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 08:38:58 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IDcocE047879;
        Wed, 18 Sep 2019 08:38:55 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <jejb@linux.ibm.com>,
        Martin K Petersen <martin.petersen@oracle.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Janek Kotas <jank@cadence.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 1/2] dt-bindings: ufs: ti,j721e-ufs.yaml: Add binding for TI UFS wrapper
Date:   Wed, 18 Sep 2019 19:09:20 +0530
Message-ID: <20190918133921.25844-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918133921.25844-1-vigneshr@ti.com>
References: <20190918133921.25844-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of TI wrapper for Cadence UFS Controller.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml

diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
new file mode 100644
index 000000000000..dabd7c795fbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/ti,j721e-ufs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI J721e UFS Host Controller Glue Driver
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,j721e-ufs
+
+  reg:
+    maxItems: 1
+    description: address of TI UFS glue registers
+
+  clocks:
+    maxItems: 1
+    description: phandle to the M-PHY clock
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+
+examples:
+  - |
+    ufs_wrapper: ufs-wrapper@4e80000 {
+       compatible = "ti,j721e-ufs";
+       reg = <0x0 0x4e80000 0x0 0x100>;
+       power-domains = <&k3_pds 277>;
+       clocks = <&k3_clks 277 1>;
+       assigned-clocks = <&k3_clks 277 1>;
+       assigned-clock-parents = <&k3_clks 277 4>;
+       #address-cells = <2>;
+       #size-cells = <2>;
+    };
-- 
2.23.0

