Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0B873CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405878AbfHIIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 04:10:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405612AbfHIIKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:10:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D02341050730CA2F7CED;
        Fri,  9 Aug 2019 16:10:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:09:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mt6351: remove unused variable 'mt_lineout_control'
Date:   Fri, 9 Aug 2019 16:02:34 +0800
Message-ID: <20190809080234.23332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/mt6351.c:1070:38: warning:
 mt_lineout_control defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/mt6351.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index 4b3ce01..5c0536e 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1066,11 +1066,6 @@ static int mt_mic_bias_2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-/* DAPM Kcontrols */
-static const struct snd_kcontrol_new mt_lineout_control =
-	SOC_DAPM_SINGLE("Switch", MT6351_AUDDEC_ANA_CON3,
-			RG_AUDLOLPWRUP_VAUDP32_BIT, 1, 0);
-
 /* DAPM Widgets */
 static const struct snd_soc_dapm_widget mt6351_dapm_widgets[] = {
 	/* Digital Clock */
-- 
2.7.4


