Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373708CF99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfHNJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:31:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfHNJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:31:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3667EDDEAECF5A81535B;
        Wed, 14 Aug 2019 17:30:56 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 17:30:49 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 1/5] crypto: hisilicon - fix kbuild warnings
Date:   Wed, 14 Aug 2019 17:28:35 +0800
Message-ID: <1565774919-31853-2-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
References: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to use proper type of argument for dma_addr_t and size_t.

Fixes: 263c9959c937 ("crypto: hisilicon - add queue management driver for HiSilicon QM module")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 363f71b..796fdbf 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -347,7 +347,7 @@ static int qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
 	struct qm_mailbox mailbox;
 	int ret = 0;
 
-	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-%llx\n", queue,
+	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-%pad\n", queue,
 		cmd, dma_addr);
 
 	mailbox.w0 = cmd |
@@ -1137,7 +1137,7 @@ struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
 			goto err_clear_bit;
 		}
 
-		dev_dbg(dev, "allocate qp dma buf(va=%pK, dma=%pad, size=%lx)\n",
+		dev_dbg(dev, "allocate qp dma buf(va=%pK, dma=%pad, size=%zx)\n",
 			qp->qdma.va, &qp->qdma.dma, qp->qdma.size);
 	}
 
@@ -1714,7 +1714,7 @@ int hisi_qm_start(struct hisi_qm *qm)
 				QMC_ALIGN(sizeof(struct qm_cqc) * qm->qp_num);
 		qm->qdma.va = dma_alloc_coherent(dev, qm->qdma.size,
 						 &qm->qdma.dma, GFP_KERNEL);
-		dev_dbg(dev, "allocate qm dma buf(va=%pK, dma=%pad, size=%lx)\n",
+		dev_dbg(dev, "allocate qm dma buf(va=%pK, dma=%pad, size=%zx)\n",
 			qm->qdma.va, &qm->qdma.dma, qm->qdma.size);
 		if (!qm->qdma.va)
 			return -ENOMEM;
-- 
2.8.1

