Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF43619747
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 06:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfEJEA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 00:00:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfEJEA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:00:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 449428E409AA2E2FDA63;
        Fri, 10 May 2019 12:00:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 12:00:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <marc.zyngier@arm.com>, <lokeshvutla@ti.com>, <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] arm64: arch_k3: Fix kconfig dependency warning
Date:   Fri, 10 May 2019 11:52:55 +0800
Message-ID: <20190510035255.27568-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Kbuild warning when SOC_TI is not set

WARNING: unmet direct dependencies detected for TI_SCI_INTA_IRQCHIP
  Depends on [n]: TI_SCI_PROTOCOL [=y] && SOC_TI [=n]
  Selected by [y]:
  - ARCH_K3 [=y]

Fixes: 009669e74813 ("arm64: arch_k3: Enable interrupt controller drivers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 42eca65..9d1292f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -88,6 +88,7 @@ config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select PM_GENERIC_DOMAINS if PM
 	select MAILBOX
+	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
-- 
2.7.4


