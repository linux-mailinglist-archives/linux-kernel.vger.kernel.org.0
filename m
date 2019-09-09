Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBBAD184
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 03:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfIIBXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 21:23:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732038AbfIIBXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:23:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47B594A9447B892A3575;
        Mon,  9 Sep 2019 09:23:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Sep 2019
 09:23:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] perf/smmuv3: use devm_platform_ioremap_resource() to simplify code
Date:   Mon, 9 Sep 2019 09:22:57 +0800
Message-ID: <20190909012257.1080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190906143844.27956-1-yuehaibing@huawei.com>
References: <20190906143844.27956-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch title
---
 drivers/perf/arm_smmuv3_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index abcf54f..773128f 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -727,7 +727,7 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
-	struct resource *res_0, *res_1;
+	struct resource *res_0;
 	u32 cfgr, reg_size;
 	u64 ceid_64[2];
 	int irq, err;
@@ -764,8 +764,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		smmu_pmu->reloc_base = devm_ioremap_resource(dev, res_1);
+		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(smmu_pmu->reloc_base))
 			return PTR_ERR(smmu_pmu->reloc_base);
 	} else {
-- 
2.7.4


