Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18D129E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 08:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLXHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLXHZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7BFDD550042D61DF732;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:56 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 5/6] mmc: davinci: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:14 +0800
Message-ID: <1577172735-18869-6-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
References: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/mmc/host/davinci_mmc.c:480:1-13: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/davinci_mmc.c:607:1-13: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/davinci_mmc.c:1270:3-16: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index f01fecd..fe94907 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -477,7 +477,7 @@ static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 		}
 	}

-	host->do_dma = 1;
+	host->do_dma = true;
 	ret = mmc_davinci_send_dma_request(host, data);

 	return ret;
@@ -604,7 +604,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
 		return;
 	}

-	host->do_dma = 0;
+	host->do_dma = false;
 	mmc_davinci_prepare_data(host, req);
 	mmc_davinci_start_command(host, req->cmd);
 }
@@ -1267,7 +1267,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		if (ret == -EPROBE_DEFER)
 			goto dma_probe_defer;
 		else if (ret)
-			host->use_dma = 0;
+			host->use_dma = false;
 	}

 	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
--
2.7.4

