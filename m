Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D221F14E314
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgA3TWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 14:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgA3TWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:22:47 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9A3205F4;
        Thu, 30 Jan 2020 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412166;
        bh=/ADDyZGeUBrFy1yM/2Cjxlczx2El2xTo64aBpM00OOA=;
        h=From:To:Cc:Subject:Date:From;
        b=mBMeleaLkrp1L5YIelNo1iiPfVr7glrgDlnpHKaAkSpQH0cBL/Y6ukaEvybMHE41r
         hGJubOrIAWir23oxOPSQNgNm80FIkkabQ1YLqD3SRvGgmr8PFamLByTz3gRrFDjQgO
         xwWHNilCLN1EVG4W7LVP40vRCKD42/Wv2omGPQ8s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] csky: Cleanup old Kconfig options
Date:   Thu, 30 Jan 2020 20:22:40 +0100
Message-Id: <20200130192240.2881-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CLKSRC_OF is gone since commit bb0eb050a577
("clocksource/drivers: Rename CLKSRC_OF to TIMER_OF").  The platform
already selects TIMER_OF.

CONFIG_HAVE_DMA_API_DEBUG is gone since commit 6e88628d03dd ("dma-debug:
remove CONFIG_HAVE_DMA_API_DEBUG").

CONFIG_DEFAULT_DEADLINE is gone since commit f382fb0bcef4 ("block:
remove legacy IO schedulers").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/csky/Kconfig           | 2 --
 arch/csky/configs/defconfig | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4acef4088de7..0d6a6af7751d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,7 +9,6 @@ config CSKY
 	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
 	select COMMON_CLK
 	select CLKSRC_MMIO
-	select CLKSRC_OF
 	select CSKY_MPINTC if CPU_CK860
 	select CSKY_MP_TIMER if CPU_CK860
 	select CSKY_APB_INTC
@@ -47,7 +46,6 @@ config CSKY
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
index 7ef42895dfb0..3b540539dbe6 100644
--- a/arch/csky/configs/defconfig
+++ b/arch/csky/configs/defconfig
@@ -10,7 +10,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_DEFAULT_DEADLINE=y
 CONFIG_CPU_CK807=y
 CONFIG_CPU_HAS_FPU=y
 CONFIG_NET=y
-- 
2.17.1

