Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE16AB8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405064AbfIFM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 08:59:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404884AbfIFM6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:58:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C61FA35816A01BA2A796;
        Fri,  6 Sep 2019 20:58:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 20:58:01 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 03/13] scsi: hisi_sas: Directly return when running I_T_nexus reset if phy disabled
Date:   Fri, 6 Sep 2019 20:55:27 +0800
Message-ID: <1567774537-20003-4-git-send-email-john.garry@huawei.com>
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

From: Luo Jiaxing <luojiaxing@huawei.com>

At hisi_sas_debug_I_T_nexus_reset(), we call sas_phy_reset() to reset a
phy. But if the phy is disabled, sas_phy_reset() will directly return
-ENODEV without issue a phy reset request.

If so, We can directly return -ENODEV to libsas before issue a phy
reset.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 47faa283312e..5642c53cccae 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1752,6 +1752,11 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 	DECLARE_COMPLETION_ONSTACK(phyreset);
 	int rc, reset_type;
 
+	if (!local_phy->enabled) {
+		sas_put_local_phy(local_phy);
+		return -ENODEV;
+	}
+
 	if (scsi_is_sas_phy_local(local_phy)) {
 		struct asd_sas_phy *sas_phy =
 			sas_ha->sas_phy[local_phy->number];
-- 
2.17.1

