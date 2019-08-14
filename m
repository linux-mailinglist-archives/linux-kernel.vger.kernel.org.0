Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316708D666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfHNOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfHNOlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:41:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5A12084F;
        Wed, 14 Aug 2019 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565793666;
        bh=jqAmDB/DdtSMeWfimuoJggpnAk0RJ3WaU75jDeIn5oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNsmFWWNEtepwSspPVPQj7tCrKE+6ilVhN23rjhA7f8T2B2i69Zs85I3qpC/pDSEY
         rqWqwiQfS1y9E4hWMQdJM/K+pyYE6AQ9CMK9ek75MNFaUo5/+LkNcKP4ySo17uqG16
         tpBkanURK0WmMPwYRrDuqri3s8x6EsmrAO4LX/AQ=
Date:   Wed, 14 Aug 2019 15:41:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
 <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong Wu,

Sorry, but I'm still deeply confused by this patch.

On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> 
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address. Here is
> the detailed remap relationship in the "4GB mode":
> CPU PA         ->    HW PA
> 0x4000_0000          0x1_4000_0000 (Add bit32)
> 0x8000_0000          0x1_8000_0000 ...
> 0xc000_0000          0x1_c000_0000 ...
> 0x1_0000_0000        0x1_0000_0000 (No change)

So in this example, there are no PAs below 0x4000_0000 yet you later
add code to deal with that:

> +	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> +	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> +		paddr |= BIT_ULL(32);

Why? Mainline currently doesn't do anything like this for the "4gb mode"
support as far as I can tell. In fact, we currently unconditionally set
bit 32 in the physical address returned by iova_to_phys() which wouldn't
match your CPU PAs listed above, so I'm confused about how this is supposed
to work.

The way I would like this quirk to work is that the io-pgtable code
basically sets bit 9 in the pte when bit 32 is set in the physical address,
and sets bit 4 in the pte when bit 33 is set in the physical address. It
would then do the opposite when converting a pte to a physical address.

That way, your driver can call the page table code directly with the high
addresses and we don't have to do any manual offsetting or range checking
in the page table code.

Please can you explain to me why the diff below doesn't work on top of
this series? I'm happy to chat on IRC if you think it would be easier,
because I have a horrible feeling that we've been talking past each other
and I'd like to see this support merged for 5.4.

Will

--->8

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index ab12ef5f8b03..d8d84617c822 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -184,7 +184,7 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
 	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
-		if ((paddr & BIT_ULL(32)) || cfg->oas == ARM_V7S_MTK_4GB_OAS)
+		if (paddr & BIT_ULL(32))
 			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
 		if (paddr & BIT_ULL(33))
 			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
@@ -206,17 +206,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 		mask = ARM_V7S_LVL_MASK(lvl);
 
 	paddr = pte & mask;
-	if (cfg->oas == 32 || !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
-		return paddr;
 
-	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
-		paddr |= BIT_ULL(33);
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
 
-	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
-	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
-		paddr |= BIT_ULL(32);
-	else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
-		paddr |= BIT_ULL(32);
 	return paddr;
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5b9454352fd..3ae54dedede0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -286,7 +286,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
 		dom->cfg.oas = 32;
 	else if (data->enable_4GB)
-		dom->cfg.oas = ARM_V7S_MTK_4GB_OAS;
+		dom->cfg.oas = 33;
 	else
 		dom->cfg.oas = 34;
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 27337395bd42..a2a52c349fe4 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -113,8 +113,6 @@ struct io_pgtable_cfg {
 	};
 };
 
-#define ARM_V7S_MTK_4GB_OAS			33
-
 /**
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
