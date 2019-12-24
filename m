Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6012A1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 09:06:00 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49841 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:05:59 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 36693240008;
        Tue, 24 Dec 2019 14:05:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/3] dt-bindings: display: Add Satoz panel
Date:   Tue, 24 Dec 2019 15:05:50 +0100
Message-Id: <20191224140551.21227-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224140551.21227-1-miquel.raynal@bootlin.com>
References: <20191224140551.21227-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satoz is a Chinese TFT manufacturer.
Website: http://www.sat-sz.com/English/index.html

Add (simple) bindings for its SAT050AT40H12R2 5.0 inch LCD panel.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
* New patch

 .../display/panel/satoz,sat050at40h12r2.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
new file mode 100644
index 000000000000..567b32a544f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/satoz,sat050at40h12r2#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Satoz SAT050AT40H12R2 panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  LCD 5.0 inch 800x480 RGB panel.
+
+  This binding is compatible with the simple-panel binding, which is specified
+  in simple-panel.txt in this directory.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: satoz,sat050at40h12r2
+
+required:
+  - compatible
-- 
2.20.1

