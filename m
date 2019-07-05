Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57760A78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGEQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 12:42:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41772 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfGEQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:35 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so973668ioj.8;
        Fri, 05 Jul 2019 09:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIsUK/A7o9jXe5kJWwnsjnmxD0dE/u9IBMQhPou9+Nw=;
        b=Q6CG6exwaLZMePjLcBSG3rxJKpMEY9pBq+BFiPDcC2TuJVgfKDu0auIp+oKetnU96s
         NvtDAZhc9tzeqRkw4SU2wwq0Ruasd5cwTosUo5kYJpPILVSXGd3uFbdMh+kqZ4uLEWAn
         MjUDg2olJCh1RIMImJN8TMoxnw2igHdDp0Eic3HrZO+MQEWw+778fRZOwOZnmhV01zjE
         tHijvPG0zkoCEBsK2tK80/bDiduKFzEwfycld9kM33ETwML7yLIvb038s5BjT09CzoIl
         IDqroI7FNvGPwAA+9Ro8VvLJbLmZaT/HKelzkaaQC9kbElZC9obfWLVtZDBssjxCiM7n
         ELFA==
X-Gm-Message-State: APjAAAVbkYo9hKqeOE1LR4G+OC4PfRnH/uz+2tIR2gBzcwMimKJkINsK
        1pYvSQXPOVeV6oQOiXq0Fw==
X-Google-Smtp-Source: APXvYqxSXKchEkeCyFw5xuYukonFXjVB9Cg+hG3Hv8gJXgse0AvU6VciMG96yT7QMKO6pTCQoVFEfg==
X-Received: by 2002:a02:bca:: with SMTP id 193mr5789955jad.46.1562344954046;
        Fri, 05 Jul 2019 09:42:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 06/13] dt-bindings: display: Convert pda,91-00156-a0 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:14 -0600
Message-Id: <20190705164221.4462-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pda,91-00156-a0 panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/pda,91-00156-a0.txt         | 14 ---------
 .../display/panel/pda,91-00156-a0.yaml        | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
deleted file mode 100644
index 1639fb17a9f0..000000000000
--- a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-PDA 91-00156-A0 5.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "pda,91-00156-a0"
-- power-supply: this panel requires a single power supply. A phandle to a
-regulator needs to be specified here. Compatible with panel-common binding which
-is specified in the panel-common.txt in this directory.
-- backlight: this panel's backlight is controlled by an external backlight
-controller. A phandle to this controller needs to be specified here.
-Compatible with panel-common binding which is specified in the panel-common.txt
-in this directory.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
new file mode 100644
index 000000000000..ccd3623b4955
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/pda,91-00156-a0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PDA 91-00156-A0 5.0" WVGA TFT LCD panel
+
+maintainers:
+  - Cristian Birsan <cristian.birsan@microchip.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: pda,91-00156-a0
+
+  power-supply: true
+  backlight: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - power-supply
+  - backlight
+
+...
-- 
2.20.1

