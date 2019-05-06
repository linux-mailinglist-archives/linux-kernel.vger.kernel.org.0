Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4274214B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:51:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45712 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=foLRJ95fVzlyBOYQo4XCM1XGFmZlXrGXPccu2GVICFA=; b=AepfxQ0pUAJC
        cMqeDbM5pyH2X53QKpSIIK1cr/ijcg7KRroVelwnQ6fWTwgtR9jL//dUICL5IY9CGnU1kpjAvNF97
        EPL2KkGdlbCxl85+m4ucbwJNhBv5q0Tm//KHBCsQUtyVd+X9bqgXj7ILQYlcG6eByO1IbSdTkj9X+
        Ytxvo=;
Received: from [2001:268:c0e6:658d:8f3d:d90b:c4e4:2fdf] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNe1u-0001jB-U5; Mon, 06 May 2019 13:51:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E96D944000C; Mon,  6 May 2019 14:51:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     alsa-devel@alsa-project.org, baolin.wang@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, perex@perex.cz, tiwai@suse.com,
        zhang.lyra@gmail.com
Subject: Applied "ASoC: sprd: Add reserved DMA memory support" to the asoc tree
In-Reply-To:  <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190506135136.E96D944000C@finisterre.ee.mobilebroadband>
Date:   Mon,  6 May 2019 14:51:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Add reserved DMA memory support

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

From 1587a061ef562de0d97c82a95863e191bcd69d63 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 12 Apr 2019 14:40:17 +0800
Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support

For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
dynamically to copy audio data between userspace and kernel space, but that
will increase the risk of memory allocation failure especially the system
is under heavy load situation.

To make sure the audio can work in this scenario, we usually reserve one
region of memory to be used as a shared pool of DMA buffers for the
platform component. So add of_reserved_mem_device_init_by_idx() function
to initialize the shared pool of DMA buffers to be used by the platform
component.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 9be6d4b2bf74..d38ebbbbf169 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -6,6 +6,7 @@
 #include <linux/dma/sprd-dma.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -530,8 +531,14 @@ static const struct snd_soc_component_driver sprd_soc_component = {
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "no reserved DMA memory for audio platform device\n");
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
 					      NULL, 0);
 	if (ret)
-- 
2.20.1

