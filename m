Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D629C165070
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 21:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBSU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 15:58:27 -0500
Received: from foss.arm.com ([217.140.110.172]:56886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgBSU61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:58:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED44F1FB;
        Wed, 19 Feb 2020 12:58:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72EAA3F68F;
        Wed, 19 Feb 2020 12:58:26 -0800 (PST)
Date:   Wed, 19 Feb 2020 20:58:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Phong LE <ple@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: wrong descriptions in regmap_range_cfg" to the regmap tree
In-Reply-To:  <20200219140906.29180-1-ple@baylibre.com>
Message-Id:  <applied-20200219140906.29180-1-ple@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: wrong descriptions in regmap_range_cfg

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From ad5906bd6e9aa3e156dcac8fc070b153648e8b68 Mon Sep 17 00:00:00 2001
From: Phong LE <ple@baylibre.com>
Date: Wed, 19 Feb 2020 15:09:06 +0100
Subject: [PATCH] regmap: wrong descriptions in regmap_range_cfg

Swap selector_mask and selector_shift descriptions

Signed-off-by: Phong LE <ple@baylibre.com>
Link: https://lore.kernel.org/r/20200219140906.29180-1-ple@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f0a092a1a96d..40b07168fd8e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -461,8 +461,8 @@ struct regmap_config {
  * @range_max: Address of the highest register in virtual range.
  *
  * @selector_reg: Register with selector field.
- * @selector_mask: Bit shift for selector value.
- * @selector_shift: Bit mask for selector value.
+ * @selector_mask: Bit mask for selector value.
+ * @selector_shift: Bit shift for selector value.
  *
  * @window_start: Address of first (lowest) register in data window.
  * @window_len: Number of registers in data window.
-- 
2.20.1

