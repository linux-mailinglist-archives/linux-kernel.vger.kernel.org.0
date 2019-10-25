Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC5E4ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504329AbfJYMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:12:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504267AbfJYMMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:12:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 738D24CAAFE8FB8B20EE;
        Fri, 25 Oct 2019 20:11:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 20:11:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mripard@kernel.org>, <wens@csie.org>,
        <dannym@scratchpost.org>, <kuninori.morimoto.gx@renesas.com>,
        <tglx@linutronix.de>, <yuehaibing@huawei.com>,
        <georgii.staroselskii@emlid.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: sunxi: sun4i-codec: remove unneeded semicolon
Date:   Fri, 25 Oct 2019 20:08:01 +0800
Message-ID: <20191025120801.16236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index ee448d5..34f3e0b 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1442,7 +1442,7 @@ static struct snd_soc_card *sun8i_a23_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
@@ -1480,7 +1480,7 @@ static struct snd_soc_card *sun8i_h3_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
@@ -1518,7 +1518,7 @@ static struct snd_soc_card *sun8i_v3s_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
-- 
2.7.4


