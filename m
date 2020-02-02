Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480CB14FF54
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 22:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBBVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 16:19:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44694 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgBBVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so5015984plo.11;
        Sun, 02 Feb 2020 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CApnqFg6dAZdHAMhoDwm2LWWZ1aLumfh05lDg8StLtA=;
        b=OdR7OyUhWCueywPWrKoWOPiNpevH5fUhLA9mhQFziQWq6oeHDZvw3DPqt3AaAXOw87
         H2Ngmu5zB3r8ZQ9+/CpWeJhgXhHhJelkA0Hwv4cFPtoZDGel2iNSNB6kaKGdU2s+2b1V
         mGrDOt+jIslxRLg17+fitXzfUuNS7ZZZdyxeCVpb0ytCWlX5GaFZ1JT4S2DM8IJ0NARj
         vvfOSrTTO5DaR5LhvXYx5wsHJqCJA5Xy3WIVKFIZ7kciCBQCtqlYHcBQKC2N+zRfX5qw
         EsSfQPph0HD2I5ck6/tZLixz7xKAN5UpisoszBxuJ3edgvkfq796mihiWeTRFeR8qCKR
         dOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CApnqFg6dAZdHAMhoDwm2LWWZ1aLumfh05lDg8StLtA=;
        b=tHs7wKLKaxS9PQ02cSVu/6wohsBbXAiHstaZoPfe723C/PqQ0tXUUz0lLzkqgHG716
         P/FdW7YErhvFmbnc5wzxJPd2rNmSnlzKnOphYgwF9kVagOe6/a9wemrxSINntKNj4JoB
         Bj6c2aThQSFzNqLkDkDxuY4xBCoSLwKwWa5dNNdJqpDhIndkZxS3wrWYgjxxjjV1fwa2
         YneIA4e7uVOxwj3IspvmmUTp9hxUgIJsxH2TNId6Ab7voZtdnzBa3ZJrUXDhvllNyT1l
         68SX6Br7tybn0dhGXpWFMFDn9OP+DTYzHc5tQ/Od96kLFsc9tbe1jH4sROV35Lnr+ZIf
         d2/A==
X-Gm-Message-State: APjAAAUpJ0aizy6bqW8WtAN5WskPP9VuGpV72C4c8LpD07hOlaCcmfsz
        PPL9YvKSLy4uU+Tv7mmiRtLOFjBP
X-Google-Smtp-Source: APXvYqxHPR3/QXzPWDEAYpCdrDvxmozm3gOtRBBYqdU0CamZVu9N8hjZFtU/72TwTeU9l/DPURiD6w==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr17315291plo.12.1580678349098;
        Sun, 02 Feb 2020 13:19:09 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 07/12] dt-bindings: arm: bcm: Convert BCM23550 to YAML
Date:   Sun,  2 Feb 2020 13:18:22 -0800
Message-Id: <20200202211827.27682-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM23550 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm23550.txt        | 15 ------------
 .../bindings/arm/bcm/brcm,bcm23550.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
deleted file mode 100644
index 080baad923d6..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom BCM23550 device tree bindings
---------------------------------------
-
-This document describes the device tree bindings for boards with the BCM23550
-SoC.
-
-Required root node property:
-  - compatible: brcm,bcm23550
-
-Example:
-	/ {
-		model = "BCM23550 SoC";
-		compatible = "brcm,bcm23550";
-		[...]
-	}
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
new file mode 100644
index 000000000000..7a828ccd24f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm23550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM23550 device tree bindings
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM23550 based boards
+        items:
+          - enum:
+              - brcm,bcm23550-sparrow
+          - const: brcm,bcm23550
+
+...
-- 
2.17.1

