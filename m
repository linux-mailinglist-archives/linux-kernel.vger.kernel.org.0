Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945EC1783F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgCCU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 15:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgCCU15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:27:57 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08CCA20CC7;
        Tue,  3 Mar 2020 20:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267277;
        bh=6UaeTxB0EcXT+LhMv79ITkiIEzlAiO/oYwI25OmNdCE=;
        h=From:To:Cc:Subject:Date:From;
        b=tSChNZ7KPOV1+drPeErg8JAgd6eywCCoUpxqqWg119Q62uXljcSQ6MiSyp3T6z7cm
         ND9/x7IrXyJAWX81ZiDU57E2PGWeZp+fIoVRnuGOLmY3QEvGp70NaMeKavWSSvhvlJ
         +auTOmwbFErabMmd1vCSGP++nR3nck4Jjc6iGrhU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Suman Anna <s-anna@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 1/4] iommu/omap: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
Date:   Tue,  3 Mar 2020 21:27:48 +0100
Message-Id: <20200303202751.5153-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pointers should be casted to unsigned long to avoid
-Wpointer-to-int-cast warnings when compiling on 64-bit platform (e.g.
with COMPILE_TEST):

    drivers/iommu/omap-iommu.c: In function ‘omap2_iommu_enable’:
    drivers/iommu/omap-iommu.c:170:25: warning:
        cast from pointer to integer of different size [-Wpointer-to-int-cast]
      if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
                             ^

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index be551cc34be4..50e8acf88ec4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -167,7 +167,7 @@ static int omap2_iommu_enable(struct omap_iommu *obj)
 {
 	u32 l, pa;
 
-	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
+	if (!obj->iopgd || !IS_ALIGNED((unsigned long)obj->iopgd,  SZ_16K))
 		return -EINVAL;
 
 	pa = virt_to_phys(obj->iopgd);
-- 
2.17.1

