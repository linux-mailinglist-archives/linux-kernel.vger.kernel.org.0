Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2ACDF2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfJUQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:25:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729504AbfJUQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:25:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 13A73C129C2355F654D0;
        Tue, 22 Oct 2019 00:25:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 00:25:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 15/18] scsi: hisi_sas: Add module parameter for debugfs dump count
Date:   Tue, 22 Oct 2019 00:22:12 +0800
Message-ID: <1571674935-108326-16-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1571674935-108326-1-git-send-email-john.garry@huawei.com>
References: <1571674935-108326-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

We still only use dump index #0 however.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index b4c6bec4b92c..bdd4aa7ed730 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -598,6 +598,7 @@ struct hisi_sas_slot_dif_buf_table {
 extern struct scsi_transport_template *hisi_sas_stt;
 
 extern bool hisi_sas_debugfs_enable;
+extern u32 hisi_sas_debugfs_dump_count;
 extern struct dentry *hisi_sas_debugfs_dir;
 
 extern void hisi_sas_stop_phys(struct hisi_hba *hisi_hba);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index df41d58eb964..57723b0fc025 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -3818,7 +3818,7 @@ static int hisi_sas_debugfs_alloc(struct hisi_hba *hisi_hba, int dump_index)
 
 	return 0;
 fail:
-	for (i = 0; i < HISI_SAS_MAX_DEBUGFS_DUMP; i++)
+	for (i = 0; i < hisi_sas_debugfs_dump_count; i++)
 		hisi_sas_debugfs_release(hisi_hba, i);
 	return -ENOMEM;
 }
@@ -3869,7 +3869,7 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 	hisi_hba->debugfs_dump_dentry =
 			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
 
-	for (i = 0; i < HISI_SAS_MAX_DEBUGFS_DUMP; i++) {
+	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
 		if (hisi_sas_debugfs_alloc(hisi_hba, i)) {
 			debugfs_remove_recursive(hisi_hba->debugfs_dir);
 			dev_dbg(dev, "failed to init debugfs!\n");
@@ -3908,14 +3908,24 @@ EXPORT_SYMBOL_GPL(hisi_sas_debugfs_enable);
 module_param_named(debugfs_enable, hisi_sas_debugfs_enable, bool, 0444);
 MODULE_PARM_DESC(hisi_sas_debugfs_enable, "Enable driver debugfs (default disabled)");
 
+u32 hisi_sas_debugfs_dump_count = 1;
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_dump_count);
+module_param_named(debugfs_dump_count, hisi_sas_debugfs_dump_count, uint, 0444);
+MODULE_PARM_DESC(hisi_sas_debugfs_dump_count, "Number of debugfs dumps to allow");
+
 static __init int hisi_sas_init(void)
 {
 	hisi_sas_stt = sas_domain_attach_transport(&hisi_sas_transport_ops);
 	if (!hisi_sas_stt)
 		return -ENOMEM;
 
-	if (hisi_sas_debugfs_enable)
+	if (hisi_sas_debugfs_enable) {
 		hisi_sas_debugfs_dir = debugfs_create_dir("hisi_sas", NULL);
+		if (hisi_sas_debugfs_dump_count > HISI_SAS_MAX_DEBUGFS_DUMP) {
+			pr_info("hisi_sas: Limiting debugfs dump count\n");
+			hisi_sas_debugfs_dump_count = HISI_SAS_MAX_DEBUGFS_DUMP;
+		}
+	}
 
 	return 0;
 }
-- 
2.17.1

