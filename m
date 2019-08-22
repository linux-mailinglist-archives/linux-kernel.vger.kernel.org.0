Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629F2996B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfHVOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:31:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727894AbfHVOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:31:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58E73C2AD7CFE8B8459A;
        Thu, 22 Aug 2019 22:30:49 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:30:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>,
        <gregkh@linuxfoundation.org>, <maruthi.bayyavarapu@amd.com>,
        <tglx@linutronix.de>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: AMD: Fix Kconfig warning without GPIOLIB
Date:   Thu, 22 Aug 2019 22:30:07 +0800
Message-ID: <20190822143007.73644-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While do rand build without GPIOLIB, we get Kconfig warning:\

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && GPIOLIB [=n]
  Selected by [m]:
  - SND_SOC_AMD_CZ_DA7219MX98357_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP [=m] && I2C [=y]

Add GPIOLIB dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 9ca9214..5f40517 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -10,7 +10,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
 	select REGULATOR
-	depends on SND_SOC_AMD_ACP && I2C
+	depends on SND_SOC_AMD_ACP && I2C && GPIOLIB
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
 
-- 
2.7.4


