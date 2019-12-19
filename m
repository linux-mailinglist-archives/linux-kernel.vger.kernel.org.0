Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F971259FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 04:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 22:23:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfLSDX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:23:58 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C8E48CE8DAF79E292C6;
        Thu, 19 Dec 2019 11:23:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 11:23:50 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-kernel@vger.kernel.org>, Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH] phy: lantiq: vrx200-pcie: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 11:24:38 +0800
Message-ID: <1576725878-112367-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c:389:2-3: Unneeded semicolon

Fixes: e52a632195bf ("phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
index 6e45796..2ff9a48 100644
--- a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
+++ b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
@@ -386,7 +386,7 @@ static struct phy *ltq_vrx200_pcie_phy_xlate(struct device *dev,
 	default:
 		dev_err(dev, "invalid PHY mode %u\n", mode);
 		return ERR_PTR(-EINVAL);
-	};
+	}

 	return priv->phy;
 }
--
2.6.2

