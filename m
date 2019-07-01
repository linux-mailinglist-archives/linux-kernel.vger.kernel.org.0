Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A017486FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfFQPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 11:24:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfFQPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CIY51a7RXn+3BakapD28ylMMASdeoR+L+pX2WrJ2130=; b=k4a61FsmCo7X
        ILeku7cXPaNGUbrKgAyZYzc+VMKe4+0PhcAWqPU9T5jp1sJFUDUvSMaG2xmVaS+xPeUE5GhoohZ2D
        y+9SMNSF6w41Lqe6BNxtXr25k+eHrHzdBXpgIIZaIK+2J05wUCoxYGCinVgtMT4wY4K2O8WJQ9tat
        pBxWM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctUk-0001zC-H4; Mon, 17 Jun 2019 15:24:30 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 031FB440046; Mon, 17 Jun 2019 16:24:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, simon.ho@synaptics.com
Subject: Applied "ASoC: cx2072x: mark PM function as __maybe_unused" to the asoc tree
In-Reply-To: <20190617110615.2084748-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190617152430.031FB440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cx2072x: mark PM function as __maybe_unused

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

From 83ee240aad9147ed5dac5a7c7b4c559d134072e7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 13:06:15 +0200
Subject: [PATCH] ASoC: cx2072x: mark PM function as __maybe_unused

While the suspend function is already marked __maybe_unused,
the resume function is not, which leads to a warning when
CONFIG_PM is disabled:

sound/soc/codecs/cx2072x.c:1625:12: error: unused function 'cx2072x_runtime_resume' [-Werror,-Wunused-function]

Mark this one like the other one.

Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index f2cb35a50726..1c1ba7bea4d8 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1622,7 +1622,7 @@ static int __maybe_unused cx2072x_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cx2072x_runtime_resume(struct device *dev)
+static int __maybe_unused cx2072x_runtime_resume(struct device *dev)
 {
 	struct cx2072x_priv *cx2072x = dev_get_drvdata(dev);
 
-- 
2.20.1

