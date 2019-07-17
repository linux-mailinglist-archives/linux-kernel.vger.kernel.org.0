Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4A6BC37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfGQMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 08:22:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfGQMWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:22:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6F9858E1C3A77E076A8;
        Wed, 17 Jul 2019 20:22:38 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 17 Jul 2019 20:22:31 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <marc.zyngier@arm.com>, <james.morse@arm.com>,
        <julien.thierry@arm.com>, <suzuki.poulose@arm.com>,
        <julien.thierry.kdev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <andrew.murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm/arm64: Assign pmc->idx before kvm_pmu_stop_counter()
Date:   Wed, 17 Jul 2019 12:20:19 +0000
Message-ID: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
(and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
idx will potentially hit a KASAN BUG [1].

Fix it by moving the assignment of idx before kvm_pmu_stop_counter().

[1] https://www.spinics.net/lists/kvm-arm/msg36700.html

Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
Suggested-by: Andrew Murray <andrew.murray@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 3dd8238..521bfdd 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
-		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 		pmu->pmc[i].idx = i;
+		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 	}
 
 	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
-- 
1.8.3.1


