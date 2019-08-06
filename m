Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95983634
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfHFQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbfHFQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jw2njJjxDN00xjjd9oeT2JTOUWmPpUSj71zvFEWivDw=; b=cmioyjZCRaAvXECnpQCfCtKV3C
        K6YAmV14z7KzaLLRcZnOGNm3ot7ObXpIslQKkBo302RvxpCZ57t1lyfgPMlq0K6LpFLAnnuXnxN2l
        oK6v0GVmq4XYrQlvovjELgFqZz8EvXaxN7ZAD+Zzn5q9BWmWt0Bj9Ng4wanLQM9xg9QLPubAnfYfs
        o87f0v3ABw2MP8ipKyGHf5hthuEMCBJiFKlblJH1sngrV+4+Yt59Ls/zba8gozAbC/+Xx83B8UIBT
        qbQ8T3GYeHHLhVMf6okW/RCk/RAHVfakdX+WZ43C01pgYavVeXeSjx5UpdazVVL0bwLYw0obZTQhj
        gvK/DVXQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yO-0000X0-0k; Tue, 06 Aug 2019 16:06:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] nouveau: pass struct nouveau_svmm to nouveau_range_fault
Date:   Tue,  6 Aug 2019 19:05:41 +0300
Message-Id: <20190806160554.14046-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need the nouveau_svmm structure to improve the function soon.
For now this allows using the svmm->mm reference to unlock the
mmap_sem, and thus the same dereference chain that the caller uses
to lock and unlock it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index a74530b5a523..98072fd48cf7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -485,23 +485,23 @@ nouveau_range_done(struct hmm_range *range)
 }
 
 static int
-nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
+nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
 {
 	long ret;
 
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, mirror,
+	ret = hmm_range_register(range, &svmm->mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret) {
-		up_read(&range->hmm->mm->mmap_sem);
+		up_read(&svmm->mm->mmap_sem);
 		return (int)ret;
 	}
 
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		up_read(&range->hmm->mm->mmap_sem);
+		up_read(&svmm->mm->mmap_sem);
 		return -EBUSY;
 	}
 
@@ -509,7 +509,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 	if (ret <= 0) {
 		if (ret == 0)
 			ret = -EBUSY;
-		up_read(&range->hmm->mm->mmap_sem);
+		up_read(&svmm->mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -689,7 +689,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = nouveau_range_fault(&svmm->mirror, &range);
+		ret = nouveau_range_fault(svmm, &range);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!nouveau_range_done(&range)) {
-- 
2.20.1

