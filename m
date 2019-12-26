Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7712AB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 04:52:42 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:36695 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:52:42 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xBQ9pgNX023812;
        Thu, 26 Dec 2019 18:51:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xBQ9pgNX023812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577353903;
        bh=KClukxXTuW2tcSXVjPl9rnA5IKVgOInZKdTbkuEgVBI=;
        h=From:To:Cc:Subject:Date:From;
        b=2o6yuETICqz9vX34gn+bLy7yHs1FXSLjOereBev9RZcIhz7gBRb1dmSPm2V5TGAOd
         dcKNftgZq5cr5rypWcQwqb86ymf7sj43vJq9WIcFvRZIcrz+RvlRRQgk2jiT3yd6pr
         tbOtHzNjczGhX5lopVT87iMfEPkHVK+lScN3+wpMXy6s4IafhVEEcXABXCVyYHaeph
         w4oKI+eRzTcZRpp5GATb1PDHNl0SSHhgDGUO56YObn60LMo0VuFrCnv3DUtzgbu030
         gqHxr+/Bpmhhr9gHbAxLH+tzOp0P3FTtTUOV7NWVVYRr+J7YlU1EaLyjizoSu8elmv
         4eqrco172Ex0g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: constify arm_smmu_options[]
Date:   Thu, 26 Dec 2019 18:51:40 +0900
Message-Id: <20191226095141.30352-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a read-only array.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b463599559d2..ed9933960370 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -673,7 +673,7 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-static struct arm_smmu_option_prop arm_smmu_options[] = {
+static const struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
 	{ 0, NULL},
-- 
2.17.1

