Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177B59B078
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbfHWNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 09:11:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbfHWNLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:11:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 318783CD6D96C5C7B307;
        Fri, 23 Aug 2019 21:11:48 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 21:11:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <yuehaibing@huawei.com>, <daniel.baluta@nxp.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: SOF: imx8: Make some functions static
Date:   Fri, 23 Aug 2019 20:59:39 +0800
Message-ID: <20190823125939.30012-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

sound/soc/sof/imx/imx8.c:104:6: warning: symbol 'imx8_dsp_handle_reply' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:115:6: warning: symbol 'imx8_dsp_handle_request' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:336:5: warning: symbol 'imx8_get_bar_index' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:341:6: warning: symbol 'imx8_ipc_msg_data' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:348:5: warning: symbol 'imx8_ipc_pcm_params' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/imx/imx8.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index e502f58..6404724 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -101,7 +101,7 @@ static int imx8_get_window_offset(struct snd_sof_dev *sdev, u32 id)
 	return MBOX_OFFSET;
 }
 
-void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
+static void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 {
 	struct imx8_priv *priv = imx_dsp_get_data(ipc);
 	unsigned long flags;
@@ -112,7 +112,7 @@ void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
 }
 
-void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
+static void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
 {
 	struct imx8_priv *priv = imx_dsp_get_data(ipc);
 
@@ -333,21 +333,21 @@ static int imx8_remove(struct snd_sof_dev *sdev)
 }
 
 /* on i.MX8 there is 1 to 1 match between type and BAR idx */
-int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+static int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 {
 	return type;
 }
 
-void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
-		       struct snd_pcm_substream *substream,
-		       void *p, size_t sz)
+static void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
+			      struct snd_pcm_substream *substream,
+			      void *p, size_t sz)
 {
 	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
 }
 
-int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
-			struct snd_pcm_substream *substream,
-			const struct sof_ipc_pcm_params_reply *reply)
+static int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       const struct sof_ipc_pcm_params_reply *reply)
 {
 	return 0;
 }
-- 
2.7.4


