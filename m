Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8632CCCF22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfJFHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 03:23:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbfJFHXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:23:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90AA93774B1F60D3DFA7;
        Sun,  6 Oct 2019 15:22:58 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 15:22:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <ckeepax@opensource.cirrus.com>,
        <rf@opensource.wolfsonmicro.com>, <piotrs@opensource.cirrus.com>,
        <enric.balletbo@collabora.com>, <paul@crapouillou.net>,
        <srinivas.kandagatla@linaro.org>, <andradanciu1997@gmail.com>,
        <mirq-linux@rere.qmqm.pl>, <kuninori.morimoto.gx@renesas.com>,
        <m.felsch@pengutronix.de>, <shifu0704@thundersoft.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoc: tas2770: Fix build error without GPIOLIB
Date:   Sun, 6 Oct 2019 15:22:41 +0800
Message-ID: <20191006072241.56808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If GPIOLIB is not set, building fails:

sound/soc/codecs/tas2770.c: In function tas2770_reset:
sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
   ^~~~~~~~~~~~~~~~~~~~~~~~
   gpio_set_value_cansleep
sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
  tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
                        ^~~~~~~~~~~~~~~~~~~~~~~
                        devm_regulator_get_optional
sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
             GPIOD_OUT_HIGH);
             ^~~~~~~~~~~~~~
             GPIOF_INIT_HIGH

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bcac957..d639f17 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1108,6 +1108,7 @@ config SND_SOC_TAS2552
 config SND_SOC_TAS2770
 	tristate "Texas Instruments TAS2770 speaker amplifier"
 	depends on I2C
+	select GPIOLIB
 
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
-- 
2.7.4


