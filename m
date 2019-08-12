Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB389F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfHLNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:10:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfHLNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=726K291caKRqeiB2KOs9bhqJM6YwCvuRpeAmBC8Mkio=; b=ktfWXSNR+l0P
        q5iJ5adjeOtLSykywMzb8U5/PwlMfF0qOvFzNeM4ApqXoF6j29TXCCdueFh6t6JBOQVmfX9mHexQr
        5zknyGi1AFf5SNP8+DxpGCR60/MDOGHEh9hFw80PZZbGO8ssAsyByjklT8qv6tw8qnmX0p46Pj2Dn
        7AXV8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA5B-0001Mg-HX; Mon, 12 Aug 2019 13:09:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E77BF2740CBD; Mon, 12 Aug 2019 14:09:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     allison@lohutok.net, alsa-devel@alsa-project.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: max9850: remove unused variable 'max9850_reg'" to the asoc tree
In-Reply-To: <20190808143507.66788-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812130952.E77BF2740CBD@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:09:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max9850: remove unused variable 'max9850_reg'

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

From c86102a333f77dcd0f7ef20ba836c6f13f1a077a Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Aug 2019 22:35:07 +0800
Subject: [PATCH] ASoC: max9850: remove unused variable 'max9850_reg'

sound/soc/codecs/max9850.c:31:33: warning:
 max9850_reg defined but not used [-Wunused-const-variable=]

It is not used since commit 068416620c0d ("ASoC:
max9850: Convert to direct regmap API usage")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190808143507.66788-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9850.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index f50ee8f5fe93..6f43748f9239 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -27,19 +27,6 @@ struct max9850_priv {
 	unsigned int sysclk;
 };
 
-/* max9850 register cache */
-static const struct reg_default max9850_reg[] = {
-	{  2, 0x0c },
-	{  3, 0x00 },
-	{  4, 0x00 },
-	{  5, 0x00 },
-	{  6, 0x00 },
-	{  7, 0x00 },
-	{  8, 0x00 },
-	{  9, 0x00 },
-	{ 10, 0x00 },
-};
-
 /* these registers are not used at the moment but provided for the sake of
  * completeness */
 static bool max9850_volatile_register(struct device *dev, unsigned int reg)
-- 
2.20.1

