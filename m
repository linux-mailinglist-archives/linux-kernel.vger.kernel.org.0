Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B4E86679
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404140AbfHHQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:00:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404110AbfHHQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n1yjt2X7Jq9I74UVesO3pDwFX28IMKr9d3wsrGu9KqY=; b=OwgJF9RIfE/qwoQqR7l8QYGiHB
        bvtV/37DqJIMUHgOulrheG0U8WgeaRxU8A0YhRjwc2L5EZG/4DqstAFRXp8HGdigFTZhK5YXfmfGt
        coPNAmaebVbBbCYlrzrEwVQgyPpWJZzK/LoWey11hO1GSSfv25yrYY8Z0pgbbt7GlOhBeuloKEOr2
        sHJd+APjVNPjjdd5aPQ7yL6A+fIcWuioPHUa46TWdyoBesuGcDHJC5GtLcBgOq+BR5/W3te0GbpbX
        VJQo7Hmi5mAVnw+3z5LnxVbgKzdDo3xnkI8MincpwCcJzOPKhwWYvODcSKcY9dhszhfv1xL9nQzTB
        g3NI+Isg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkqO-0006pM-U7; Thu, 08 Aug 2019 16:00:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm-nommu: call dma_mmap_from_dev_coherent directly
Date:   Thu,  8 Aug 2019 19:00:03 +0300
Message-Id: <20190808160005.10325-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ther is no need to go through dma_common_mmap for the arm-nommu
dma mmap implementation as the only possible memory not handled above
could be that from the per-device coherent pool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 52b82559d99b..db9247898300 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -68,8 +68,9 @@ static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
 		return ret;
-
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+	return -ENXIO;
 }
 
 
-- 
2.20.1

