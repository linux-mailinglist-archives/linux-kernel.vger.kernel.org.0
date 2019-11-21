Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A8104906
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 04:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKUDTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 22:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKUDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:51 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9CC2089D;
        Thu, 21 Nov 2019 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306390;
        bh=iVbwRxenny8n9cGqrqaySjV5UdnMK0fAnGxCLzvVwRo=;
        h=From:To:Cc:Subject:Date:From;
        b=BcI2d9GjcmlTwlXaXIxTZk4x5W/94MAC8ozxQbMQ49zFMwcCULTcFiqmVwqeGaluq
         z74AjmhA3C4DCOPBh6FjRkp7p+As2Gb/5TFnQcEyGyd37gCYEBJUFBFy0eud4DJhrv
         lWLaYgZtGh8CL4gq6eZk97qDPuO2Ak8RkNyp3vXE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] phy: hisilicon: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:47 +0100
Message-Id: <1574306387-8029-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/phy/hisilicon/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 534e393a09b3..1c73053bcc98 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -33,14 +33,14 @@ config PHY_HISTB_COMBPHY
 	  If unsure, say N.
 
 config PHY_HISI_INNO_USB2
-       tristate "HiSilicon INNO USB2 PHY support"
-       depends on (ARCH_HISI && ARM64) || COMPILE_TEST
-       select GENERIC_PHY
-       select MFD_SYSCON
-       help
-         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
-         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
-         USB host port to accept one USB device.
+	tristate "HiSilicon INNO USB2 PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+	  USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+	  USB host port to accept one USB device.
 
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
-- 
2.7.4

