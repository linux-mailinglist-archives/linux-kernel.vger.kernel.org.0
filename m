Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F584D65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfHGNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 09:33:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbfHGNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Wu9sugkEEsUhkvknH7uSAfy3bNShHg3ioU3CI9Flyl8=; b=BC7xKV3U+6Ft
        8BnglARL2Q/kiNkhN1uXN+DhE4MbYbxc+bGhxKitX+7dUE4E883tV8+/D4xtUb8Td0dln40xHe/d3
        f1AAM2xXAjLdRclxgLv6tikogMx5539KAH2Ju8d1QppL/AS8jnTdvRp0fu26xdlEQaDC4ys0Ne91L
        J2jNY=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvM1h-0007fl-V5; Wed, 07 Aug 2019 13:30:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4088D2742B9E; Wed,  7 Aug 2019 14:30:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, angus@akkea.ca, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, l.stach@pengutronix.de,
        Mark Brown <broonie@kernel.org>, mihai.serban@gmail.com,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        robh@kernel.org, shengjiu.wang@nxp.com, timur@kernel.org,
        tiwai@suse.com
Subject: Applied "ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ" to the asoc tree
In-Reply-To: <20190806151214.6783-6-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190807133049.4088D2742B9E@ypsilon.sirena.org.uk>
Date:   Wed,  7 Aug 2019 14:30:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 371be51a925a619f1fb149b8d7707e353d9c9f86 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 6 Aug 2019 18:12:14 +0300
Subject: [PATCH] ASoC: dt-bindings: Introduce compatible strings for 7ULP and
 8MQ

For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
strings to differentiate this.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190806151214.6783-6-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 2e726b983845..e61c0dc1fc0b 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -8,7 +8,8 @@ codec/DSP interfaces.
 Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
-			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
+			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
+			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1

