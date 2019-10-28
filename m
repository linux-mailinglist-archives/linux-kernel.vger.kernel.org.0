Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F45E72A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 14:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfJ1Ncp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 09:32:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfJ1Ncp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:32:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14AFDC67E735CB42E6F8;
        Mon, 28 Oct 2019 21:32:40 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 21:32:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: lpfc: Make lpfc_debugfs_ras_log_data static
Date:   Mon, 28 Oct 2019 21:25:56 +0800
Message-ID: <20191028132556.16272-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/scsi/lpfc/lpfc_debugfs.c:2083:1: warning:
 symbol 'lpfc_debugfs_ras_log_data' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 6c8effc..2e6a68d 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2079,8 +2079,8 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 }
 #endif
 
-int
-lpfc_debugfs_ras_log_data(struct lpfc_hba *phba, char *buffer, int size)
+static int lpfc_debugfs_ras_log_data(struct lpfc_hba *phba,
+				     char *buffer, int size)
 {
 	int copied = 0;
 	struct lpfc_dmabuf *dmabuf, *next;
-- 
2.7.4


