Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407EDF700F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfKKJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:03:52 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:40280 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbfKKJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:03:52 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAB937D7060732
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Nov 2019 17:03:08 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.88) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 11 Nov 2019 17:03:26
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: Convert sprd board/soc bindings to json-schema
Date:   Mon, 11 Nov 2019 17:02:26 +0800
Message-ID: <20191111090230.3402-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.88]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAB937D7060732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Convert Unisoc (formerly Spreadtrum) SoC bindings to DT schema format
using json-schema.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/arm/sprd.txt          | 14 ---------
 .../devicetree/bindings/arm/sprd.yaml         | 29 +++++++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.yaml

diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
deleted file mode 100644
index 3df034b13e28..000000000000
--- a/Documentation/devicetree/bindings/arm/sprd.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Spreadtrum SoC Platforms Device Tree Bindings
-----------------------------------------------------
-
-SC9836 openphone Board
-Required root node properties:
-	- compatible = "sprd,sc9836-openphone", "sprd,sc9836";
-
-SC9860 SoC
-Required root node properties:
-	- compatible = "sprd,sc9860"
-
-SP9860G 3GFHD Board
-Required root node properties:
-	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
diff --git a/Documentation/devicetree/bindings/arm/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd.yaml
new file mode 100644
index 000000000000..8540758188d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sprd.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sprd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc platforms device tree bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sprd,sc9836-openphone
+          - const: sprd,sc9836
+      - items:
+          - enum:
+              - sprd,sp9860g-1h10
+          - const: sprd,sc9860
+
+...
-- 
2.20.1


