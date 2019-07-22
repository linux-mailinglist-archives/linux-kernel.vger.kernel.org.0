Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916CA6FC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfGVJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:44:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfGVJon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KU3XO7neiNJoCLlCx1kSbawFotPCDQuEmLUnpBRP3R8=; b=fx0OUGvargc7kZuDQBT1BVZvx6
        akZ3IxLvVFpwpTZ6mwxG/fDjJWbzOIsUrUpGAbXfOCDOTt/ZY9Og/OO6v1ZKX2WLk0UKeOuqaM5He
        JS3eKYYglPuo39ThJdRVk2HstA3K2/0b6YcWdNagG4gTFQf6qHKpgDxoFKvgUpg1SZ+OEMcU9hNeg
        nQTH/RbZzXAV6COOglFFC/UlRSXF47ADoLQbyXc03H9Kt31xN2rPHCxvirU8nLtJUgVejCURB9uha
        Iu8bHoVGJ3ZS4ucITXCip6qt9/Cmo1Y1s1eOcE8U5YqnKeJewWAL0DOk8cXwO2Rp1NvN/92mIq7KX
        5lcn/C2w==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUs4-0001tJ-OZ; Mon, 22 Jul 2019 09:44:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nouveau: return -EBUSY when hmm_range_wait_until_valid fails
Date:   Mon, 22 Jul 2019 11:44:25 +0200
Message-Id: <20190722094426.18563-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722094426.18563-1-hch@lst.de>
References: <20190722094426.18563-1-hch@lst.de>
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
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 5de2d54b9782..a9c5c58d425b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -501,7 +501,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
 		up_read(&range->vma->vm_mm->mmap_sem);
-		return -EAGAIN;
+		return -EBUSY;
 	}
 
 	ret = hmm_range_fault(range, true);
-- 
2.20.1

