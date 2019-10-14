Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DBD6979
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbfJNSb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 14:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388816AbfJNSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:31:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4484DBB80;
        Mon, 14 Oct 2019 18:31:53 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     hch@infradead.org, mbrugger@suse.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/5] ARM: bcm2711: use dma-direct
Date:   Mon, 14 Oct 2019 20:31:07 +0200
Message-Id: <20191014183108.24804-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raspberry Pi 4 supports up to 4GB of memory yet most of its devices
are only able to address the fist GB. Enable dma-direct for that board
in order to benefit from swiotlb's bounce buffering mechanism.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/mach-bcm/Kconfig   | 1 +
 arch/arm/mach-bcm/bcm2711.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index e4e25f287ad7..fd7d725d596c 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -163,6 +163,7 @@ config ARCH_BCM2835
 	select ARM_ERRATA_411920 if ARCH_MULTI_V6
 	select ARM_GIC if ARCH_MULTI_V7
 	select ZONE_DMA if ARCH_MULTI_V7
+	select SWIOTLB if ARCH_MULTI_V7
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select TIMER_OF
diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
index dbe296798647..67d98cb0533f 100644
--- a/arch/arm/mach-bcm/bcm2711.c
+++ b/arch/arm/mach-bcm/bcm2711.c
@@ -19,6 +19,7 @@ DT_MACHINE_START(BCM2711, "BCM2711")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_1G,
 #endif
+	.dma_direct = true,
 	.dt_compat = bcm2711_compat,
 	.smp = smp_ops(bcm2836_smp_ops),
 MACHINE_END
-- 
2.23.0

