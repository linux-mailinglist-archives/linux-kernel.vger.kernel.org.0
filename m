Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AACE8BBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfHMOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:41:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfHMOln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:41:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A454B43459FFE8AA5303;
        Tue, 13 Aug 2019 22:41:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 22:41:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.c>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: remove unused variables
Date:   Tue, 13 Aug 2019 22:41:22 +0800
Message-ID: <20190813144122.67676-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:50:1: warning:
 mt8183_mt6358_ts3a227_max98357_dapm_widgets defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:55:1: warning:
 mt8183_mt6358_ts3a227_max98357_dapm_routes defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 4c816c8..dcd47b9 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -46,16 +46,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget
-mt8183_mt6358_ts3a227_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("IT6505_8CH"),
-};
-
-static const struct snd_soc_dapm_route
-mt8183_mt6358_ts3a227_max98357_dapm_routes[] = {
-	{"IT6505_8CH", NULL, "TDM"},
-};
-
 static int
 mt8183_mt6358_ts3a227_max98357_bt_sco_startup(
 	struct snd_pcm_substream *substream)
-- 
2.7.4


