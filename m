Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52082601F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGEIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 04:10:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfGEIKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:10:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C8AD79C6AC02954968C4;
        Fri,  5 Jul 2019 16:10:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 5 Jul 2019 16:10:11 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: SOF: debug: fix possible memory leak in sof_dfsentry_write()
Date:   Fri, 5 Jul 2019 08:16:37 +0000
Message-ID: <20190705081637.157169-1-weiyongjun1@huawei.com>
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

'string' is malloced in sof_dfsentry_write() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sof/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 54bb53bfc81b..2388477a965e 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -162,7 +162,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	else
 		ret = kstrtoul(string, 0, &ipc_count);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* limit max duration/ipc count for flood test */
 	if (flood_duration_test) {
@@ -191,7 +191,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 				    "error: debugfs write failed to resume %d\n",
 				    ret);
 		pm_runtime_put_noidle(sdev->dev);
-		return ret;
+		goto out;
 	}
 
 	/* flood test */



