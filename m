Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DADEB56B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfJaQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:53:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbfJaQxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE77AB30A;
        Thu, 31 Oct 2019 16:53:12 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 4/4] ARM: realtek: Enable RTD1195 arch timer
Date:   Thu, 31 Oct 2019 17:53:07 +0100
Message-Id: <20191031165308.14102-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191031165308.14102-1-afaerber@suse.de>
References: <20191031165308.14102-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this magic write the timer doesn't work and boot gets stuck.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/mach-realtek/rtd1195.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-realtek/rtd1195.c b/arch/arm/mach-realtek/rtd1195.c
index 99e5d3e96a8e..cd16f1e99646 100644
--- a/arch/arm/mach-realtek/rtd1195.c
+++ b/arch/arm/mach-realtek/rtd1195.c
@@ -5,6 +5,9 @@
  * Copyright (c) 2017-2019 Andreas Färber
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/io.h>
 #include <linux/memblock.h>
 #include <asm/mach/arch.h>
 
@@ -24,6 +27,18 @@ static void __init rtd1195_reserve(void)
 	rtd1195_memblock_remove(0x18100000, 0x01000000);
 }
 
+static void __init rtd1195_init_time(void)
+{
+	void __iomem *base;
+
+	base = ioremap(0xff018000, 4);
+	writel(0x1, base);
+	iounmap(base);
+
+	of_clk_init(NULL);
+	timer_probe();
+}
+
 static const char *const rtd1195_dt_compat[] __initconst = {
 	"realtek,rtd1195",
 	NULL
@@ -31,6 +46,7 @@ static const char *const rtd1195_dt_compat[] __initconst = {
 
 DT_MACHINE_START(rtd1195, "Realtek RTD1195")
 	.dt_compat = rtd1195_dt_compat,
+	.init_time = rtd1195_init_time,
 	.reserve = rtd1195_reserve,
 	.l2c_aux_val = 0x0,
 	.l2c_aux_mask = ~0x0,
-- 
2.16.4

