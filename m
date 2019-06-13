Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8651C44BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfFMTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 15:06:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfFMTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7mmi4XPUb9kweIO/XutIMTWP+evApFPSoJxpuHGkTcc=; b=cb0JioMRBD/O
        0uvo8szUOLwgbD7dmI8lG90EGWlfjX2l7KbRrOvYpkfYgQE/VJYJi9RGtVOTiYjeKg5aN94VLnKeV
        CrLXkqVOUmYnSkchdk+cKiM0E/8+7jP2geSmGX9ZZZLtsjMyWd2sIHw4RCC+DvnnYa1dpECOEBMBG
        oBUXg=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbV36-0005Sy-Tz; Thu, 13 Jun 2019 19:06:12 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 671D7440046; Thu, 13 Jun 2019 20:06:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdmin: right_j is not supported" to the asoc tree
In-Reply-To: <20190613114233.21130-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190613190612.671D7440046@finisterre.sirena.org.uk>
Date:   Thu, 13 Jun 2019 20:06:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdmin: right_j is not supported

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 47c317b786b6c1efc2cb3cdb894fd323422fe5ea Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Jun 2019 13:42:30 +0200
Subject: [PATCH] ASoC: meson: axg-tdmin: right_j is not supported

Right justified format is actually not supported by the amlogic tdm input
decoder.

Fixes: 13a22e6a98f8 ("ASoC: meson: add tdm input driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdmin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index a790f925a4ef..cb87f17f3e95 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -121,7 +121,6 @@ static int axg_tdmin_prepare(struct regmap *map,
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
-	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
 		break;
 
-- 
2.20.1

