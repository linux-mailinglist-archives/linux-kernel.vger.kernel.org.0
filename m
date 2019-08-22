Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5D99777
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfHVOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:54:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732015AbfHVOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:54:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 261EB583877201832F75;
        Thu, 22 Aug 2019 22:36:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:36:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <yuehaibing@huawei.com>, <tglx@linutronix.de>,
        <allison@lohutok.net>, <gregkh@linuxfoundation.org>,
        <info@metux.net>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: wm8988: fix typo in wm8988_right_line_controls
Date:   Thu, 22 Aug 2019 22:36:08 +0800
Message-ID: <20190822143608.59824-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/wm8988.c:270:30: warning:
 wm8988_rline_enum defined but not used [-Wunused-const-variable=]

wm8988_rline_enum should be used in wm8988_right_line_controls.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5409fb4e327a ("ASoC: Add WM8988 CODEC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wm8988.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 25e74cf..85bfd04 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -273,7 +273,7 @@ static const struct soc_enum wm8988_rline_enum =
 			      wm8988_line_texts,
 			      wm8988_line_values);
 static const struct snd_kcontrol_new wm8988_right_line_controls =
-	SOC_DAPM_ENUM("Route", wm8988_lline_enum);
+	SOC_DAPM_ENUM("Route", wm8988_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new wm8988_left_mixer_controls[] = {
-- 
2.7.4


