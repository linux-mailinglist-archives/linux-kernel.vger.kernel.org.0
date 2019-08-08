Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03B85884
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfHHD0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 23:26:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfHHD0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:26:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D308F24227065076C47;
        Thu,  8 Aug 2019 11:26:20 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 11:26:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <steven.eckhoff.opensource@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tscs454: remove unused variable 'PLL_48K_RATE'
Date:   Thu, 8 Aug 2019 11:25:52 +0800
Message-ID: <20190808032552.45360-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable 'PLL_48K_RATE' is never used
so just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tscs454.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 93d84e5..c3587af 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -22,7 +22,6 @@
 
 #include "tscs454.h"
 
-static const unsigned int PLL_48K_RATE = (48000 * 256);
 static const unsigned int PLL_44_1K_RATE = (44100 * 256);
 
 #define COEFF_SIZE 3
-- 
2.7.4


