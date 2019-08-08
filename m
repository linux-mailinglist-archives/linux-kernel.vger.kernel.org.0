Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51978667B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbfHHQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:01:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404110AbfHHQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6rX4rzjkHGeK4NcYU1v//qZE74JXI8D/yo/ii/mnYy8=; b=Hfu9oWd7D7VEnMd8lwMF88eh50
        BrnWu/4N4gMfeeEotmC1C6Y+IfhfJTiB1IC70wAhR5mcLF5yinXgT7iJd4K7dstRQy5m09hks7OrJ
        zEZ0z/wwBb+A1O/IhjIHd2zh0vKOyma/ny+2FTKGh6YIwANnhvB0/I+c2fS/IjHEGss714co2qvBd
        lZzHBVxt2ueqjqs7M8VNPgT5WY92kbRli3ckVV8XUh0pvtHqWmcdLDRCdezLIkRi04cOZl/4nSQe/
        iChZdqMd8IckAsVP9tAkQsCeHzIuGvk+CU7UebYEbFUOa6jlcKLlmUy2IpoztFTi7nPeZYYTmrqvd
        dvG7o+HA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkqR-0006tx-U6; Thu, 08 Aug 2019 16:00:52 +0000
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
Subject: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Date:   Thu,  8 Aug 2019 19:00:04 +0300
Message-Id: <20190808160005.10325-8-hch@lst.de>
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

parisc is the only architecture that sets ARCH_NO_COHERENT_DMA_MMAP
when an MMU is enabled.  AFAIK this is because parisc CPUs use VIVT
caches, which means exporting normally cachable memory to userspace is
relatively dangrous due to cache aliasing.

But normally cachable memory is only allocated by dma_alloc_coherent
on parisc when using the sba_iommu or ccio_iommu drivers, so just
remove the .mmap implementation for them so that we don't have to set
ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/Kconfig        | 1 -
 drivers/parisc/ccio-dma.c  | 1 -
 drivers/parisc/sba_iommu.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 6d732e451071..e9dd88b7f81e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -52,7 +52,6 @@ config PARISC
 	select GENERIC_SCHED_CLOCK
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
 	select GENERIC_CLOCKEVENTS
-	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 1d7125d29bee..ad290f79983b 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1024,7 +1024,6 @@ static const struct dma_map_ops ccio_ops = {
 	.unmap_page =		ccio_unmap_page,
 	.map_sg = 		ccio_map_sg,
 	.unmap_sg = 		ccio_unmap_sg,
-	.mmap =			dma_common_mmap,
 	.get_sgtable =		dma_common_get_sgtable,
 };
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index fa4df65b7e28..ed50502cc65a 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1084,7 +1084,6 @@ static const struct dma_map_ops sba_ops = {
 	.unmap_page =		sba_unmap_page,
 	.map_sg =		sba_map_sg,
 	.unmap_sg =		sba_unmap_sg,
-	.mmap =			dma_common_mmap,
 	.get_sgtable =		dma_common_get_sgtable,
 };
 
-- 
2.20.1

