Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD43112D29E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfL3R02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 12:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfL3R02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:26:28 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8489C206DB;
        Mon, 30 Dec 2019 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726787;
        bh=m+ZsnKOEnT8GfyM0PUcj40hjdwjIfZjmIypDhpTq+ik=;
        h=From:To:Cc:Subject:Date:From;
        b=HRBqtPtNPOzb2L2x+3OSWikBP4FKNAVR42FB70Wcgjwn8mqRoHStWhLBmS1x0lTCC
         ECT0BCbZ/ENrYxfL42XTGsOJsT7eVBoYviLfTVztjhFsNb8tneY6s4NVT7aB4OUt82
         lThzmgV0913aszsJJYtsVNZAUyBSXq7KjUT251sc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] iommu: omap: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
Date:   Mon, 30 Dec 2019 18:26:17 +0100
Message-Id: <20191230172619.17814-1-krzk@kernel.org>
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

