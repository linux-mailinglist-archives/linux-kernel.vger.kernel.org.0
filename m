Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38EE97A57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHUNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:07:07 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E41233A2;
        Wed, 21 Aug 2019 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566392826;
        bh=0v32ZZ6O33elaDt+S/HSHNT2AKsZguqxcmZy9fXnA5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFNALjloL3/59PvwnxTEmnNmtZdMI+aNHJOg/zLFuAseYN1viWCohC8c4k1UcvlM8
         B4K897XB/EWC16jRBjilSBllM3MjSc3hqizzUCBsCbCO5LgMvlyUPC+xHMw6jMUEt+
         0Jw/qJsX9/BImCIGMXCdfgFLLNWLuN1GIE95uaIg=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ASoC: sun4i-i2s: Replace call to params_width by local variable
Date:   Wed, 21 Aug 2019 15:06:55 +0200
Message-Id: <f85a1c1e014080a4bbc3abd19bc8fdcb86f0981a.1566392800.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
References: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The sun4i_i2s_hw_params function already has a variable holding the value
returned by params_width, so let's just use that variable instead of
calling params_width multiple times.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9ef784b8867c..69162af9fd65 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -487,7 +487,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	sr = i2s->variant->get_sr(i2s, params_width(params));
+	sr = i2s->variant->get_sr(i2s, word_size);
 	if (sr < 0)
 		return -EINVAL;
 
-- 
git-series 0.9.1
