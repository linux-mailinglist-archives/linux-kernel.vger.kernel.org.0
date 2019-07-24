Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA572890
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGXGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 02:53:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=igXh/3abv0ooQdkv/Vfc/WSfVB4lkdoSYebCAR1TL48=; b=IDkGONdXpH3tW1oxhx++LkR9Lr
        WtaFZ+boWB9F31gk5CqaFbhNeFfrtl5YLLAPAezcvPdlRxacMmzCyuUcbJkfsIU6ge7zEVv6VK3Lp
        BVN8c2sSrD9gXy2zzFgQNQxPeES0fjs+kwg6uO+b6FRTGfvZoI4LaBGXq5SxfAg1diq5NAYBrGEmT
        LgBCFZZp8wWhbrk+FwzSlyBkPvD4HtkVG7f4VC7cE6HJ/umGb0LSiSUT67UWqJ0MlfM/eAnG+yM66
        VhwUGjcVxt/otVXADUHsEEIdhJYMPPs8S9yngWBDr8DsSJQqvQUpJqMoQJQ2kuAdZG+rSN7e5CHvH
        SlT6wdaA==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB9J-0004Ko-0z; Wed, 24 Jul 2019 06:53:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] nouveau: return -EBUSY when hmm_range_wait_until_valid fails
Date:   Wed, 24 Jul 2019 08:52:56 +0200
Message-Id: <20190724065258.16603-6-hch@lst.de>
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

-EAGAIN has a magic meaning for non-blocking faults, so don't overload
it.  Given that the caller doesn't check for specific error codes this
change is purely cosmetic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index a835cebb6d90..545100f7c594 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -502,7 +502,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
 		up_read(&range->vma->vm_mm->mmap_sem);
-		return -EAGAIN;
+		return -EBUSY;
 	}
 
 	ret = hmm_range_fault(range, true);
-- 
2.20.1

