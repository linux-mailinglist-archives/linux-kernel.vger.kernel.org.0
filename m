Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA110530B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKUN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfKUN3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:19 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45C52070B;
        Thu, 21 Nov 2019 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342958;
        bh=182E69orGVAr6uDhiU/Wa8kfY2L4r3LvkNVQrldlYAk=;
        h=From:To:Cc:Subject:Date:From;
        b=fIC3mT5QdPx0VRaXrx5GuimHdvBlw+y0s12AhH0mfcYE77QLljgpbWykSDfntBCCT
         nR6M/+jfNk6duL62WMBFCsC6VsvrA81o1niQLD5e/kn5Py3ppaINOQyFR7ipOvN2BG
         /ifLyLcEESAx/H+a3laaTyk54Dx4371LiH2bk4yY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:14 +0800
Message-Id: <20191121132914.29368-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/dwc3/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 0d97e6bfaf36..206caa0ea1c6 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -97,24 +97,24 @@ config USB_DWC3_KEYSTONE
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_MESON_G12A
-       tristate "Amlogic Meson G12A Platforms"
-       depends on OF && COMMON_CLK
-       depends on ARCH_MESON || COMPILE_TEST
-       default USB_DWC3
-       select USB_ROLE_SWITCH
+	tristate "Amlogic Meson G12A Platforms"
+	depends on OF && COMMON_CLK
+	depends on ARCH_MESON || COMPILE_TEST
+	default USB_DWC3
+	select USB_ROLE_SWITCH
 	select REGMAP_MMIO
-       help
-	 Support USB2/3 functionality in Amlogic G12A platforms.
-	 Say 'Y' or 'M' if you have one such device.
+	help
+	  Support USB2/3 functionality in Amlogic G12A platforms.
+	  Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_OF_SIMPLE
-       tristate "Generic OF Simple Glue Layer"
-       depends on OF && COMMON_CLK
-       default USB_DWC3
-       help
-	 Support USB2/3 functionality in simple SoC integrations.
-	 Currently supports Xilinx and Qualcomm DWC USB3 IP.
-	 Say 'Y' or 'M' if you have one such device.
+	tristate "Generic OF Simple Glue Layer"
+	depends on OF && COMMON_CLK
+	default USB_DWC3
+	help
+	  Support USB2/3 functionality in simple SoC integrations.
+	  Currently supports Xilinx and Qualcomm DWC USB3 IP.
+	  Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_ST
 	tristate "STMicroelectronics Platforms"
-- 
2.17.1

