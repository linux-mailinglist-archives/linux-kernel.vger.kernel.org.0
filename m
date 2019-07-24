Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91137274D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfGXF1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:27:31 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:35179 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:27:30 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d09 with ME
        id gVTR2000H4n7eLC03VTRSq; Wed, 24 Jul 2019 07:27:28 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Jul 2019 07:27:28 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, gustavo@embeddedor.com,
        patches@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name
Date:   Wed, 24 Jul 2019 07:26:32 +0200
Message-Id: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be 'wm8955_pll_factors()' instead.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/wm8955.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index cd204f79647d..ec82a8fafdf6 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -143,7 +143,7 @@ struct pll_factors {
  * to allow rounding later */
 #define FIXED_FLL_SIZE ((1 << 22) * 10)
 
-static int wm8995_pll_factors(struct device *dev,
+static int wm8955_pll_factors(struct device *dev,
 			      int Fref, int Fout, struct pll_factors *pll)
 {
 	u64 Kpart;
@@ -282,7 +282,7 @@ static int wm8955_configure_clocking(struct snd_soc_component *component)
 
 		/* Use the last divider configuration we saw for the
 		 * sample rate. */
-		ret = wm8995_pll_factors(component->dev, wm8955->mclk_rate,
+		ret = wm8955_pll_factors(component->dev, wm8955->mclk_rate,
 					 clock_cfgs[sr].mclk, &pll);
 		if (ret != 0) {
 			dev_err(component->dev,
-- 
2.20.1

