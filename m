Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE08144327
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAUR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 12:28:07 -0500
Received: from foss.arm.com ([217.140.110.172]:46354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:28:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8260830E;
        Tue, 21 Jan 2020 09:28:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82203F6C4;
        Tue, 21 Jan 2020 09:28:05 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:28:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>, robh+dt@kernel.org
Subject: Applied "ASoC: dt-bindings: rt5645: add suppliers" to the asoc tree
In-Reply-To: <20200114150151.8537-1-matthias.bgg@kernel.org>
Message-Id: <applied-20200114150151.8537-1-matthias.bgg@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: rt5645: add suppliers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 26aa19174f0d1837cb268b744f6dcb013265ab03 Mon Sep 17 00:00:00 2001
From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 14 Jan 2020 16:01:50 +0100
Subject: [PATCH] ASoC: dt-bindings: rt5645: add suppliers

The rt5645 and rt5650 have two suppliers, document them.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Link: https://lore.kernel.org/r/20200114150151.8537-1-matthias.bgg@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index a03f9a872a71..41a62fd2ae1f 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -10,6 +10,10 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Optional properties:
 
 - hp-detect-gpios:
-- 
2.20.1

