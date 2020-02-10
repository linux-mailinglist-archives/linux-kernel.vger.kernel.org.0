Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F2157E16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgBJPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 10:05:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbgBJPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:05:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AD5DEF4CB4E4FB8C5F8;
        Mon, 10 Feb 2020 23:05:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 23:05:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: wcd934x: Remove set but not unused variable 'hph_comp_ctrl7'
Date:   Mon, 10 Feb 2020 23:04:21 +0800
Message-ID: <20200210150421.34680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/wcd934x.c: In function wcd934x_codec_hphdelay_lutbypass:
sound/soc/codecs/wcd934x.c:3395:6: warning: variable hph_comp_ctrl7 set but not used [-Wunused-but-set-variable]

commit da3e83f8bb86 ("ASoC: wcd934x: add audio routings")
involved this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wcd934x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 158e878..11c0439 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3392,18 +3392,15 @@ static void wcd934x_codec_hphdelay_lutbypass(struct snd_soc_component *comp,
 {
 	u8 hph_dly_mask;
 	u16 hph_lut_bypass_reg = 0;
-	u16 hph_comp_ctrl7 = 0;
 
 	switch (interp_idx) {
 	case INTERP_HPHL:
 		hph_dly_mask = 1;
 		hph_lut_bypass_reg = WCD934X_CDC_TOP_HPHL_COMP_LUT;
-		hph_comp_ctrl7 = WCD934X_CDC_COMPANDER1_CTL7;
 		break;
 	case INTERP_HPHR:
 		hph_dly_mask = 2;
 		hph_lut_bypass_reg = WCD934X_CDC_TOP_HPHR_COMP_LUT;
-		hph_comp_ctrl7 = WCD934X_CDC_COMPANDER2_CTL7;
 		break;
 	default:
 		return;
-- 
2.7.4


