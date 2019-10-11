Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7FD439B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJKPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:01:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfJKPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:01:14 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 191083191309D95217E8;
        Fri, 11 Oct 2019 23:01:12 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 23:01:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nuno.sa@analog.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.wolfsonmicro.com>,
        <piotrs@opensource.cirrus.com>, <npoushin@opensource.cirrus.com>,
        <paul@crapouillou.net>, <krzk@kernel.org>,
        <enric.balletbo@collabora.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: adau7118: Fix Kconfig warning without CONFIG_I2C
Date:   Fri, 11 Oct 2019 23:00:42 +0800
Message-ID: <20191011150042.20096-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a kernel without CONFIG_I2C, Kconfig warns:

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [n]: I2C [=n]
  Selected by [y]:
  - SND_SOC_ADAU7118_I2C [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

Add missing I2C dependency to SND_SOC_ADAU7118_I2C to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ca514c0f12b0 ("ASOC: Add ADAU7118 8 Channel PDM-to-I2S/TDM Converter driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d196752..6a28741 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -416,6 +416,7 @@ config SND_SOC_ADAU7118_HW
 
 config SND_SOC_ADAU7118_I2C
 	tristate "Analog Devices ADAU7118 8 Channel PDM-to-I2S/TDM Converter - I2C"
+	depends on I2C
 	select SND_SOC_ADAU7118
 	select REGMAP_I2C
 	help
-- 
2.7.4


