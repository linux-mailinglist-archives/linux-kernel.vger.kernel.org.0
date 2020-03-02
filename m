Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3920E175F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCBQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 11:05:07 -0500
Received: from foss.arm.com ([217.140.110.172]:34636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbgCBQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755AC2F;
        Mon,  2 Mar 2020 08:05:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDFC3F534;
        Mon,  2 Mar 2020 08:05:05 -0800 (PST)
Date:   Mon, 02 Mar 2020 16:05:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: anatop: Improve Kconfig dependency" to the regulator tree
In-Reply-To:  <1583150118-8014-1-git-send-email-Anson.Huang@nxp.com>
Message-Id:  <applied-1583150118-8014-1-git-send-email-Anson.Huang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: anatop: Improve Kconfig dependency

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6179b0e90cbc0117cd4ff994bc24f4ea417b11d7 Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Mon, 2 Mar 2020 19:55:18 +0800
Subject: [PATCH] regulator: anatop: Improve Kconfig dependency

ANATOP regulator should depend on ARCH_MXC or COMPILE_TEST.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Link: https://lore.kernel.org/r/1583150118-8014-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b8ae513514a8..64a39f34ef37 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -107,6 +107,7 @@ config REGULATOR_AD5398
 
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on MFD_SYSCON
 	help
 	  Say y here to support Freescale i.MX on-chip ANATOP LDOs
-- 
2.20.1

