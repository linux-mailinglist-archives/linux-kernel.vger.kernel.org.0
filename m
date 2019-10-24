Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88116E3544
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502679AbfJXONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 10:13:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389916AbfJXOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:11:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 44DD4B3BD7F8C7BC19CC;
        Thu, 24 Oct 2019 22:11:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 24 Oct 2019 22:11:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 02/18] scsi: hisi_sas: Set the BIST init value before enabling BIST
Date:   Thu, 24 Oct 2019 22:08:09 +0800
Message-ID: <1571926105-74636-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1571926105-74636-1-git-send-email-john.garry@huawei.com>
References: <1571926105-74636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

If set the BIST init value after enabling BIST, there may be still some
few error bits. According to the process, need to set the BIST init value
before enabling BIST.

Fixes: 97b151e75861 ("scsi: hisi_sas: Add BIST support for phy loopback")
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index cb8d087762db..cc594937fa8d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3022,11 +3022,6 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 		hisi_sas_phy_write32(hisi_hba, phy_id,
 				     SAS_PHY_BIST_CTRL, reg_val);
 
-		mdelay(100);
-		reg_val |= (CFG_RX_BIST_EN_MSK | CFG_TX_BIST_EN_MSK);
-		hisi_sas_phy_write32(hisi_hba, phy_id,
-				     SAS_PHY_BIST_CTRL, reg_val);
-
 		/* set the bist init value */
 		hisi_sas_phy_write32(hisi_hba, phy_id,
 				     SAS_PHY_BIST_CODE,
@@ -3035,6 +3030,11 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 				     SAS_PHY_BIST_CODE1,
 				     SAS_PHY_BIST_CODE1_INIT);
 
+		mdelay(100);
+		reg_val |= (CFG_RX_BIST_EN_MSK | CFG_TX_BIST_EN_MSK);
+		hisi_sas_phy_write32(hisi_hba, phy_id,
+				     SAS_PHY_BIST_CTRL, reg_val);
+
 		/* clear error bit */
 		mdelay(100);
 		hisi_sas_phy_read32(hisi_hba, phy_id, SAS_BIST_ERR_CNT);
-- 
2.17.1

