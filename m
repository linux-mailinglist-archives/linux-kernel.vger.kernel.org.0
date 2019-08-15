Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B577F8E830
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfHOJ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 05:26:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731385AbfHOJ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:26:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06BAE57D9039B02D2BAC;
        Thu, 15 Aug 2019 17:26:09 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:25:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>,
        <kstewart@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: 88pm860x: remove unused variables 'pcm_switch_controls' and 'aif1_mux'
Date:   Thu, 15 Aug 2019 17:25:47 +0800
Message-ID: <20190815092547.29564-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/88pm860x-codec.c:533:38: warning:
 pcm_switch_controls defined but not used [-Wunused-const-variable=]
sound/soc/codecs/88pm860x-codec.c:560:38: warning:
 aif1_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/88pm860x-codec.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index e982722..00b2c43 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -529,10 +529,6 @@ static const struct snd_kcontrol_new pm860x_snd_controls[] = {
  * DAPM Controls
  */
 
-/* PCM Switch / PCM Interface */
-static const struct snd_kcontrol_new pcm_switch_controls =
-	SOC_DAPM_SINGLE("Switch", PM860X_ADC_EN_2, 0, 1, 0);
-
 /* AUX1 Switch */
 static const struct snd_kcontrol_new aux1_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_ANA_TO_ANA, 4, 1, 0);
@@ -549,17 +545,6 @@ static const struct snd_kcontrol_new lepa_switch_controls =
 static const struct snd_kcontrol_new repa_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_DAC_EN_2, 1, 1, 0);
 
-/* PCM Mux / Mux7 */
-static const char *aif1_text[] = {
-	"PCM L", "PCM R",
-};
-
-static SOC_ENUM_SINGLE_DECL(aif1_enum,
-			    PM860X_PCM_IFACE_3, 6, aif1_text);
-
-static const struct snd_kcontrol_new aif1_mux =
-	SOC_DAPM_ENUM("PCM Mux", aif1_enum);
-
 /* I2S Mux / Mux9 */
 static const char *i2s_din_text[] = {
 	"DIN", "DIN1",
-- 
2.7.4


