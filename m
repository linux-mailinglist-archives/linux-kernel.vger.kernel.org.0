Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138454CF59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfFTNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 09:47:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49588 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:47:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C036826126D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Benson Leung <bleung@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample rates
Date:   Thu, 20 Jun 2019 15:47:08 +0200
Message-Id: <20190620134708.28311-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the max98357a also supports 32, 44.1 and
88.2 kHz sample rate. This support was also introduced recently by
commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
This patch adds support for these rates also for the machine driver so
we get rid of the errors like the below and we are able to play files
using these sample rates.

  rk3399-gru-sound sound: rockchip_sound_max98357a_hw_params() doesn't support this sample rate: 44100
  rk3399-gru-sound sound: ASoC: machine hw_params failed: -22

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3d0cc6e90d7b..8dfe1a560e42 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -59,7 +59,10 @@ static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substrea
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 32000:
+	case 44100:
 	case 48000:
+	case 88200:
 	case 96000:
 		mclk = params_rate(params) * SOUND_FS;
 		break;
-- 
2.20.1

