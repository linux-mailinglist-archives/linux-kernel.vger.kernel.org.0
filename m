Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6EA80FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIDLWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:22:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDLWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:22:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DCEC4D621ABD64051DD3;
        Wed,  4 Sep 2019 19:22:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 19:22:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: lantiq: vrx200-pcie: fix error return code in ltq_vrx200_pcie_phy_power_on()
Date:   Wed, 4 Sep 2019 11:40:14 +0000
Message-ID: <20190904114014.124099-1-weiyongjun1@huawei.com>
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

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: e52a632195bf ("phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
index 544d64a84cc0..6e457967653e 100644
--- a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
+++ b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
@@ -323,7 +323,8 @@ static int ltq_vrx200_pcie_phy_power_on(struct phy *phy)
 		goto err_disable_pdi_clk;
 
 	/* Check if we are in "startup ready" status */
-	if (ltq_vrx200_pcie_phy_wait_for_pll(phy) != 0)
+	ret = ltq_vrx200_pcie_phy_wait_for_pll(phy);
+	if (ret)
 		goto err_disable_phy_clk;
 
 	ltq_vrx200_pcie_phy_apply_workarounds(phy);



