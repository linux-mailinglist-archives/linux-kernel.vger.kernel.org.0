Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427A2129E67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLXHZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 02:25:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfLXHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C54F62673D311592F0D;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:56 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 6/6] mmc: owl: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:15 +0800
Message-ID: <1577172735-18869-7-git-send-email-zhengbin13@huawei.com>
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

drivers/mmc/host/owl-mmc.c:519:2-18: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/owl-mmc.c:523:2-18: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/owl-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 771e3d0..d3b1653 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -516,11 +516,11 @@ static void owl_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)

 	/* Enable DDR mode if requested */
 	if (ios->timing == MMC_TIMING_UHS_DDR50) {
-		owl_host->ddr_50 = 1;
+		owl_host->ddr_50 = true;
 		owl_mmc_update_reg(owl_host->base + OWL_REG_SD_EN,
 			       OWL_SD_EN_DDREN, true);
 	} else {
-		owl_host->ddr_50 = 0;
+		owl_host->ddr_50 = false;
 	}
 }

--
2.7.4

