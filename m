Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8697D12F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGaWdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 18:33:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54925 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaWdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:33:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hsx98-0008H1-UL; Wed, 31 Jul 2019 22:32:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: zx-tdm: remove redundant assignment to ts_width on error return path
Date:   Wed, 31 Jul 2019 23:32:34 +0100
Message-Id: <20190731223234.16153-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The value assigned to ts_width is never read on the error return path
so the assignment is redundant and can be removed.  Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/zte/zx-tdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index 5e877fe9ba7b..0e5a05b25a77 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -211,7 +211,6 @@ static int zx_tdm_hw_params(struct snd_pcm_substream *substream,
 		ts_width = 1;
 		break;
 	default:
-		ts_width = 0;
 		dev_err(socdai->dev, "Unknown data format\n");
 		return -EINVAL;
 	}
-- 
2.20.1

