Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217798645D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfHHOdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 10:33:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbfHHOdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:33:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B9AE89DE7B6DE5071C57;
        Thu,  8 Aug 2019 22:33:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 22:32:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kstewart@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: max98926: remove two unused variables
Date:   Thu, 8 Aug 2019 22:32:15 +0800
Message-ID: <20190808143215.65904-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/max98926.c:28:26: warning:
 max98926_dai_txt defined but not used [-Wunused-const-variable=]
sound/soc/codecs/max98926.c:23:27: warning:
 max98926_boost_current_txt defined but not used [-Wunused-const-variable=]

They are never used, so can be removd.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/max98926.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 818c030..c4dfa8a 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -20,15 +20,6 @@ static const char * const max98926_boost_voltage_txt[] = {
 	"6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V"
 };
 
-static const char * const max98926_boost_current_txt[] = {
-	"0.6", "0.8", "1.0", "1.2", "1.4", "1.6", "1.8", "2.0",
-	"2.2", "2.4", "2.6", "2.8", "3.2", "3.6", "4.0", "4.4"
-};
-
-static const char *const max98926_dai_txt[] = {
-	"Left", "Right", "LeftRight", "LeftRightDiv2",
-};
-
 static const char *const max98926_pdm_ch_text[] = {
 	"Current", "Voltage",
 };
-- 
2.7.4


