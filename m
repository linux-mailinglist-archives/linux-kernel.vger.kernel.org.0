Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89726BF30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfGQPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 11:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727815AbfGQPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2425AF95;
        Wed, 17 Jul 2019 15:31:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        m.szyprowski@samsung.com, hch@lst.de, phil@raspberrypi.org,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 4/4] arm64: mm: set direct_dma_min_mask according to dma-ranges
Date:   Wed, 17 Jul 2019 17:31:35 +0200
Message-Id: <20190717153135.15507-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717153135.15507-1-nsaenzjulienne@suse.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we parse the dma-ranges during initialization we can fine-tune
the DMA mask used by the direct DMA implementation.

We set the mask based on the size of the DMA addressable memory, and if
bigger than 4GB we force it to DMA_BIT_MASK(32) as it's always been.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5708adf0db52..f8af2c99667c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -52,6 +52,8 @@ EXPORT_SYMBOL(memstart_addr);
 
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+extern u64 dma_direct_min_mask;
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -198,8 +200,12 @@ static int __init early_init_dt_scan_dma_ranges(unsigned long node,
 	if (size > (1ULL << 32))
 		size = 1ULL << 32;
 
-	if (*dma_phys_limit > (phys_addr + size))
+	if (*dma_phys_limit > (phys_addr + size)) {
+		/* Set min DMA mask in case is was smaller than 32 */
+		dma_direct_min_mask = size - 1;
+
 		*dma_phys_limit = phys_addr + size;
+	}
 
 	return 0;
 }
-- 
2.22.0

