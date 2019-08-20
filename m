Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3696445
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfHTPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:25:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46167 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfHTPZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:25:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i060j-00088F-U1; Tue, 20 Aug 2019 17:25:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i060b-0000UV-79; Tue, 20 Aug 2019 17:25:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC] dt-bindings: regulator: define a mux regulator
Date:   Tue, 20 Aug 2019 17:25:11 +0200
Message-Id: <20190820152511.15307-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mux regulator is used to provide current on one of several outputs. It
might look as follows:

      ,------------.
    --<OUT0     A0 <--
    --<OUT1     A1 <--
    --<OUT2     A2 <--
    --<OUT3        |
    --<OUT4     EN <--
    --<OUT5        |
    --<OUT6     IN <--
    --<OUT7        |
      `------------'

Depending on which address is encoded on the three address inputs A0, A1
and A2 the current provided on IN is provided on one of the eight
outputs.

What is new here is that the binding makes use of a #regulator-cells
property. This uses the approach known from other bindings (e.g. gpio)
to allow referencing all eight outputs with phandle arguments. This
requires an extention in of_get_regulator to use a new variant of
of_parse_phandle_with_args that has a cell_count_default parameter that
is used in absence of a $cell_name property. Even if we'd choose to
update all regulator-bindings to add #regulator-cells = <0>; we still
needed something to implement compatibility to the currently defined
bindings.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the obvious alternative is to add (here) eight subnodes to represent the
eight outputs. This is IMHO less pretty, but wouldn't need to introduce
#regulator-cells.

Apart from reg = <..> and a phandle there is (I think) nothing that
needs to be specified in the subnodes because all properties of an
output (apart from the address) apply to all outputs.

What do you think?

Best regards
Uwe

 .../bindings/regulator/mux-regulator.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mux-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mux-regulator.yaml b/Documentation/devicetree/bindings/regulator/mux-regulator.yaml
new file mode 100644
index 000000000000..f06dbb969090
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mux-regulator.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mux-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MUX regulators
+
+properties:
+  compatible:
+    const: XXX,adb708
+
+  enable-gpios:
+    maxItems: 1
+
+  address-gpios:
+    description: Array of typically three GPIO pins used to select the
+      regulator's output. The least significant address GPIO must be listed
+      first. The others follow in order of significance.
+    minItems: 1
+
+  "#regulator-cells":
+    const: 1
+
+  regulator-name:
+    description: A string used to construct the sub regulator's names
+    $ref: "/schemas/types.yaml#/definitions/string"
+
+  supply:
+    description: input supply
+
+required:
+  - compatible
+  - regulator-name
+  - supply
+  
+
+examples:
+  - |
+    mux-regulator {
+      compatible = "regulator-mux";
+
+      regulator-name = "blafasel";
+
+      supply = <&muxin_regulator>;
+
+      enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+      address-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>,
+                        <&gpio2 3 GPIO_ACTIVE_HIGH>,
+                        <&gpio2 4 GPIO_ACTIVE_HIGH>,
+    };
+...
-- 
2.20.1

