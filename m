Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C9118586
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLJKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:51:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfLJKvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:51:17 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 52738FFCA710602A1368;
        Tue, 10 Dec 2019 18:51:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Dec 2019 18:51:05 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
Date:   Tue, 10 Dec 2019 18:46:24 +0800
Message-ID: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smmu_pmu_probe(), there is put_cpu() in the error path,
which is wrong because we use raw_smp_processor_id() to
get the cpu ID, not get_cpu(), remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 773128f..fd1d46a 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 out_unregister:
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
 out_cpuhp_err:
-	put_cpu();
 	return err;
 }
 
-- 
1.7.12.4

