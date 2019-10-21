Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710BBDEF47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfJUOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 10:20:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbfJUOUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:20:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EC1B8218E14247E6FD1;
        Mon, 21 Oct 2019 22:20:07 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 22:20:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <manoj@linux.ibm.com>, <mrochs@linux.ibm.com>,
        <ukrishn@linux.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: cxlflash: remove set but not used variable 'ioarcb'
Date:   Mon, 21 Oct 2019 22:19:57 +0800
Message-ID: <20191021141957.18828-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/cxlflash/main.c:47:22: warning:
 variable ioarcb set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/cxlflash/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 2dbf35f..fbd2ae4 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -44,14 +44,12 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 	struct afu *afu = cmd->parent;
 	struct cxlflash_cfg *cfg = afu->parent;
 	struct device *dev = &cfg->dev->dev;
-	struct sisl_ioarcb *ioarcb;
 	struct sisl_ioasa *ioasa;
 	u32 resid;
 
 	if (unlikely(!cmd))
 		return;
 
-	ioarcb = &(cmd->rcb);
 	ioasa = &(cmd->sa);
 
 	if (ioasa->rc.flags & SISL_RC_FLAGS_UNDERRUN) {
-- 
2.7.4


