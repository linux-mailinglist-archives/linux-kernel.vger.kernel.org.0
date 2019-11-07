Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54508F2E15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 13:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfKGMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 07:21:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35085 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:21:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id y6so1452376lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tXZQK5SdTJcD5DX2NXTTLlsnWvLwQp4hXBzaAdJsJs=;
        b=UJiJ0fjwIKuwCzH+zPZtV0Co4tqdg0CUHNzYt5OW7bM1U/LYZgQRs0QIqlCVL17kAJ
         wJswvXJwH4Z4cK8i2ejta754pexIH0jAoC/5VRwQTZDafB5D/EeEQK8hQZIFDDEI3FMG
         A9wdf5VNNAgdOXAMu4pPYzzhznosW6fQ7/uDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tXZQK5SdTJcD5DX2NXTTLlsnWvLwQp4hXBzaAdJsJs=;
        b=UeU7C0J07AJz/sfWWJmq1NTM0qBr9FMVuwOcNUkHsokF2OiDWfTU2YMaeHthaW1ywN
         40jdCCIK2uKcywJkG1v/5zgsg+UPd+NOQoBI6tOHgw7azhTtokEm/G7w7/RlOMcvez5f
         KFLgjUxRF9T4uFGaNDNv46NdTV8e8CQOEnL7uiU0SMUrahJ4GroqjaYK6vMOcowaL2yw
         dINQfXbCyTGdd49Ny1KT+FJ08poxwM+uedClq50Ow+hi6aVxaloINXPFNidfsWF//c93
         hDvU27k0Ry+3tiO2X/NIOJEnryikb3rPlvLeHKlfrk/Jq4qgpBf2HESlSlWHI5+PpYqg
         Sc6A==
X-Gm-Message-State: APjAAAWnMVnuxjqtPQsLOPBayIeGdMgLc1Gdq+rb70hCa905p00OEUyk
        naXC9ijbO3jCR7ENuKMb+6ndeA==
X-Google-Smtp-Source: APXvYqxOsh6ghB+HkVRCN5O3T/3eX6xBx4s/DDazzhWhjBycyqCiGhP7dPrrxDp70yeGBoe/hMHhXA==
X-Received: by 2002:a19:98e:: with SMTP id 136mr2189671lfj.27.1573129279668;
        Thu, 07 Nov 2019 04:21:19 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x1sm1937325lff.90.2019.11.07.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:21:19 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v7 1/2] dt/bindings: Add bindings for Layerscape external irqs
Date:   Thu,  7 Nov 2019 13:21:14 +0100
Message-Id: <20191107122115.6244-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Device Tree binding documentation for the external interrupt
lines with configurable polarity present on some Layerscape SOCs.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../interrupt-controller/fsl,ls-extirq.txt    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
new file mode 100644
index 000000000000..f0ad7801e8cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -0,0 +1,49 @@
+* Freescale Layerscape external IRQs
+
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+the polarity of certain external interrupt lines.
+
+The device node must be a child of the node representing the
+Supplemental Configuration Unit (SCFG).
+
+Required properties:
+- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+- #interrupt-cells: Must be 2. The first element is the index of the
+  external interrupt line. The second element is the trigger type.
+- #address-cells: Must be 0.
+- interrupt-controller: Identifies the node as an interrupt controller
+- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
+  the SCFG.
+- interrupt-map: Specifies the mapping from external interrupts to GIC
+  interrupts.
+- interrupt-map-mask: Must be <0xffffffff 0>.
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg", "syscon";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+		big-endian;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x1570000 0x10000>;
+
+		extirq: interrupt-controller@1ac {
+			compatible = "fsl,ls1021a-extirq";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x1ac 4>;
+			interrupt-map =
+				<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0xffffffff 0x0>;
+		};
+	};
+
+
+	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
-- 
2.23.0

