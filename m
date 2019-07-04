Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16005F800
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfGDMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 08:25:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfGDMZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vFXKWZbVlhtP1uV3m8Dyf6rla7JmlnmBJTS3Fskfk3I=; b=mm0hugq4fRA9
        ejjmmKIjkCCbP7VOXFMeeNif7zZri8yEK7qmskL8U7p2b+jCRPmiVLtu4JmoSTdofNT5ysqXHwzS/
        YoaFUueq/YaFHVaf30i0SPNttcVfLhL9NjRpUFUtp8Bj35V6E1mxHhomEcsCse8y8VJrWldu+Zn6Z
        otkRo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0nH-0000ig-9E; Thu, 04 Jul 2019 12:24:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A00DD274389C; Thu,  4 Jul 2019 13:24:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm-formatter: add reset to the bindings documentation" to the asoc tree
In-Reply-To: <20190703120749.32341-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190704122454.A00DD274389C@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 13:24:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm-formatter: add reset to the bindings documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 094380ea2bf9f0fa7d63e67bf500b8c77e8d1910 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 3 Jul 2019 14:07:48 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: add reset to the bindings
 documentation

Add an optional reset property to the tdm formatter bindings. The
dedicated reset line is present on some SoC families, such as the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190703120749.32341-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-tdm-formatters.txt           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 3b94a715a0b9..8835a43edfbb 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -15,11 +15,15 @@ Required properties:
   * "lrclk"    : sample clock
   * "lrclk_sel": sample clock input multiplexer
 
-Example of TDMOUT_A on the A113 SoC:
+Optional property:
+- resets: phandle to the dedicated reset line of the tdm formatter.
+
+Example of TDMOUT_A on the S905X2 SoC:
 
 tdmout_a: audio-controller@500 {
 	compatible = "amlogic,axg-tdmout";
 	reg = <0x0 0x500 0x0 0x40>;
+	resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
 	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
 		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
 		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
-- 
2.20.1

