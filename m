Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5865D005
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGBNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 09:04:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfGBNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+m5IGuZkVFXcM+PPemNdUpIzCK7jbrEJHcwpeMMMscE=; b=GdqpzKnQcQx2
        dLR8abH0dl6zLWi6qjCpkMatPW3/TfyGAbhlXUwGAzVp4px/2M19toEkgAuqwXMcu9gRIoaQ/nDqK
        UNR3SlM83MplYFzewUq7dWcWSNG4de2Aetu6HWxvoDFWIWYZV3gq/+lCzRvCNRFS2P1Lex+BG0JH0
        wbSjk=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISh-0002Nb-AM; Tue, 02 Jul 2019 13:04:43 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id AA6C844004B; Tue,  2 Jul 2019 14:04:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org,
        Brian Austin <brian.austin@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: madera: Remove duplicated include from cs47l35.c" to the asoc tree
In-Reply-To: <20190629024333.177027-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130442.AA6C844004B@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: madera: Remove duplicated include from cs47l35.c

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

From 559e92f78778a171adfb152f49a78e202f5b39df Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 29 Jun 2019 02:43:33 +0000
Subject: [PATCH] ASoC: madera: Remove duplicated include from cs47l35.c

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
index 511d0d6fa962..e3585c1dab3d 100644
--- a/sound/soc/codecs/cs47l35.c
+++ b/sound/soc/codecs/cs47l35.c
@@ -19,7 +19,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
-#include <sound/tlv.h>
 
 #include <linux/irqchip/irq-madera.h>
 #include <linux/mfd/madera/core.h>
-- 
2.20.1

