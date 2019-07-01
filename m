Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24A211129
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 04:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBCSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 22:18:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56044 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfEBCSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gUX7cgUSecfjVH1YPs8zG06dexR+UJShlkpV9/2EzyE=; b=c8EcTqPhucPW
        y8sW8JkO1Nt+N+n8ulkl7Nx2swEWdqNZ26DL/bvv5PQz7bH3SypyKoACZkQVzo+Ag0ZDh911ZTqI/
        ly9+HXsAy1TjPC59revy/JKGOWj0xhauDWhuKPW7Fbh0xiIf9rIw0mUAP2a9ujBXXk5BUH/W9ovVL
        pbkQc=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Ix-0005sN-At; Thu, 02 May 2019 02:18:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 499DE441D3C; Thu,  2 May 2019 03:18:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, daniel.baluta@gmail.com,
        festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, s.hauer@pengutronix.de, shawnguo@kernel.org,
        tglx@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: mpc5200_psc_i2s: Fix invalid license ID" to the asoc tree
In-Reply-To:  <20190414191450.18377-3-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021832.499DE441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mpc5200_psc_i2s: Fix invalid license ID

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 680ae69d52279474ecb204f0f7bae1f4d9361cbd Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Sun, 14 Apr 2019 22:14:50 +0300
Subject: [PATCH] ASoC: mpc5200_psc_i2s: Fix invalid license ID

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 864a8472c4412 ("ASoC: mpc5200_psc_i2s: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 6de97461ba25..9bc01f374b39 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC in I2S mode
 // ALSA SoC Digital Audio Interface (DAI) driver
-- 
2.20.1

