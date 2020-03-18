Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DD18A777
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 22:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCRV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 17:57:34 -0400
Received: from foss.arm.com ([217.140.110.172]:55482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgCRV5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:57:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0087330E;
        Wed, 18 Mar 2020 14:57:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76D9C3F52E;
        Wed, 18 Mar 2020 14:57:32 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:57:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: driver.h: fix regulator_map_* function names" to the regulator tree
In-Reply-To:  <b9f5687bcf981a88c9d1fd04d759a540fda53a99.1584456635.git.mchehab+huawei@kernel.org>
Message-Id:  <applied-b9f5687bcf981a88c9d1fd04d759a540fda53a99.1584456635.git.mchehab+huawei@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: driver.h: fix regulator_map_* function names

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

From bd3ebed9304acd2ccddde44675fedf963dbfdc71 Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 17 Mar 2020 15:54:26 +0100
Subject: [PATCH] regulator: driver.h: fix regulator_map_* function names

The toolchain produces a warning on this driver when building
the docs:

	./include/linux/regulator/driver.h:284: WARNING: Unknown target name: "regulator_regmap_x_voltage".

While fixing it, we notices that there's no function names
with the above pattern. It seems that some previous patch
renamed it to regulator_map_* instead.

So, change the function name, replacing "x" by "*", with is
a more used way to add a wildcard, and escape those with
``literal`` markup, in order to avoid the toolchain to think
that this is a link to some existing document chapter.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Link: https://lore.kernel.org/r/b9f5687bcf981a88c9d1fd04d759a540fda53a99.1584456635.git.mchehab+huawei@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 9a911bb5fb61..29d920516e0b 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -277,9 +277,9 @@ enum regulator_type {
  * @curr_table: Current limit mapping table (if table based mapping)
  *
  * @vsel_range_reg: Register for range selector when using pickable ranges
- *		    and regulator_regmap_X_voltage_X_pickable functions.
+ *		    and ``regulator_map_*_voltage_*_pickable`` functions.
  * @vsel_range_mask: Mask for register bitfield used for range selector
- * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
+ * @vsel_reg: Register for selector when using ``regulator_map_*_voltage_*``
  * @vsel_mask: Mask for register bitfield used for selector
  * @vsel_step: Specify the resolution of selector stepping when setting
  *	       voltage. If 0, then no stepping is done (requested selector is
-- 
2.20.1

