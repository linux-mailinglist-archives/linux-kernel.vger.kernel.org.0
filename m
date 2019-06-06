Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A127B36FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfFFJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:20:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbfFFJUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:20:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B9DE754B11790C956AC;
        Thu,  6 Jun 2019 17:19:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Jun 2019 17:19:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: tegra: xusb: Remove set but not used variable 'priv'
Date:   Thu, 6 Jun 2019 09:27:46 +0000
Message-ID: <20190606092746.80310-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/phy/tegra/xusb-tegra210.c: In function 'tegra210_hsic_phy_power_on':
drivers/phy/tegra/xusb-tegra210.c:1236:31: warning:
 variable 'priv' set but not used [-Wunused-but-set-variable]

It's never used, so can be removed

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index eb754baa8d71..4076b22c4087 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -1233,13 +1233,10 @@ static int tegra210_hsic_phy_power_on(struct phy *phy)
 	struct tegra_xusb_hsic_lane *hsic = to_hsic_lane(lane);
 	struct tegra_xusb_hsic_pad *pad = to_hsic_pad(lane->pad);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
-	struct tegra210_xusb_padctl *priv;
 	unsigned int index = lane->index;
 	u32 value;
 	int err;
 
-	priv = to_tegra210_xusb_padctl(padctl);
-
 	err = regulator_enable(pad->supply);
 	if (err)
 		return err;



