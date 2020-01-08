Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4E13390B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgAHCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 21:15:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHCPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:15:19 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CBEC6634726A87751790;
        Wed,  8 Jan 2020 10:15:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 10:15:09 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <kishon@ti.com>, <p.zabel@pengutronix.de>, <jsarha@ti.com>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] phy: ti: Fix build error without CONFIG_OF_ADDRESS
Date:   Wed, 8 Jan 2020 10:10:59 +0800
Message-ID: <20200108021059.70869-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_OF_ADDRESS is not set and COMPILE_TEST=y.
Building phy-j721e-wiz will get the following error:

drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
phy-j721e-wiz.c:(.text+0x1a): undefined reference to
`of_platform_device_destroy'

Correct the config for PHY_J721E_WIZ.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 42440de5438a0("phy: ti: j721e-wiz: Add support for WIZ
module present in TI J721E SoC")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/phy/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 3a1d3887c99c..f904aebf24a9 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -35,7 +35,7 @@ config PHY_AM654_SERDES
 
 config PHY_J721E_WIZ
 	tristate "TI J721E WIZ (SERDES Wrapper) support"
-	depends on OF && ARCH_K3 || COMPILE_TEST
+	depends on OF && HAS_IOMEM && (ARCH_K3 || COMPILE_TEST)
 	depends on COMMON_CLK
 	select GENERIC_PHY
 	select MULTIPLEXER
-- 
2.20.1

