Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D42181C45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCKP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:26:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbgCKP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:26:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE1AC8C30EC35FF521E6;
        Wed, 11 Mar 2020 23:26:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Mar 2020 23:26:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Use dev_err() in read_iost_itct_cache_v3_hw()
Date:   Wed, 11 Mar 2020 23:22:24 +0800
Message-ID: <1583940144-230800-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

The print of pr_err() does not come with device information, so replace
it with dev_err(). Also improve the grammar in the message.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a2debe0c8185..374885aa8d77 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2938,6 +2938,7 @@ static void read_iost_itct_cache_v3_hw(struct hisi_hba *hisi_hba,
 {
 	u32 cache_dw_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ *
 			    HISI_SAS_IOST_ITCT_CACHE_NUM;
+	struct device *dev = hisi_hba->dev;
 	u32 *buf = cache;
 	u32 i, val;
 
@@ -2950,7 +2951,7 @@ static void read_iost_itct_cache_v3_hw(struct hisi_hba *hisi_hba,
 	}
 
 	if (val != 0xffffffff) {
-		pr_err("Issue occur when reading IOST/ITCT cache!\n");
+		dev_err(dev, "Issue occurred in reading IOST/ITCT cache!\n");
 		return;
 	}
 
-- 
2.17.1

