Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199CE107B49
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVX1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 18:27:08 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46327 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:27:08 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D510723CF6;
        Sat, 23 Nov 2019 00:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574465226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yPu+usdTMaBaw0ZFV5ndDgVLntK9TwEKvBhp47O63LA=;
        b=e+PaxCeVa0VVHHfBSnL6lLpBiRdU8xUAzEXcepo0hNXvwAbbUBIEzo1Pb7zDUj83APBPuy
        JpYuIM2mi9wgjiFeli0r3PK7TJGvzWQ1REK48f1Te1QHDangLmWOdi7HdqpepOZv2IUFgG
        mXwCAdgOlim1lv29++kRZe0Hwyk4nAg=
From:   Michael Walle <michael@walle.cc>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ASoC: wm8904: fix automatic sysclk configuration
Date:   Sat, 23 Nov 2019 00:25:32 +0100
Message-Id: <20191122232532.22258-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: web
X-Spam-Status: No, score=4.90
X-Spam-Score: 4.90
X-Rspamd-Queue-Id: D510723CF6
X-Spamd-Result: default: False [4.90 / 15.00];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.522];
         FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,opensource.cirrus.com,walle.cc]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-card tries to signal the codec to disable rate constraints,
see commit 2458adb8f92a ("SoC: simple-card-utils: set 0Hz to sysclk when
shutdown"). This wasn't handled by the codec, instead it would set the
FLL frequency to 0Hz which isn't working. Since we don't have any rate
constraints just ignore this request.

Fixes: 13409d27cb39 ("ASoC: wm8904: configure sysclk/FLL automatically")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 sound/soc/codecs/wm8904.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 7d7ea15d73e0..5ffbaddd6e49 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1806,6 +1806,12 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	switch (clk_id) {
 	case WM8904_CLK_AUTO:
+		/* We don't have any rate constraints, so just ignore the
+		 * request to disable constraining.
+		 */
+		if (!freq)
+			return 0;
+
 		mclk_freq = clk_get_rate(priv->mclk);
 		/* enable FLL if a different sysclk is desired */
 		if (mclk_freq != freq) {
-- 
2.20.1

