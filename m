Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55609103C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfKTNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKTNka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:30 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0FB2251E;
        Wed, 20 Nov 2019 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257230;
        bh=eR+fEgTISyeCzxxA55ZkRGlbyJFlVVtN8MJ84DTdjM0=;
        h=From:To:Cc:Subject:Date:From;
        b=Vtf1uYh99RfpglRZIrXy+zGFPcatZMTtNOjnqnnatq9/7lO7KtQ3VPO3HSS4yklvc
         mK0Sbwz/kNfobqs6OIEhCSX269u1ASc2Gnaf5rxt33K6n2+M0/cGISeLLf/iLDKd0L
         ikIVdA1nAGnjaqzzUVeZW6d/395+p3bZ80KY4zMU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] phy: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:25 +0800
Message-Id: <20191120134026.14392-1-krzk@kernel.org>
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
 drivers/phy/hisilicon/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 534e393a09b3..6a591bb84031 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -38,9 +38,9 @@ config PHY_HISI_INNO_USB2
        select GENERIC_PHY
        select MFD_SYSCON
        help
-         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
-         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
-         USB host port to accept one USB device.
+	 Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+	 USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+	 USB host port to accept one USB device.
 
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
-- 
2.17.1

