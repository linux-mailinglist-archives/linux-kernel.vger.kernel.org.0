Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2669C2A466
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEYMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 08:37:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfEYMhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:37:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C8549927C23E8ACDEB41;
        Sat, 25 May 2019 20:37:19 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:37:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: remove set but not used variable 'sge_sz'
Date:   Sat, 25 May 2019 20:37:05 +0800
Message-ID: <20190525123705.8588-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_create_frame_pool:
drivers/scsi/megaraid/megaraid_sas_base.c:4124:6: warning: variable sge_sz set but not used [-Wunused-but-set-variable]

It's not used any more since
commit 200aed582d61 ("megaraid_sas: endianness related bug fixes and code optimization")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b26991dcf137..25281a2eb424 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4121,22 +4121,11 @@ static int megasas_create_frame_pool(struct megasas_instance *instance)
 {
 	int i;
 	u16 max_cmd;
-	u32 sge_sz;
 	u32 frame_count;
 	struct megasas_cmd *cmd;
 
 	max_cmd = instance->max_mfi_cmds;
 
-	/*
-	 * Size of our frame is 64 bytes for MFI frame, followed by max SG
-	 * elements and finally SCSI_SENSE_BUFFERSIZE bytes for sense buffer
-	 */
-	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
-	    sizeof(struct megasas_sge32);
-
-	if (instance->flag_ieee)
-		sge_sz = sizeof(struct megasas_sge_skinny);
-
 	/*
 	 * For MFI controllers.
 	 * max_num_sge = 60
-- 
2.17.1


