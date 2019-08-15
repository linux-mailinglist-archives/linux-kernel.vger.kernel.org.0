Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534728E787
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfHOI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:57:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfHOI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:57:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C69CDD9910CAB35FE07;
        Thu, 15 Aug 2019 16:57:25 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 16:57:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <brian.austin@cirrus.com>, <Paul.Handrigan@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs42l73: remove unused variables 'vsp_output_mux' and 'xsp_output_mux'
Date:   Thu, 15 Aug 2019 16:54:54 +0800
Message-ID: <20190815085454.30384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/cs42l73.c:276:38: warning:
 vsp_output_mux defined but not used [-Wunused-const-variable=]
sound/soc/codecs/cs42l73.c:279:38: warning:
 xsp_output_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs42l73.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a817393..36089f8 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -273,12 +273,6 @@ static SOC_ENUM_SINGLE_DECL(xsp_output_mux_enum,
 			    CS42L73_MIXERCTL, 4,
 			    cs42l73_spo_mixer_text);
 
-static const struct snd_kcontrol_new vsp_output_mux =
-	SOC_DAPM_ENUM("Route", vsp_output_mux_enum);
-
-static const struct snd_kcontrol_new xsp_output_mux =
-	SOC_DAPM_ENUM("Route", xsp_output_mux_enum);
-
 static const struct snd_kcontrol_new hp_amp_ctl =
 	SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 0, 1, 1);
 
-- 
2.7.4


