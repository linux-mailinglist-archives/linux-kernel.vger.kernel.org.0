Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82591339EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 05:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHEEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 23:04:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgAHEEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:04:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF6DA3285E508FE6DC2B;
        Wed,  8 Jan 2020 12:04:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 12:03:58 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next]  ASoC: amd: acp3x: Fix return value check in acp3x_dai_probe()
Date:   Wed, 8 Jan 2020 03:59:54 +0000
Message-ID: <20200108035954.51317-1-weiyongjun1@huawei.com>
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

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: c9fe7db6e884 ("ASoC: amd: Refactoring of DAI from DMA driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index d9b287b8396c..bf51cadf8682 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -321,8 +321,8 @@ static int acp3x_dai_probe(struct platform_device *pdev)
 	}
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
-	if (IS_ERR(adata->acp3x_base))
-		return PTR_ERR(adata->acp3x_base);
+	if (!adata->acp3x_base)
+		return -ENOMEM;
 
 	adata->i2s_irq = res->start;
 	dev_set_drvdata(&pdev->dev, adata);



