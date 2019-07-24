Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A907288E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGXGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 02:53:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D+fP/F31jlLUpmTEYvyqj+ufxmWFwYqwn3YRw+jITpw=; b=jAXuPct3oZWPyrvKK3RTq9yLMe
        P2SmrkMDBWs6EzLWrm9lZ9k9SfmUYWYPCzUjb0f4YJ5DEYdtHpJw2XFK00/7Es6CRRPhrKus/bt6c
        ER4cSvKLREXQtEc2scthDU97dFARRALlDnGlcVP8h/paihFvZ3vnN1u/ovubU485ouuzVtqwtDeHM
        q+w6iPsQcfcslsyLIsVOjOzhLjBg8m5p4lQB5sSF2bSlabyPXzWNGEKOZixnFNCj/2bdhtQLiIlHP
        3eODQlxrYKbSQ9cm/iar+AUA0hyO1Zrnswpv+8SLpPooWcr2s+GkE28X2/VeMCEw9pjvwKyYM8EaX
        F4rsi4WQ==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB9C-0004Im-Vl; Wed, 24 Jul 2019 06:53:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] nouveau: remove the block parameter to nouveau_range_fault
Date:   Wed, 24 Jul 2019 08:52:54 +0200
Message-Id: <20190724065258.16603-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724065258.16603-1-hch@lst.de>
References: <20190724065258.16603-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is always false, so remove it as well as the -EAGAIN
handling that can only happen for the non-blocking case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 6c1b04de0db8..e3097492b4ad 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -485,8 +485,7 @@ nouveau_range_done(struct hmm_range *range)
 }
 
 static int
-nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
-		    bool block)
+nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 {
 	long ret;
 
@@ -504,13 +503,12 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
 		return -EAGAIN;
 	}
 
-	ret = hmm_range_fault(range, block);
+	ret = hmm_range_fault(range, true);
 	if (ret <= 0) {
 		if (ret == -EBUSY || !ret) {
 			up_read(&range->vma->vm_mm->mmap_sem);
 			ret = -EBUSY;
-		} else if (ret == -EAGAIN)
-			ret = -EBUSY;
+		}
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -691,7 +689,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = nouveau_range_fault(&svmm->mirror, &range, true);
+		ret = nouveau_range_fault(&svmm->mirror, &range);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!nouveau_range_done(&range)) {
-- 
2.20.1

