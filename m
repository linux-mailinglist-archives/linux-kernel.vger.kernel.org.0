Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619E1D3DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfJKK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 06:57:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfJKK51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:57:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2080A3BA948A5F34A716;
        Fri, 11 Oct 2019 18:57:25 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 18:57:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: fsl_mqs: fix old-style function declaration
Date:   Fri, 11 Oct 2019 18:56:06 +0800
Message-ID: <20191011105606.19428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warn about this:

sound/soc/fsl/fsl_mqs.c:146:1: warning:
 static is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/fsl_mqs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index f7fc44e..0c813a4 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -143,7 +143,7 @@ static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
 				   MQS_EN_MASK, 0);
 }
 
-const static struct snd_soc_component_driver soc_codec_fsl_mqs = {
+static const struct snd_soc_component_driver soc_codec_fsl_mqs = {
 	.idle_bias_on = 1,
 	.non_legacy_dai_naming	= 1,
 };
-- 
2.7.4


