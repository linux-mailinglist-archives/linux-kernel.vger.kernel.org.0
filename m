Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD9AB8A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405054AbfIFM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 08:59:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404905AbfIFM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:58:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBDFB2FA6EC3306F9B8B;
        Fri,  6 Sep 2019 20:58:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 20:58:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 05/13] scsi: hisi_sas: Retry 3 times TMF IO for SAS disks when init device
Date:   Fri, 6 Sep 2019 20:55:29 +0800
Message-ID: <1567774537-20003-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567774537-20003-1-git-send-email-john.garry@huawei.com>
References: <1567774537-20003-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

When init device for SAS disks, it will send TMF IO to clear disks. At that
times TMF IO is broken by some operations such as injecting controller
reset from HW RAs event, the TMF IO will be timeout, and at last device
will be gone. Print is as followed:

hisi_sas_v3_hw 0000:74:02.0: dev[240:1] found
...
hisi_sas_v3_hw 0000:74:02.0: controller resetting...
hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=10(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=9(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=9(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=9(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=9(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=10(sata)
hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
hisi_sas_v3_hw 0000:74:02.0: controller reset complete
hisi_sas_v3_hw 0000:74:02.0: abort tmf: TMF task timeout and not done
hisi_sas_v3_hw 0000:74:02.0: dev[240:1] is gone
sas: driver on host 0000:74:02.0 cannot handle device 5000c500a75a860d,
error:5

To improve the reliability, retry TMF IO max of 3 times for SAS disks which
is the same as softreset does.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 247268983df9..4c279a285c20 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -698,13 +698,13 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 	return sas_dev;
 }
 
-#define HISI_SAS_SRST_ATA_DISK_CNT 3
+#define HISI_SAS_DISK_RECOVER_CNT 3
 static int hisi_sas_init_device(struct domain_device *device)
 {
 	int rc = TMF_RESP_FUNC_COMPLETE;
 	struct scsi_lun lun;
 	struct hisi_sas_tmf_task tmf_task;
-	int retry = HISI_SAS_SRST_ATA_DISK_CNT;
+	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	struct sas_phy *local_phy;
@@ -714,10 +714,14 @@ static int hisi_sas_init_device(struct domain_device *device)
 		int_to_scsilun(0, &lun);
 
 		tmf_task.tmf = TMF_CLEAR_TASK_SET;
-		rc = hisi_sas_debug_issue_ssp_tmf(device, lun.scsi_lun,
-						  &tmf_task);
-		if (rc == TMF_RESP_FUNC_COMPLETE)
-			hisi_sas_release_task(hisi_hba, device);
+		while (retry-- > 0) {
+			rc = hisi_sas_debug_issue_ssp_tmf(device, lun.scsi_lun,
+							  &tmf_task);
+			if (rc == TMF_RESP_FUNC_COMPLETE) {
+				hisi_sas_release_task(hisi_hba, device);
+				break;
+			}
+		}
 		break;
 	case SAS_SATA_DEV:
 	case SAS_SATA_PM:
-- 
2.17.1

