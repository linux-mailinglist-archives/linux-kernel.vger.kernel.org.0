Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37172B31B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfIOTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 15:34:09 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:57246 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfIOTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:34:09 -0400
Received: from localhost.localdomain ([93.23.196.41])
        by mwinf5d03 with ME
        id 1va5210090u43at03va5ta; Sun, 15 Sep 2019 21:34:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Sep 2019 21:34:07 +0200
X-ME-IP: 93.23.196.41
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/arm-smmu: Axe a useless test in 'arm_smmu_master_alloc_smes()'
Date:   Sun, 15 Sep 2019 21:34:01 +0200
Message-Id: <20190915193401.27426-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ommu_group_get_for_dev()' never returns NULL, so this test can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/arm-smmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c3ef0cc8f764..6fae8cdbe985 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1038,8 +1038,6 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	}
 
 	group = iommu_group_get_for_dev(dev);
-	if (!group)
-		group = ERR_PTR(-ENOMEM);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_err;
-- 
2.20.1

