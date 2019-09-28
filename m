Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFDFC102B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfI1IRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 04:17:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfI1IRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:17:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E62930C0D2E4C2D86C5;
        Sat, 28 Sep 2019 16:17:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 16:17:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mirq-linux@rere.qmqm.pl>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: atmel: Fix build error
Date:   Sat, 28 Sep 2019 16:16:41 +0800
Message-ID: <20190928081641.44232-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when do randbuilding, I got this error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
(.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'

This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/atmel/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c22..79e45f2 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,10 +12,14 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
+	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
 
 config SND_ATMEL_SOC_SSC
 	tristate
-- 
2.7.4


