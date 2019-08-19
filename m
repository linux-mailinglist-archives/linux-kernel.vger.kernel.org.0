Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC794C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHSSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 14:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfHSSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:20:44 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01D322CEC;
        Mon, 19 Aug 2019 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566238843;
        bh=wxa0LM+vbYgrtuVee7cNQSHuuhlDUGgp7HsBhgwY8lw=;
        h=From:To:Cc:Subject:Date:From;
        b=wJPMkzpuVMW30mhPXbQA+lPzUB8RQ6OFsUg73VIaASOVTa1u6x+8ghSzvaBzyymQE
         EvPM91etkr5FCYpHVTUjo3XnQYyDeq/u4K+6ymdS0lMbIdlF8JtPxjOjmWN8yB61+7
         P6ckND1tXUKFF+UqeZW/ZHfla1lgoUnEyvGAKyJQ=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 1/6] dt-bindings: watchdog: Add YAML schemas for the generic watchdog bindings
Date:   Mon, 19 Aug 2019 20:20:34 +0200
Message-Id: <20190819182039.24892-1-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The watchdogs have a bunch of generic properties that are needed in a
device tree. Add a YAML schemas for those.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - New patch
---
 .../bindings/watchdog/watchdog.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
new file mode 100644
index 000000000000..187bf6cb62bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog Generic Bindings
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+  - Wim Van Sebroeck <wim@linux-watchdog.org>
+
+description: |
+  This document describes generic bindings which can be used to
+  describe watchdog devices in a device tree.
+
+properties:
+  $nodename:
+    pattern: "^watchdog(@.*|-[0-9a-f])?$"
+
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Contains the watchdog timeout in seconds.
+
+...
-- 
2.21.0

