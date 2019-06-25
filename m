Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACC525A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfFYH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:57:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38550 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfFYH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:57:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5P7via3027087;
        Tue, 25 Jun 2019 02:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561449464;
        bh=As+ONbkCNU4vPvK9xrp6+5i2mXu1DnGL8Yu8ve8/bos=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cF3imUKJf0YHIhSNxefsCHDvXJ17WchtoS8URr2UIiU+uj0VQlD+obWw76WB5M4Im
         L1/nmrRZKrjBVH2xDjRjPez0v82SnVaTmzZJUcTnmhS40LUaD4wTFbaK5p9MrQqev5
         iSGAKTEiPpaXgapKhyByzoBgGHxPIy9NPNbpZOJw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5P7vitR092740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jun 2019 02:57:44 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 25
 Jun 2019 02:57:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 25 Jun 2019 02:57:43 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5P7vWTi105511;
        Tue, 25 Jun 2019 02:57:40 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v8 2/5] dt-bindings: mtd: Add binding documentation for HyperFlash
Date:   Tue, 25 Jun 2019 13:27:43 +0530
Message-ID: <20190625075746.10439-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625075746.10439-1-vigneshr@ti.com>
References: <20190625075746.10439-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for HyperFlash devices.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v8:
No changes

 .../devicetree/bindings/mtd/cypress,hyperflash.txt  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt

diff --git a/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
new file mode 100644
index 000000000000..ad42f4db32f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
@@ -0,0 +1,13 @@
+Bindings for HyperFlash NOR flash chips compliant with Cypress HyperBus
+specification and supports Cypress CFI specification 1.5 command set.
+
+Required properties:
+- compatible : "cypress,hyperflash", "cfi-flash" for HyperFlash NOR chips
+- reg : Address of flash's memory map
+
+Example:
+
+	flash@0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x0 0x4000000>;
+	};
-- 
2.22.0

