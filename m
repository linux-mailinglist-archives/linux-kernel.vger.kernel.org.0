Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73E165898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfGKON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:13:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGKONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:13:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED862E47ECC0F52E1CD9;
        Thu, 11 Jul 2019 22:13:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 22:13:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] scsi: qla2xxx: Remove unnecessary null check
Date:   Thu, 11 Jul 2019 22:13:17 +0800
Message-ID: <20190711141317.52192-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190711140908.26896-1-yuehaibing@huawei.com>
References: <20190711140908.26896-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A null check before dma_pool_destroy is redundant,
so remove it. This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix commit log
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


