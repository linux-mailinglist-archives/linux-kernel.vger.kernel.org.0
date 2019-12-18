Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76CC1252A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfLRUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 15:05:50 -0500
Received: from foss.arm.com ([217.140.110.172]:59320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLRUFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:05:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E714811B3;
        Wed, 18 Dec 2019 12:05:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D8D3F67D;
        Wed, 18 Dec 2019 12:05:47 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:05:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-fifo: add fifo depth to the bindings documentation" to the asoc tree
In-Reply-To: <20191218172420.1199117-3-jbrunet@baylibre.com>
Message-Id: <applied-20191218172420.1199117-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-fifo: add fifo depth to the bindings documentation

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

From fb522dbb4531c14193115a09905c6c31b37dbfc5 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 18 Dec 2019 18:24:18 +0100
Subject: [PATCH] ASoC: meson: axg-fifo: add fifo depth to the bindings
 documentation

Add a new property with the depth of the fifo in bytes. This is useful
since some instance of the fifo, even on the same SoC, may have different
depth. The depth is useful is set some parameters of the fifo.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191218172420.1199117-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 3080979350a0..fa4545ed81ca 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -17,6 +17,9 @@ Required properties:
   * "arb" : memory ARB line (required)
   * "rst" : dedicated device reset line (optional)
 - #sound-dai-cells: must be 0.
+- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
+  		      is useful for determining certain configuration such
+		      as the flush threshold of the fifo
 
 Example of FRDDR A on the A113 SoC:
 
@@ -27,4 +30,5 @@ frddr_a: audio-controller@1c0 {
 	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
 	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
 	resets = <&arb AXG_ARB_FRDDR_A>;
+	fifo-depth = <512>;
 };
-- 
2.20.1

