Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E212FAC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 17:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgACQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 11:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACQrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:47:22 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89CB92072C;
        Fri,  3 Jan 2020 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578070041;
        bh=6X5A46t01A3B94izlLbWPVwVfTKnq8mB/NEvKSeTiYU=;
        h=From:To:Cc:Subject:Date:From;
        b=hnURXQXIcZParjC2p7Erx4qCw7NyJeBsZWa3s9Sn5Q7mrqM0IdZE81fOQX+KDl6Em
         IhokR6mxJL1yVTqUNuexJ9uvdTw6N2KQcS+J9Oz6K+ZwEGGmqlqlipPOx1K/tyx07r
         F8PbFfYmNF0//KGEzifXF8wxbEdYATJsLycPp8FA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] phy: mediatek: Fix Kconfig indentation
Date:   Fri,  3 Jan 2020 17:47:09 +0100
Message-Id: <20200103164710.4829-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 drivers/phy/mediatek/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 376f5d189da0..7d19134c6b7c 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -3,12 +3,12 @@
 # Phy drivers for Mediatek devices
 #
 config PHY_MTK_TPHY
-    tristate "MediaTek T-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
-      Say 'Y' here to add support for MediaTek T-PHY driver,
-      it supports multiple usb2.0, usb3.0 ports, PCIe and
+	tristate "MediaTek T-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for MediaTek T-PHY driver,
+	  it supports multiple usb2.0, usb3.0 ports, PCIe and
 	  SATA, and meanwhile supports two version T-PHY which have
 	  different banks layout, the T-PHY with shared banks between
 	  multi-ports is first version, otherwise is second veriosn,
@@ -25,10 +25,10 @@ config PHY_MTK_UFS
 	  specified M-PHYs.
 
 config PHY_MTK_XSPHY
-    tristate "MediaTek XS-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
+	tristate "MediaTek XS-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
 	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
 	  multiple USB2.0, USB3.1 GEN2 ports.
-- 
2.17.1

