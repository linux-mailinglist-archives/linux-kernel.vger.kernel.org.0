Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96B281E09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfHENvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:51:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbfHENu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D823BC74230D4495B06;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 06/15] scsi: hisi_sas: Fix out of bound at debug_I_T_nexus_reset()
Date:   Mon, 5 Aug 2019 21:48:03 +0800
Message-ID: <1565012892-75940-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Fix a possible out-of-bounds access in hisi_sas_debug_I_T_nexus_reset().

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 04b3b0040059..02ad91c01a44 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1762,13 +1762,14 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct sas_ha_struct *sas_ha = &hisi_hba->sha;
-	struct asd_sas_phy *sas_phy = sas_ha->sas_phy[local_phy->number];
-	struct hisi_sas_phy *phy = container_of(sas_phy,
-			struct hisi_sas_phy, sas_phy);
 	DECLARE_COMPLETION_ONSTACK(phyreset);
 	int rc, reset_type;
 
 	if (scsi_is_sas_phy_local(local_phy)) {
+		struct asd_sas_phy *sas_phy =
+			sas_ha->sas_phy[local_phy->number];
+		struct hisi_sas_phy *phy =
+			container_of(sas_phy, struct hisi_sas_phy, sas_phy);
 		phy->in_reset = 1;
 		phy->reset_completion = &phyreset;
 	}
@@ -1780,6 +1781,10 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 	sas_put_local_phy(local_phy);
 
 	if (scsi_is_sas_phy_local(local_phy)) {
+		struct asd_sas_phy *sas_phy =
+			sas_ha->sas_phy[local_phy->number];
+		struct hisi_sas_phy *phy =
+			container_of(sas_phy, struct hisi_sas_phy, sas_phy);
 		int ret = wait_for_completion_timeout(&phyreset, 2 * HZ);
 		unsigned long flags;
 
-- 
2.17.1

