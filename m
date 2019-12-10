Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4ED1183FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLJJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:51:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56080 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfLJJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:51:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9owrk106268;
        Tue, 10 Dec 2019 03:50:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575971458;
        bh=MfWya5aicGH35XYex+3ymz/ai8GWU/T+c9dAxVtpNcM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C/FLMudia64vPRtdhsIeyR7RR86QOQUXVrOKnTMhOjmRLUGPJztVNx0yPCJ4c1nEB
         XmZbQwP2qmieQuKZr/tqXzkhLg48GSMTPxK59O8SYbl4wCyUqEDp4gMMScNxm7OIjE
         y6+CnRSpCphzw+q5mMoZabA9A7PTpOIeNKuaBCvA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9ow7D090827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:50:58 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:50:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:50:57 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9oZVp048503;
        Tue, 10 Dec 2019 03:50:55 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>,
        <zhang.chunyan@linaro.org>, <tony@atomide.com>
Subject: [PATCH v3 6/7] dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
Date:   Tue, 10 Dec 2019 15:21:50 +0530
Message-ID: <20191210095151.15441-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20191210095151.15441-1-faiz_abbas@ti.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the TI's sdhci-omap controller present in am335x and
am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 97efb01617dd..aeb615ef672a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -7,6 +7,8 @@ For UHS devices which require tuning, the device tree should have a "cpu_thermal
 Required properties:
 - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
 	      Should be "ti,k2g-sdhci" for K2G
+	      Should be "ti,am335-sdhci" for am335x controllers
+	      Should be "ti,am437-sdhci" for am437x controllers
 - ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
 	     (Not required for K2G).
 - pinctrl-names: Should be subset of "default", "hs", "sdr12", "sdr25", "sdr50",
-- 
2.19.2

