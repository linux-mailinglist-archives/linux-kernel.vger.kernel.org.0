Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB6E1780
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfJWKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 06:13:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391093AbfJWKNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BF2DB506;
        Wed, 23 Oct 2019 10:13:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v2 03/11] reset: simple: Keep alphabetical order
Date:   Wed, 23 Oct 2019 12:13:09 +0200
Message-Id: <20191023101317.26656-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191023101317.26656-1-afaerber@suse.de>
References: <20191023101317.26656-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore alphabetical order for Kconfig dependencies and help text.
Compatibles got out of order too, but no functional change done here.

Goal is to make it obvious where to add new platforms.

Fixes: 64c47b624f64 ("reset: Add reset controller support for BM1880 SoC")
Fixes: 1d7592f84f92 ("reset: simple: Enable for ASPEED systems")
Fixes: 96a2f50305d1 ("reset: build simple reset controller driver for Agilex")
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New (prepares for following patch extending it to Realtek)
 
 drivers/reset/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 46f7986c3587..fac356a9b818 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -129,7 +129,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARC || ARCH_AGILEX
+	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -138,10 +138,10 @@ config RESET_SIMPLE
 	  Currently this driver supports:
 	   - Altera SoCFPGAs
 	   - ASPEED BMC SoCs
+	   - Bitmain BM1880 SoC
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
-	   - Bitmain BM1880 SoC
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-- 
2.16.4

