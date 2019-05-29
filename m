Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5A2D77C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE2IQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:16:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33583 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2IQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:16:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so2416781edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7YPMPnQHiZSTC9SMTzMeKs5svVKQA9+Mqdsa3E0VpUY=;
        b=FCUeomwuDfmxN1h0D6lV5jxZ/wMPiVvSLh+6vD04triShbrg3N711tx0v+ndzNVEut
         2qCPkBPgtAw9eb+yFx75vkwC6YOZW12ysDv0DmzpxYe3GlWLvMHwTwBbXbXcXXrCiOAg
         jmEA6ghVGNubW01UhbwRBlGDePYEPq3Sngg6MkkbWzwmwzyjk+oeg5KHQEmsSQ+ZDDNY
         wPehJjrTlpk+2DpeU0cq1Cthqz2lQIjBEF8L7C5av2+8fQx4JshBLGvtIDyM7otQGz9k
         r8VWyntEcUUna8khcjBtK1Dst2OuhpzG0hg6YoSouQ3CZfrn3jcG0ZNtJ9i6O+pip3vy
         G+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7YPMPnQHiZSTC9SMTzMeKs5svVKQA9+Mqdsa3E0VpUY=;
        b=bU/hkJik7NO3tqQbe2XPL1QXSKV++WprTRX+4jrtS2A/uEwNeFBGWzQUfhIcEjcfdE
         tu+9YflXf/N6PVDfEUlTZ3M/Ik35obfhNN2Pz3SKCmu3Jdw+K6JH0cWUMBERuxfIMRjN
         LBUU0NWqCT4UxVzHAKTzhgGJarS5eVKMIAPOW/ZNBtYrg2TzCl42vLjOmMCPp1wFaZeR
         HpvZL7nj4/B5YQRNf7qF3qj769iK+oS69DYv5f2jEcx9kt4hIuVRBftluwkZ2dLLP7Kw
         VRKlwq5K3Qn/afPlthSaq18+mwpgo2mUI5xF0oyi9nl78dpHV8ZL8CROCHNBeiNAXeUz
         1azA==
X-Gm-Message-State: APjAAAWSvmERJ7cgOvCm1rbDqojzQzzTW3/PJMh+2ZHSxI5POVFwrkkl
        kMb1ycziMpRSoRsbm0bLjQQ=
X-Google-Smtp-Source: APXvYqyKhTr9oxvChieY3z2xPala89CEJgfs4hhkYLjCMkL87W1gCcKCNRuP3pQL6cv2kPCr346y7A==
X-Received: by 2002:a50:8e81:: with SMTP id w1mr134921402edw.271.1559117761693;
        Wed, 29 May 2019 01:16:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id a17sm4835118edt.63.2019.05.29.01.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 01:16:00 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
Date:   Wed, 29 May 2019 01:15:32 -0700
Message-Id: <20190529081532.73585-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/iommu/dma-iommu.c:897:6: warning: logical not is only applied to
the left hand side of this comparison [-Wlogical-not-parentheses]
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^                                 ~~
drivers/iommu/dma-iommu.c:897:6: note: add parentheses after the '!' to
evaluate the comparison first
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^
             (                                    )
drivers/iommu/dma-iommu.c:897:6: note: add parentheses around left hand
side expression to silence this warning
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^
            (                                )
1 warning generated.

Judging from the rest of the commit and the conditional in
iommu_dma_map_sg, either

    if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))

or
    if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)

was intended, not a combination of the two.

I personally think that the former is easier to understand so use that.

Fixes: 06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
Link: https://github.com/ClangBuiltLinux/linux/issues/497
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cd49c2d3770..0dee374fc64a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -894,7 +894,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
 	/*
-- 
2.22.0.rc1

