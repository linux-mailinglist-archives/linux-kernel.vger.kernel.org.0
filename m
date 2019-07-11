Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12670658A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfGKOP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:15:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728438AbfGKOP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:15:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 33F913F460D8909F38C3;
        Thu, 11 Jul 2019 22:15:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 22:15:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jthumshirn@suse.de>, <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: aic94xx: Remove unnecessary null check
Date:   Thu, 11 Jul 2019 22:15:39 +0800
Message-ID: <20190711141539.13892-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy() can handle NULL pointer correctly, so there is
no need to check NULL pointer before calling kmem_cache_destroy().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 261d8e4..f5781e3 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -565,8 +565,7 @@ static void asd_destroy_ha_caches(struct asd_ha_struct *asd_ha)
 	if (asd_ha->hw_prof.scb_ext)
 		asd_free_coherent(asd_ha, asd_ha->hw_prof.scb_ext);
 
-	if (asd_ha->hw_prof.ddb_bitmap)
-		kfree(asd_ha->hw_prof.ddb_bitmap);
+	kfree(asd_ha->hw_prof.ddb_bitmap);
 	asd_ha->hw_prof.ddb_bitmap = NULL;
 
 	for (i = 0; i < ASD_MAX_PHYS; i++) {
@@ -641,12 +640,10 @@ static int asd_create_global_caches(void)
 
 static void asd_destroy_global_caches(void)
 {
-	if (asd_dma_token_cache)
-		kmem_cache_destroy(asd_dma_token_cache);
+	kmem_cache_destroy(asd_dma_token_cache);
 	asd_dma_token_cache = NULL;
 
-	if (asd_ascb_cache)
-		kmem_cache_destroy(asd_ascb_cache);
+	kmem_cache_destroy(asd_ascb_cache);
 	asd_ascb_cache = NULL;
 }
 
-- 
2.7.4


