Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABC7C760
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGaPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730254AbfGaPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:48:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D42A2B03A;
        Wed, 31 Jul 2019 15:48:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        robh+dt@kernel.org, eric@anholt.net, mbrugger@suse.com,
        nsaenzjulienne@suse.de, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 7/8] arm64: update arch_zone_dma_bits to fine tune dma-direct min mask
Date:   Wed, 31 Jul 2019 17:47:50 +0200
Message-Id: <20190731154752.16557-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731154752.16557-1-nsaenzjulienne@suse.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of ZONE_DMA in arm64 devices are not forced to
support 32 bit DMA masks. We have to inform dma-direct of this
limitation whenever it happens.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 arch/arm64/mm/init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f5279ef85756..b809f3259340 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/of_fdt.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-direct.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
@@ -439,10 +440,14 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
+	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
 		arm64_dma_phys_limit = max_zone_dma_phys();
-	else
+
+		if (arm64_dma_phys_limit)
+			arch_zone_dma_bits = ilog2(arm64_dma_phys_limit) + 1;
+	} else {
 		arm64_dma_phys_limit = 0;
+	}
 
 	/* 4GB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-- 
2.22.0

