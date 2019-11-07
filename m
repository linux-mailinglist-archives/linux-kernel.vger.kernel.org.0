Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2FBF3112
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfKGOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:14:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKGOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so3227195wrx.3;
        Thu, 07 Nov 2019 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qQkdWA3lEACt86S/mJnBmrJY3yzrUI9GeVd03ddadsY=;
        b=VoLRxi9IDpuxSev8FNUDfJpD12TV+crO/pzmDpaXQ0r3GwZZcojN6YJxBLkrkLLF3H
         T7TU0e30KcCMebo0TE5ncftiMNe3ktJvIVHXb3QRqZ7q4GYQJkQnImzZsUqWKlLZqI9i
         tQlTH5tryNOHGl52CXDN9qMvWGrR9H5Gg878WtRu7Coez/7W1uDOhHgY97OOEgjblq8q
         mTEegIqL0oG6rCjWdBNlhatVko4+jmzfVPMgILv+V/4LfoTExf6skBH6dFOt/6bLwHE1
         x8P9dhmLHxzjluSAF5yH9swpr1vo9NyIp1/Y1xmsrOzF6J/ea2G5BHheRV60FJr4Re07
         dPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qQkdWA3lEACt86S/mJnBmrJY3yzrUI9GeVd03ddadsY=;
        b=h0vYBblA/k874jzv9qSdP+EFepGGDn7Kib+HL/TITRC/EsxzX37bmGKcj7MZfxgsbF
         KI9dVMY0Db/nUbeZiW+aaWJ6fqCgS9He8YxsoUU3m49esuO87ciECxX11EkGLCrYzOu3
         Z5CX+yU1oDAlTxq1kjchROXY6eWoo+qpPT7SM+dIolltMNGZHLtTVoKa1LN8fo6TjgII
         2fD1dh4V0u8qnfDGKoKiKJOEpJi1eIvQMO246fkANEHpQ+3p++OU08wY2y7dakj+jJv/
         2cuiChoVbJP/f7q1WWJunbstj6Il6po/E3JqDowV/0mqaX87YNj7bTNFEzodQsHUf5Fj
         7SRA==
X-Gm-Message-State: APjAAAWcYo/QP8I5cuoETKllnNQ4mEYQWaf+QW/vVNRUFAs16RTxyLs0
        7VrnoJwKy39Deqdp+6al/tmZOdavH2o=
X-Google-Smtp-Source: APXvYqyc97f2zDaE8qWrIrt73DXXVKDZIoU3NdVG2oVHvWOjSCUv7QWvznDFgRq5lMGCPSVR2imCmQ==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr773979wrj.185.1573136080477;
        Thu, 07 Nov 2019 06:14:40 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:40 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 06/13] dt-bindings: Add Broadcom STB USB PHY binding document
Date:   Thu,  7 Nov 2019 09:13:32 -0500
Message-Id: <20191107141339.6079-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for bcm7216 and bcm7211

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/phy/brcm,brcmstb-usb-phy.txt     | 69 +++++++++++++++----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
index 24a0d06acd1d..14184cec15dc 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
@@ -1,30 +1,49 @@
 Broadcom STB USB PHY
 
 Required properties:
- - compatible: brcm,brcmstb-usb-phy
- - reg: two offset and length pairs.
-	The first pair specifies a manditory set of memory mapped
-	registers used for general control of the PHY.
-	The second pair specifies optional registers used by some of
-	the SoCs that support USB 3.x
- - #phy-cells: Shall be 1 as it expects one argument for setting
-	       the type of the PHY. Possible values are:
-	       - PHY_TYPE_USB2 for USB1.1/2.0 PHY
-	       - PHY_TYPE_USB3 for USB3.x PHY
+- compatible: should be one of
+	"brcm,brcmstb-usb-phy"
+	"brcm,bcm7216-usb-phy"
+	"brcm,bcm7211-usb-phy"
+
+- reg and reg-names properties requirements are specific to the
+  compatible string.
+  "brcm,brcmstb-usb-phy":
+    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
+           and an optional pair for systems with USB 3.x support
+    - reg-names: not specified
+  "brcm,bcm7216-usb-phy":
+    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
+           registers
+    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
+  "brcm,bcm7211-usb-phy":
+    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
+           USB_PHY and USB_MDIO registers and an optional pair
+	   for the BDC registers
+    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
+
+- #phy-cells: Shall be 1 as it expects one argument for setting
+	      the type of the PHY. Possible values are:
+	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
+	      - PHY_TYPE_USB3 for USB3.x PHY
 
 Optional Properties:
 - clocks : clock phandles.
 - clock-names: String, clock name.
+- interrupts: wake interrupt
+- interrupt-names: "wake"
 - brcm,ipp: Boolean, Invert Port Power.
   Possible values are: 0 (Don't invert), 1 (Invert)
 - brcm,ioc: Boolean, Invert Over Current detection.
   Possible values are: 0 (Don't invert), 1 (Invert)
-NOTE: one or both of the following two properties must be set
-- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
-- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
 - dr_mode: String, PHY Device mode.
   Possible values are: "host", "peripheral ", "drd" or "typec-pd"
   If this property is not defined, the phy will default to "host" mode.
+- syscon-piarbctl: phandle to syscon for handling config registers
+NOTE: one or both of the following two properties must be set
+- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
+- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
+
 
 Example:
 
@@ -41,3 +60,27 @@ usbphy_0: usb-phy@f0470200 {
 	clocks = <&usb20>, <&usb30>;
 	clock-names = "sw_usb", "sw_usb3";
 };
+
+usb-phy@29f0200 {
+	reg = <0x29f0200 0x200>,
+		<0x29c0880 0x30>,
+		<0x29cc100 0x534>,
+		<0x2808000 0x24>,
+		<0x2980080 0x8>;
+	reg-names = "ctrl",
+		"xhci_ec",
+		"xhci_gbl",
+		"usb_phy",
+		"usb_mdio";
+	brcm,ioc = <0x0>;
+	brcm,ipp = <0x0>;
+	compatible = "brcm,bcm7211-usb-phy";
+	interrupts = <0x30>;
+	interrupt-parent = <&vpu_intr1_nosec_intc>;
+	interrupt-names = "wake";
+	#phy-cells = <0x1>;
+	brcm,has-xhci;
+	syscon-piarbctl = <&syscon_piarbctl>;
+	clocks = <&scmi_clk 256>;
+	clock-names = "sw_usb";
+};
-- 
2.17.1

