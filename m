Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA116E1866
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404588AbfJWK51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 06:57:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390566AbfJWK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:57:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id c22so10084605wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kPQuBMcV3IKlXagNKVVulXxvTJ8mDxo4kt4BxEwQ/EA=;
        b=Y/4PCBMNd4d9GEgJXhtXLJ4r+KsultOsAAI4nWtSyex0m7lXA7lffmOE98cf07ZvFF
         BBWaBOnlsYIrtctb8Vtpu0M1VUBy5ocxBMwSNd5ePbTnhtxm6pCHqgigwkKJ9IY3wltP
         W+ptA38/+vkVceeiyz0YpnCr0MZxCNTrSaWgCccu7bBr0Ru4tmDekEAhWvIycPONw8lf
         8Rfyxf4rlFSh/iC6sLuOqg6XTN1LLfN+Wpo/czK8RN3HQsPFInPGhnN/I1L4ewkYD87+
         2QuHR0RrHXV4ymRhNAmtlV3EeCJ3Rtuiz+gcgaqH3/BFVxkp+JC4Yesmo5h5jWc07IIj
         8xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kPQuBMcV3IKlXagNKVVulXxvTJ8mDxo4kt4BxEwQ/EA=;
        b=Opf9X1OA+3b4eMOXcMQ+6i+bVCCclFAMqRqie+NY1KduAS2zeFPeNt09XtV6u4Ldta
         xvcBeeA5VFIMpERjom6+WeFPB8ZQ/8CqdV4daZpIAGAw8l644QYhnWogUOUQonIFlkk4
         W2S7Jm7s/BI0UttYaG5dWTViZ6FsR719QQH7HckBKo5kiYKae0IGHEkwHEUz0EWnkg6Y
         INgAjj5oxTt+pHR0wkUvhMjnaLtkJ4GdHj1ffrA0VRukEVIGl3huT1GHp7fp7Fjq1t+Z
         6iICX4WT2cHjZA1Pyxgbs+pjJjj5xXUAUFHzZf6NoKSUXbGGP5CH3o/mFGNnfWNN9RyI
         NSYw==
X-Gm-Message-State: APjAAAU/7ny/Pdo3M7eX6ZdeDeUvwTv/cu1qCm/LUo6M/uMfe1FPNycZ
        AXMhjTZ2L/JSby3h1Oj2NLfJL2Cdl6EZnQ==
X-Google-Smtp-Source: APXvYqwFg08mF+6pemixpVH0aOQ1PBQIDeNDKV2x8R7A1ofugYcuV8909T/yOTX3MI0B02t6JQlJvg==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr7626130wmm.39.1571828239848;
        Wed, 23 Oct 2019 03:57:19 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i1sm29116242wmb.19.2019.10.23.03.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 03:57:19 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        quanyang.wang@windriver.com
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: zynq: use physical cpuid in zynq_slcr_cpu_stop/start
Date:   Wed, 23 Oct 2019 12:57:13 +0200
Message-Id: <20f6ae784e058aaa136a61456fe4784330255ce5.1571828230.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When kernel booting, it will create a cpuid map between the logical cpus
and physical cpus. In a normal boot, the cpuid map is as below:

    Physical      Logical
        0    ==>     0
        1    ==>     1

But in kdump, there is a condition that the crash happens at the
physical cpu1, and the crash kernel will run at the physical cpu1 too,
so the cpuid map in crash kernel is as below:

    Physical      Logical
        1    ==>     0
        0    ==>     1

The functions zynq_slcr_cpu_stop/start is to stop/start the physical
cpus, the parameter cpu should be the physical cpuid. So use
cpu_logical_map to translate the logical cpuid to physical cpuid.
Or else the logical cpu0(physical cpu1) will stop itself and
the processor will hang.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/platsmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index a10085be9073..68ec303fa278 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <linux/irqchip/arm-gic.h>
 #include "common.h"
@@ -30,6 +31,7 @@ int zynq_cpun_start(u32 address, int cpu)
 {
 	u32 trampoline_code_size = &zynq_secondary_trampoline_end -
 						&zynq_secondary_trampoline;
+	u32 phy_cpuid = cpu_logical_map(cpu);
 
 	/* MS: Expectation that SLCR are directly map and accessible */
 	/* Not possible to jump to non aligned address */
@@ -39,7 +41,7 @@ int zynq_cpun_start(u32 address, int cpu)
 		u32 trampoline_size = &zynq_secondary_trampoline_jump -
 						&zynq_secondary_trampoline;
 
-		zynq_slcr_cpu_stop(cpu);
+		zynq_slcr_cpu_stop(phy_cpuid);
 		if (address) {
 			if (__pa(PAGE_OFFSET)) {
 				zero = ioremap(0, trampoline_code_size);
@@ -68,7 +70,7 @@ int zynq_cpun_start(u32 address, int cpu)
 			if (__pa(PAGE_OFFSET))
 				iounmap(zero);
 		}
-		zynq_slcr_cpu_start(cpu);
+		zynq_slcr_cpu_start(phy_cpuid);
 
 		return 0;
 	}
-- 
2.17.1

