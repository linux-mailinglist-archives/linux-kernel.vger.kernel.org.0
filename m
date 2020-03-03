Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368FC177466
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgCCKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:39:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37698 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgCCKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:39:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j94x5-0004rs-MU; Tue, 03 Mar 2020 10:39:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoc: amd: use correct format specifier for a long int
Date:   Tue,  3 Mar 2020 10:39:03 +0000
Message-Id: <20200303103903.9259-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the format specifier %d is being used for a long int. Fix
the by using %ld instead.

Fixes warning:
sound/soc/amd/acp3x-rt5682-max9836.c:341:23: warning: format '%d'
 expects argument of type 'int', but argument 3 has type
 'long int' [-Wformat=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 511b8b1722aa..521c9ab4c29c 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -338,7 +338,7 @@ static int acp3x_probe(struct platform_device *pdev)
 
 	dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
 	if (IS_ERR(dmic_sel)) {
-		dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
+		dev_err(&pdev->dev, "DMIC gpio failed err=%ld\n",
 			PTR_ERR(dmic_sel));
 		return PTR_ERR(dmic_sel);
 	}
-- 
2.25.0

