Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41FA0347
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfH1Nby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:31:54 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:45882 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfH1Nby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:54 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id udXs2000605gfCL01dXsyp; Wed, 28 Aug 2019 15:31:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2y3E-0000Bb-3c; Wed, 28 Aug 2019 15:31:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2y3E-0005Mn-1N; Wed, 28 Aug 2019 15:31:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: ARM_ERRATA_775420: Spelling s/date/data/
Date:   Wed, 28 Aug 2019 15:31:51 +0200
Message-Id: <20190828133151.20585-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caching dates is never a good idea ;-)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dcf46f0e45c24a5f..eb18279a63027c08 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1040,7 +1040,7 @@ config ARM_ERRATA_775420
        depends on CPU_V7
        help
 	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
-	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
+	 r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
 	 operation aborts with MMU exception, it might cause the processor
 	 to deadlock. This workaround puts DSB before executing ISB if
 	 an abort may occur on cache maintenance.
-- 
2.17.1

