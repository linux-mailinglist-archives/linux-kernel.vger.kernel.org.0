Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4F8BBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfHMOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:40:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728189AbfHMOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:40:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C0FBE3692B21E72ED1B;
        Tue, 13 Aug 2019 22:40:31 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 22:40:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.c>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt8183-da7219-max98357: remove unused variable
Date:   Tue, 13 Aug 2019 22:39:52 +0800
Message-ID: <20190813143952.29232-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:120:1: warning:
 mt8183_da7219_max98357_dapm_widgets defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:124:40: warning:
 mt8183_da7219_max98357_dapm_routes defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 59076e2..b0db8a5 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -116,15 +116,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget
-mt8183_da7219_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("IT6505_8CH"),
-};
-
-static const struct snd_soc_dapm_route mt8183_da7219_max98357_dapm_routes[] = {
-	{"IT6505_8CH", NULL, "TDM"},
-};
-
 /* FE */
 SND_SOC_DAILINK_DEFS(playback1,
 	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
-- 
2.7.4


