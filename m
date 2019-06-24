Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4E51DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 23:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfFXV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 17:59:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40495 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbfFXV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:07 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so294727ioc.7;
        Mon, 24 Jun 2019 14:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfDOCB2rzGjSjqpQ2I0Ij8EWWsXmK+v4TaSJDZJlQ7s=;
        b=dKpREGkaO5XBMlwGZ9HqhfRwpOJlCoaTQedfLA/lZTFMafyl6Zq/f2ZNMvw+dttytH
         E1dfnnWWZDhH7RDjx9zPotXgydZ8BqAHsS3vtw5/2OnZCWOLg46g9CVdDKDsy75UPNKy
         YPSISl1ikcCJCW5Kwf+1LqNr+GT20DAx+UcQUAT648x8cED/pu7SjN40d6hYlofyBoIm
         jwrlkYFL4TLczQCo7NS4lZMOebv2hhi88V64jV0tHHZjHqZaTcHxu1QA4atKx5p708mF
         7GGTTRxShG4BAJy3is0bmqpFWQNswLKMUAHjh/fJUDbRse/n8eHI3ThFA55h8ZFtO9pP
         FwUQ==
X-Gm-Message-State: APjAAAVMTJEJp4slNr30pBMIM03faMqTukDgOFAwugLKP3WvMuJEdKHX
        DFerP0KZqMoGrUqPO8i8Ug==
X-Google-Smtp-Source: APXvYqxQu62ixrC8OgFI1/RgunflqfM7g1MuGaK+YHtYE+Vaj05i8aSEnxMGPMRNuNjvjr8+/gcZjQ==
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr70657931iod.145.1561413545939;
        Mon, 24 Jun 2019 14:59:05 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH v2 09/15] dt-bindings: display: Convert tfc,s9700rtwv43tr-01b panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:43 -0600
Message-Id: <20190624215649.8939-10-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the tfc,s9700rtwv43tr-01b panel binding to DT schema.

Cc: Heiko Stuebner <heiko.stuebner@bq.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/tfc,s9700rtwv43tr-01b.txt   | 15 ----------
 .../display/panel/tfc,s9700rtwv43tr-01b.yaml  | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
deleted file mode 100644
index dfb572f085eb..000000000000
--- a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with
-resistive touch
-
-The panel is found on TI AM335x-evm.
-
-Required properties:
-- compatible: should be "tfc,s9700rtwv43tr-01b"
-- power-supply: See panel-common.txt
-
-Optional properties:
-- enable-gpios: GPIO pin to enable or disable the panel, if there is one
-- backlight: phandle of the backlight device attached to the panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
new file mode 100644
index 000000000000..614f4a8d8403
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tfc,s9700rtwv43tr-01b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with resistive touch
+
+maintainers:
+  - Jyri Sarha <jsarha@ti.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  The panel is found on TI AM335x-evm.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: tfc,s9700rtwv43tr-01b
+
+  enable-gpios: true
+  backlight: true
+
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.20.1

