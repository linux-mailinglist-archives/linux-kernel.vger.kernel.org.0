Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEA26078
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfEVJ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 05:26:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54376 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729000AbfEVJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:26:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08448831|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.503012-0.0276285-0.469359;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.EbUB1X0_1558517209;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EbUB1X0_1558517209)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 22 May 2019 17:26:49 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Rob Herring <robh+dt@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: csky: Add csky PMU bindings
Date:   Wed, 22 May 2019 17:25:31 +0800
Message-Id: <2e6e6d4b8f002900a3872105a9284d7dd562c82b.1558516765.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558516765.git.han_mao@c-sky.com>
References: <cover.1558516765.git.han_mao@c-sky.com>
In-Reply-To: <cover.1558516765.git.han_mao@c-sky.com>
References: <cover.1558516765.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation to describe that how to add pmu node in
dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 Documentation/devicetree/bindings/csky/pmu.txt | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

diff --git a/Documentation/devicetree/bindings/csky/pmu.txt b/Documentation/devicetree/bindings/csky/pmu.txt
new file mode 100644
index 0000000..6d3cba3
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/pmu.txt
@@ -0,0 +1,38 @@
+============================
+C-SKY Performance Monitor Units
+============================
+
+C-SKY 8xx series cores often have a PMU for counting cpu and cache events.
+The C-SKY PMU representation in the device tree should be done as under:
+
+==============================
+PMU node bindings definition
+==============================
+
+	Description: Describes PMU
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,csky-pmu"
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be pmu irq num defined by soc
+	- reg-io-width
+		Usage: optional
+		Value type: <u32>
+		Definition: the width of pmu counter
+
+Examples:
+---------
+
+        pmu {
+                compatible = "csky,csky-pmu";
+                interrupts = <0x17>;
+                interrupt-parent = <&intc>;
+		reg-io-width = <0x30>;
+        };
+
-- 
2.7.4

