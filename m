Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDCF9948
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKLTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 14:03:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfKLTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:03:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iUbQh-0001Z1-4J; Tue, 12 Nov 2019 19:02:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: tas2770: clean up an indentation issue
Date:   Tue, 12 Nov 2019 19:02:18 +0000
Message-Id: <20191112190218.282337-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a block that is indented too deeply, remove
the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tas2770.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index ad76f22fcfac..54c8135fe43c 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -761,12 +761,12 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
 							  "reset-gpio",
 						      GPIOD_OUT_HIGH);
-		if (IS_ERR(tas2770->reset_gpio)) {
-			if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
-				tas2770->reset_gpio = NULL;
-				return -EPROBE_DEFER;
-			}
+	if (IS_ERR(tas2770->reset_gpio)) {
+		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
+			tas2770->reset_gpio = NULL;
+			return -EPROBE_DEFER;
 		}
+	}
 
 	tas2770->channel_size = 0;
 	tas2770->slot_width = 0;
-- 
2.20.1

