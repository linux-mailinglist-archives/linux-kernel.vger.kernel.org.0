Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611C995993
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfHTI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 04:29:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:48912 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfHTI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:29:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 01:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="353508425"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2019 01:29:13 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/2] dt-bindings: lantiq: Update for new SoC
Date:   Tue, 20 Aug 2019 16:29:02 +0800
Message-Id: <fa6b20015dc6bfe247e1b2a07bdc5c727595a04b.1566288689.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566288689.git.rahul.tanwar@linux.intel.com>
References: <cover.1566288689.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566288689.git.rahul.tanwar@linux.intel.com>
References: <cover.1566288689.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
Update the dt bindings to support LGM as well.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
index 54b90490f4fb..92807b59b024 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       items:
         - const: lantiq,asc
+        - const: intel,lgm-asc
 
   reg:
     maxItems: 1
@@ -28,6 +29,12 @@ properties:
       - description: tx or combined interrupt
       - description: rx interrupt
       - description: err interrupt
+    description:
+      For lantiq,asc compatible, it supports 3 separate
+      interrupts for tx rx & err. Whereas, for intel,lgm-asc
+      compatible, it supports combined single interrupt for
+      all of tx, rx & err interrupts.
+
 
   clocks:
     description:
@@ -67,4 +74,14 @@ examples:
             interrupts = <112 113 114>;
     };
 
+  - |
+    asc0: serial@e0a00000 {
+            compatible = "intel,lgm-asc";
+            reg = <0xe0a00000 0x1000>;
+            interrupt-parent = <&ioapic1>;
+            interrupts = <128 1>;
+            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
+            clock-names = "freq", "asc";
+    };
+
 ...
-- 
2.11.0

