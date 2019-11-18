Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92559100631
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKRNKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 08:10:00 -0500
Received: from foss.arm.com ([217.140.110.172]:34538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfKRNJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:09:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D3681FB;
        Mon, 18 Nov 2019 05:09:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5563F6C4;
        Mon, 18 Nov 2019 05:09:57 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:09:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "ASoC: pcm3168a: Document optional RST gpio" to the asoc tree
In-Reply-To: <20191113124734.27984-2-peter.ujfalusi@ti.com>
Message-Id: <applied-20191113124734.27984-2-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3168a: Document optional RST gpio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From cdacc761dae1cbd6475ac79f0e732f2b1ca021e0 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 14:47:33 +0200
Subject: [PATCH] ASoC: pcm3168a: Document optional RST gpio

On boards where the RST line is not pulled up, but it is connected to a
GPIO line this property must present in order to be able to enable the
codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191113124734.27984-2-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
index 5d9cb84c661d..f30aebc7603a 100644
--- a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
+++ b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
@@ -25,6 +25,12 @@ Required properties:
 
 For required properties on SPI/I2C, consult SPI/I2C device tree documentation
 
+Optional properties:
+
+  - rst-gpios : Optional RST gpio line for the codec
+		RST = low: device power-down
+		RST = high: device is enabled
+
 Examples:
 
 i2c0: i2c0@0 {
@@ -34,6 +40,7 @@ i2c0: i2c0@0 {
 	pcm3168a: audio-codec@44 {
 		compatible = "ti,pcm3168a";
 		reg = <0x44>;
+		rst-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
 		clocks = <&clk_core CLK_AUDIO>;
 		clock-names = "scki";
 		VDD1-supply = <&supply3v3>;
-- 
2.20.1

