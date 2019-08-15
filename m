Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3308E81F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfHOJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 05:24:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbfHOJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:24:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20E47EA8BE3E4864AC4B;
        Thu, 15 Aug 2019 17:24:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:24:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <brian.austin@cirrus.com>,
        <Paul.Handrigan@cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs42l56: remove unused variable 'adc_swap_enum'
Date:   Thu, 15 Aug 2019 17:24:36 +0800
Message-ID: <20190815092436.34632-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/cs42l56.c:206:30: warning:
 adc_swap_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs42l56.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index b4d7627..ac569ab 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -199,14 +199,6 @@ static const struct soc_enum beep_bass_enum =
 	SOC_ENUM_SINGLE(CS42L56_BEEP_TONE_CFG, 1,
 			ARRAY_SIZE(beep_bass_text), beep_bass_text);
 
-static const char * const adc_swap_text[] = {
-	"None", "A+B/2", "A-B/2", "Swap"
-};
-
-static const struct soc_enum adc_swap_enum =
-	SOC_ENUM_SINGLE(CS42L56_MISC_ADC_CTL, 3,
-			ARRAY_SIZE(adc_swap_text), adc_swap_text);
-
 static const char * const pgaa_mux_text[] = {
 	"AIN1A", "AIN2A", "AIN3A"};
 
-- 
2.7.4


