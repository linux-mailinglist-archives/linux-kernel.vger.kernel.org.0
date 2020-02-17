Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA1160B53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBQG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:58:21 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:57641 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:58:16 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 01H6ug7R005796;
        Mon, 17 Feb 2020 14:56:44 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de,
        juliensu@mxic.com.tw, frieder.schrempf@kontron.de,
        allison@lohutok.net, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, yuehaibing@huawei.com,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix NAND device bindings
Date:   Mon, 17 Feb 2020 14:56:40 +0800
Message-Id: <1581922600-25461-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581922600-25461-1-git-send-email-masonccyang@mxic.com.tw>
References: <1581922600-25461-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 01H6ug7R005796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix NAND device.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/nand-macronix.txt      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt

diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
new file mode 100644
index 0000000..1d7a895
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
@@ -0,0 +1,28 @@
+Macronix NANDs Device Tree Bindings
+-----------------------------------
+
+Macronix NANDs support randomizer operation for user data scrambled,
+which can be enabled with a SET_FEATURE. The penalty of randomizer are
+subpage accesses prohibited and more time period is needed in program
+operation, i.e., tPROG 300us to 340us(randomizer enabled).
+Randomizer enabled is a one time persistent and non reversible operatoin.
+
+For more high-reliability concern, if subpage write not available with
+hardware ECC and filesystem and then to enable randomizer is recommended
+by default.
+
+By adding a new specific property in children nodes to enable
+randomizer function.
+
+Required NAND chip properties in children mode:
+- randomizer enable: should be "mxic,enable-randomizer-otp"
+
+Example:
+
+	nand: nand-controller@unit-address {
+
+		nand@0 {
+			reg = <0>;
+			mxic,enable-randomizer-otp;
+		};
+	};
-- 
1.9.1

