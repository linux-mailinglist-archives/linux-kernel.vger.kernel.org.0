Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5713129E65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXHZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 02:25:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfLXHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 987425FBAF99FA1FBF4E;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/6] mmc: sdhci-tegra: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:11 +0800
Message-ID: <1577172735-18869-3-git-send-email-zhengbin13@huawei.com>
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

drivers/mmc/host/sdhci-tegra.c:241:6-19: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7bc9505..af91250 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -238,7 +238,7 @@ static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)

 static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 {
-	bool is_tuning_cmd = 0;
+	bool is_tuning_cmd = false;
 	bool clk_enabled;
 	u8 cmd;

--
2.7.4

