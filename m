Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44917391B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfFGQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 12:15:16 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49954 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559924109; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doKixQ7W0O1D5yIB0/xlxEE1qSMkwghu0cqqt9JXGok=;
        b=frky9jDcJVgbnbbm9pGfN8fmnoOcJwhU8U2XmVkgGPqBOWNUF699DMPM+fckGPglNpqt4x
        +QHPzDFwIjmBhC0oSq0QoqbEOo+HuDcGcklRNNB7BB5u6IXrEGiR73ZgmK/wNq7c8m1Cte
        jvbLwe3O5D6TYKLZl6VvkQ9aIk6HI/A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ASoC/codecs: jz4725b: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:15:00 +0200
Message-Id: <20190607161500.17379-3-paul@crapouillou.net>
In-Reply-To: <20190607161500.17379-1-paul@crapouillou.net>
References: <20190607161500.17379-1-paul@crapouillou.net>
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
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 766354c73076..eef7221e4acd 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -541,7 +541,7 @@ static const struct regmap_config jz4725b_codec_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-static int jz4725b_codec_probe(struct platform_device *pdev)
+static int __init_or_module jz4725b_codec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz_icdc *icdc;
-- 
2.21.0.593.g511ec345e18

