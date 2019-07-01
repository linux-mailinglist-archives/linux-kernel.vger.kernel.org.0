Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF69F391B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfFGQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 12:15:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49916 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559924107; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=dNmNVq+xBNmC2aSaZCIBq15hV1W6soC2MYtT8KRD0gs=;
        b=c1a9SgGAJqcYFYoBnHmREaUhHUiKk6gPBuGPH8KvwhfD9dZBccZ2l7UFx29y8wzfxQYDyL
        dSgRADlNqdd6nEb4FxD2P5y8BS2GMc4y4ORtCSiXbhRAOMI4NU9GPiMjmliFdcHtayJYMA
        T1i1YVK1LqX2OGEUqFVsAM3lphwBWGU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: jz4740-i2s: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:14:58 +0200
Message-Id: <20190607161500.17379-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 13408de34055..1f596770b01a 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -492,7 +492,7 @@ static const struct of_device_id jz4740_of_matches[] = {
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 #endif
 
-static int jz4740_i2s_dev_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
-- 
2.21.0.593.g511ec345e18

