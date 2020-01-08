Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885CB1346D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgAHP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:59:05 -0500
Received: from foss.arm.com ([217.140.110.172]:46660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgAHP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 518FA328;
        Wed,  8 Jan 2020 07:59:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD6253F534;
        Wed,  8 Jan 2020 07:59:00 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        heiko@sntech.de, icenowy@aosc.io, Jonathan.Cameron@huawei.com,
        laurent.pinchart@ideasonboard.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, mchehab+samsung@kernel.org,
        mripard@kernel.org, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>, sam@ravnborg.org,
        shawnguo@kernel.org, sravanhome@gmail.com
Subject: Applied "dt-bindings: Add an entry for Monolithic Power System, MPS" to the regulator tree
In-Reply-To: <20200108131234.24128-2-sravanhome@gmail.com>
Message-Id: <applied-20200108131234.24128-2-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: Add an entry for Monolithic Power System, MPS

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From 9399e5dc6b679994872a6039849547c416bb6b05 Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Wed, 8 Jan 2020 14:12:31 +0100
Subject: [PATCH] dt-bindings: Add an entry for Monolithic Power System, MPS

Add an entry for Monolithic Power System, MPS

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200108131234.24128-2-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..5eac9d08bfa8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -605,6 +605,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mps,.*":
+    description: Monolithic Power Systems, Inc.
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.20.1

