Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7715008C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgBCCYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 21:24:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbgBCCYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:24:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA699509A795951E0BDF;
        Mon,  3 Feb 2020 10:24:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Feb 2020 10:24:13 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <bardliao@realtek.com>, <oder_chiou@realtek.com>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoc: rt1015: make symbol rt1015_aif_dai_ops and rt1015_dai static
Date:   Mon, 3 Feb 2020 10:18:41 +0800
Message-ID: <20200203021841.121378-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
sound/soc/codecs/rt1015.c: warning: symbol 'rt1015_aif_dai_ops'
was not declared. Should it be static?
sound/soc/codecs/rt1015.c: warning: symbol 'rt1015_dai' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 sound/soc/codecs/rt1015.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 6d490e2dbc25..de8f75d7cf5a 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -841,12 +841,12 @@ static void rt1015_remove(struct snd_soc_component *component)
 #define RT1015_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt1015_aif_dai_ops = {
+static struct snd_soc_dai_ops rt1015_aif_dai_ops = {
 	.hw_params = rt1015_hw_params,
 	.set_fmt = rt1015_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver rt1015_dai[] = {
+static struct snd_soc_dai_driver rt1015_dai[] = {
 	{
 		.name = "rt1015-aif",
 		.id = 0,
-- 
2.20.1

