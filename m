Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1178E139477
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 16:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgAMPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 10:13:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=c5J9qc4h8pH18cTk38z36ZrKwJaZxSaR5F4bNDe5Ibk=; b=O+eep0PKHpkk
        MYs62CvT7DKdaquFH0GeGkGyREC9ysyqdn00ZoJ3Hao+MyxNqxaCYHptfs0tznIKK2xaRoGiFxPdW
        4d7eBA364pw2xyQJWnNkuBtVby+Gs0hQHZ5PQMv89mG/PEW+oNrB5n/EJFk8qQGLzZlJ0D7pHNau0
        raWYM=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir1Oq-0003Kz-U1; Mon, 13 Jan 2020 15:13:04 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A6B71D01965; Mon, 13 Jan 2020 15:13:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>, alsa-devel@alsa-project.org,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Subject: Applied "ASoC: cros_ec_codec: Make the device acpi compatible" to the asoc tree
In-Reply-To:  <20200112054900.236576-1-yuhsuan@chromium.org>
Message-Id:  <applied-20200112054900.236576-1-yuhsuan@chromium.org>
X-Patchwork-Hint: ignore
Date:   Mon, 13 Jan 2020 15:13:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cros_ec_codec: Make the device acpi compatible

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

From 877167ef343de2a9be3d31cdd5c41122e61190dd Mon Sep 17 00:00:00 2001
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date: Sun, 12 Jan 2020 13:49:00 +0800
Subject: [PATCH] ASoC: cros_ec_codec: Make the device acpi compatible

Add ACPI entry for cros_ec_codec.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Link: https://lore.kernel.org/r/20200112054900.236576-1-yuhsuan@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cros_ec_codec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index dd14caf9091a..bc31e5a9a2a7 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -10,6 +10,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -1047,10 +1048,17 @@ static const struct of_device_id cros_ec_codec_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
 #endif
 
+static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
+	{ "GOOG0013", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_codec_acpi_id);
+
 static struct platform_driver cros_ec_codec_platform_driver = {
 	.driver = {
 		.name = "cros-ec-codec",
 		.of_match_table = of_match_ptr(cros_ec_codec_of_match),
+		.acpi_match_table = ACPI_PTR(cros_ec_codec_acpi_id),
 	},
 	.probe = cros_ec_codec_platform_probe,
 };
-- 
2.20.1

