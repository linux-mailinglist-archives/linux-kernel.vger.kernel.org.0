Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9205D65883
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfGKOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:09:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGKOJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:09:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F202596D9AD4EE8DA84D;
        Thu, 11 Jul 2019 22:09:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 22:09:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qla2xxx: Remove unnecessary null check
Date:   Thu, 11 Jul 2019 22:09:08 +0800
Message-ID: <20190711140908.26896-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A null check before a kfree is dma_pool_destroy,
so remove it. This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2e58cff..3c59157 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4731,8 +4731,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 		}
 	}
 
-	if (ha->dif_bundl_pool)
-		dma_pool_destroy(ha->dif_bundl_pool);
+	dma_pool_destroy(ha->dif_bundl_pool);
 	ha->dif_bundl_pool = NULL;
 
 	qlt_mem_free(ha);
-- 
2.7.4


