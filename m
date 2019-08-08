Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4D865DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbfHHPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 11:34:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x7ybZjKxR0l979mP5Y8wGTwoC7YG2fijyFoop9SwmvY=; b=ObdDVS93ijfBipfxkruL3vThKy
        YnxggEEQI8ykUgMl/26hlGDBk03JnB6FP4dzUD3ApPS0lnql9HLqZCpje4BTnbrWfBVLGMaBEGA88
        HLJh/R1WQa+bPh3MUsY5w3uZyfozroQFpaIDNKVac4kvUC7E5rvD4YDg/FDwsMgmL3A7rcVOTbz4a
        PBITSwWfVqiOZKRqYZBSushqapyrlBvxP+Zt5FyXgyWKIumCpl+d+vdpV7/IlOw4UGYnjaLGu3NdQ
        50hJ5hO+d03U0TYzdfPi67eqLNQRKRsf7IxW337l5Mtkf6OmcyfV0xL69jFYoi/G/mURABb4p5/So
        GgYtMfFw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkQg-0005DV-B3; Thu, 08 Aug 2019 15:34:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] nouveau: remove a few function stubs
Date:   Thu,  8 Aug 2019 18:33:42 +0300
Message-Id: <20190808153346.9061-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808153346.9061-1-hch@lst.de>
References: <20190808153346.9061-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_dmem_migrate_vma and nouveau_dmem_convert_pfn are only called
when CONFIG_DRM_NOUVEAU_SVM is enabled, so there is no need to provide
!CONFIG_DRM_NOUVEAU_SVM stubs for them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.h b/drivers/gpu/drm/nouveau/nouveau_dmem.h
index 9d97d756fb7d..92394be5d649 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.h
@@ -45,16 +45,5 @@ static inline void nouveau_dmem_init(struct nouveau_drm *drm) {}
 static inline void nouveau_dmem_fini(struct nouveau_drm *drm) {}
 static inline void nouveau_dmem_suspend(struct nouveau_drm *drm) {}
 static inline void nouveau_dmem_resume(struct nouveau_drm *drm) {}
-
-static inline int nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
-					   struct vm_area_struct *vma,
-					   unsigned long start,
-					   unsigned long end)
-{
-	return 0;
-}
-
-static inline void nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
-					    struct hmm_range *range) {}
 #endif /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 #endif
-- 
2.20.1

