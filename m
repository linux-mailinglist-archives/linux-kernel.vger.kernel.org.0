Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5484DFB4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 17:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfKMQM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 11:12:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfKMQM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:12:58 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10A3099376CB0B408A91;
        Thu, 14 Nov 2019 00:12:52 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 00:12:43 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <xuwei5@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Populate VMID field for CMDQ_OP_TLBI_NH_VA
Date:   Wed, 13 Nov 2019 16:11:38 +0000
Message-ID: <20191113161138.22336-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMDQ_OP_TLBI_NH_VA requires VMID and this was missing since
commit 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask
for CMD_TLBI_S2_IPA"). Add it back.

Fixes: 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
This came to light while verifying the "SMMUv3 Nested Stage Setup"
series by Eric. Please find the discusiion here,
https://lore.kernel.org/patchwork/cover/1099617/
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..9b5274346df0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -856,6 +856,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
-- 
2.17.1


