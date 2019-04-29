Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3AE288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfD2M1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 08:27:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbfD2M1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:27:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B11085537030402A0CCD;
        Mon, 29 Apr 2019 20:27:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 29 Apr 2019 20:27:11 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items
Date:   Mon, 29 Apr 2019 12:37:13 +0000
Message-ID: <20190429123713.64280-1-weiyongjun1@huawei.com>
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

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each_entry() macro aptly named
list_for_each_entry_safe().

Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sprd/sprd-mcdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 28f5e649733d..df250f7f2b6f 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -978,12 +978,12 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 
 static int sprd_mcdt_remove(struct platform_device *pdev)
 {
-	struct sprd_mcdt_chan *temp;
+	struct sprd_mcdt_chan *chan, *temp;
 
 	mutex_lock(&sprd_mcdt_list_mutex);
 
-	list_for_each_entry(temp, &sprd_mcdt_chan_list, list)
-		list_del(&temp->list);
+	list_for_each_entry_safe(chan, temp, &sprd_mcdt_chan_list, list)
+		list_del(&chan->list);
 
 	mutex_unlock(&sprd_mcdt_list_mutex);



