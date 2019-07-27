Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6A779BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfG0PLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 11:11:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728907AbfG0PLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:11:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 07C649C1B7968560C4F0;
        Sat, 27 Jul 2019 23:10:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 23:10:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <paul@crapouillou.net>, <timur@kernel.org>,
        <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
        <festevam@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <matthias.bgg@gmail.com>,
        <jbrunet@baylibre.com>, <khilman@baylibre.com>,
        <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <baohua@kernel.org>,
        <olivier.moysan@st.com>, <arnaud.pouliquen@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <mripard@kernel.org>, <wens@csie.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <yamada.masahiro@socionext.com>,
        <michal.simek@xilinx.com>, <jcmvbkbc@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-tegra@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 29/34] ASoC: meson: axg-spdifout: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 27 Jul 2019 23:07:33 +0800
Message-ID: <20190727150738.54764-30-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190727150738.54764-1-yuehaibing@huawei.com>
References: <20190727150738.54764-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/meson/axg-spdifout.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
index 9dea528..7ce6aa97 100644
--- a/sound/soc/meson/axg-spdifout.c
+++ b/sound/soc/meson/axg-spdifout.c
@@ -401,7 +401,6 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct axg_spdifout *priv;
-	struct resource *res;
 	void __iomem *regs;
 	int ret;
 
@@ -410,8 +409,7 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.7.4


