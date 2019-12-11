Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9711A534
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 08:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfLKHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 02:39:56 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:17081 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKHj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:39:56 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id xBB7dDR3022506;
        Wed, 11 Dec 2019 16:39:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com xBB7dDR3022506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576049954;
        bh=l8+Ln+RuifKBW/SrlAVL5xQ74EcUovKtu9zNI0gHngc=;
        h=From:To:Cc:Subject:Date:From;
        b=eWqSG3g1T8eqyALzmsPUhkRNZCG6VFecW178bWzSJs+Bd5uRbMl7C7PoLTw1yf0SP
         U7X6ezM2sV5QkE01BjDCrw1zX4yIYTEUBngzlIJbQsrwk719CN1PjPCMet1jgezxKh
         2fHR0vLij6Vs5GSX7GfWI22UkQ2fRB2DsQZfjyaEAhEWWhmlFwF0h+Ux1rhUndsNb2
         Sc5HZgSP13Ia+QLvs2LA/5VTYqzxZ6BnwQqwy3z3KEGvlHdTvB7Yi4EDcCEOv7xeOz
         PV/8P3W1xb1iVSCesCCrxcG7OZqYpvJwb2HueLRuGZwjvxNU7CvNiACN1/QTpLQCTM
         Lr+Zdkb9Vtmnw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-usb@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: move choice ... endchoice to legacy/Kconfig
Date:   Wed, 11 Dec 2019 16:38:57 +0900
Message-Id: <20191211073857.16780-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/gadget/Kconfig includes drivers/usb/gadget/legacy/Kconfig
inside the 'choice' block. The current Kconfig allows this, but I'd
like to discourage this usage.

People tend to mess up the structure without noticing that entire
drivers/usb/gadget/legacy/Kconfig is placed in the choice context.
In fact, legacy/Kconfig mixes up bool and tristate in the choice,
and creates nested choice, etc.

This commit does not change the behavior, but it will help people
notice how badly this Kconfig file is written.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/usb/gadget/Kconfig        | 28 ----------------------------
 drivers/usb/gadget/legacy/Kconfig | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 02ff850278b1..c6db0a0a340c 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -483,34 +483,6 @@ config USB_CONFIGFS_F_TCM
 	  Both protocols can work on USB2.0 and USB3.0.
 	  UAS utilizes the USB 3.0 feature called streams support.
 
-choice
-	tristate "USB Gadget precomposed configurations"
-	default USB_ETH
-	optional
-	help
-	  A Linux "Gadget Driver" talks to the USB Peripheral Controller
-	  driver through the abstract "gadget" API.  Some other operating
-	  systems call these "client" drivers, of which "class drivers"
-	  are a subset (implementing a USB device class specification).
-	  A gadget driver implements one or more USB functions using
-	  the peripheral hardware.
-
-	  Gadget drivers are hardware-neutral, or "platform independent",
-	  except that they sometimes must understand quirks or limitations
-	  of the particular controllers they work with.  For example, when
-	  a controller doesn't support alternate configurations or provide
-	  enough of the right types of endpoints, the gadget driver might
-	  not be able work with that controller, or might need to implement
-	  a less common variant of a device class protocol.
-
-	  The available choices each represent a single precomposed USB
-	  gadget configuration. In the device model, each option contains
-	  both the device instantiation as a child for a USB gadget
-	  controller, and the relevant drivers for each function declared
-	  by the device.
-
 source "drivers/usb/gadget/legacy/Kconfig"
 
-endchoice
-
 endif # USB_GADGET
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index 119a4e47681f..6e7e1a9202e6 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -14,6 +14,32 @@
 # both kinds of controller can also support "USB On-the-Go" (CONFIG_USB_OTG).
 #
 
+choice
+	tristate "USB Gadget precomposed configurations"
+	default USB_ETH
+	optional
+	help
+	  A Linux "Gadget Driver" talks to the USB Peripheral Controller
+	  driver through the abstract "gadget" API.  Some other operating
+	  systems call these "client" drivers, of which "class drivers"
+	  are a subset (implementing a USB device class specification).
+	  A gadget driver implements one or more USB functions using
+	  the peripheral hardware.
+
+	  Gadget drivers are hardware-neutral, or "platform independent",
+	  except that they sometimes must understand quirks or limitations
+	  of the particular controllers they work with.  For example, when
+	  a controller doesn't support alternate configurations or provide
+	  enough of the right types of endpoints, the gadget driver might
+	  not be able work with that controller, or might need to implement
+	  a less common variant of a device class protocol.
+
+	  The available choices each represent a single precomposed USB
+	  gadget configuration. In the device model, each option contains
+	  both the device instantiation as a child for a USB gadget
+	  controller, and the relevant drivers for each function declared
+	  by the device.
+
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
 	select USB_LIBCOMPOSITE
@@ -489,3 +515,5 @@ config USB_G_WEBCAM
 
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_webcam".
+
+endchoice
-- 
2.17.1

