Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CE15326B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgBEOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 09:02:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727468AbgBEOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:02:43 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D4B654E713B6850B9A8;
        Wed,  5 Feb 2020 22:02:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Feb 2020 22:02:29 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <brking@us.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] scsi: ipr: remove redundant NULL check
Date:   Wed, 5 Feb 2020 21:56:49 +0800
Message-ID: <20200205135649.163926-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free function dma_pool_destroy() does NULL check, so the NULL check
before dma_pool_destroy() is unnecessary, just remove it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/scsi/ipr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index ae45cbe..f027cf3 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9529,8 +9529,7 @@ static void ipr_free_cmd_blks(struct ipr_ioa_cfg *ioa_cfg)
 		}
 	}
 
-	if (ioa_cfg->ipr_cmd_pool)
-		dma_pool_destroy(ioa_cfg->ipr_cmd_pool);
+	dma_pool_destroy(ioa_cfg->ipr_cmd_pool);
 
 	kfree(ioa_cfg->ipr_cmnd_list);
 	kfree(ioa_cfg->ipr_cmnd_list_dma);
-- 
2.7.4

