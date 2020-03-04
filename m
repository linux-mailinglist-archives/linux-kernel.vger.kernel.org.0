Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B131A178CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgCDItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 03:49:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725271AbgCDItc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:49:32 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CEE30ED56418103D1B42;
        Wed,  4 Mar 2020 16:49:25 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 16:49:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <akshu.agrawal@amd.com>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoc: amd: acp3x: Add missing include <linux/io.h>
Date:   Wed, 4 Mar 2020 16:40:57 +0800
Message-ID: <20200304084057.44764-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 7.4.0 build fails:

In file included from sound/soc/amd/acp3x-rt5682-max9836.c:20:0:
sound/soc/amd/raven/acp3x.h: In function rv_readl:
sound/soc/amd/raven/acp3x.h:113:9: error: implicit declaration of function readl; did you mean rv_readl? [-Werror=implicit-function-declaration]
  return readl(base_addr - ACP3x_PHY_BASE_ADDRESS);
         ^~~~~
         rv_readl
sound/soc/amd/raven/acp3x.h: In function rv_writel:
sound/soc/amd/raven/acp3x.h:118:2: error: implicit declaration of function writel; did you mean rv_writel? [-Werror=implicit-function-declaration]
  writel(val, base_addr - ACP3x_PHY_BASE_ADDRESS);
  ^~~~~~
  rv_writel

Add <linux/io.h> to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 511b8b1..b4f68c5 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/io.h>
 #include <linux/acpi.h>
 
 #include "raven/acp3x.h"
-- 
2.7.4


