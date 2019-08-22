Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9698BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfHVGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 02:49:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbfHVGtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:49:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67FFFAA4886793855108;
        Thu, 22 Aug 2019 14:49:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 22 Aug 2019 14:49:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Maxime Ripard" <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in sun4i_i2s_init_regmap_fields()
Date:   Thu, 22 Aug 2019 06:52:52 +0000
Message-ID: <20190822065252.74028-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9e691baee1e8..2071c54265f3 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1095,10 +1095,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	i2s->field_fmt_sr =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_sr);
-	if (IS_ERR(i2s->field_fmt_sr))
-		return PTR_ERR(i2s->field_fmt_sr);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)





