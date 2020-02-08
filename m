Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76181567E8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 22:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBHVze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 16:55:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBHVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:55:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0Y4R-0007ms-BU; Sat, 08 Feb 2020 21:55:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: davinci-mcasp: remove redundant assignment to variable ret
Date:   Sat,  8 Feb 2020 21:55:23 +0000
Message-Id: <20200208215523.36094-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment to ret is redundant as it is not used in the error
return path and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/ti/davinci-mcasp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index e1e937eb1dc1..450c394b2882 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1764,10 +1764,8 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
 				     GFP_KERNEL);
-		if (!pdata) {
-			ret = -ENOMEM;
+		if (!pdata)
 			return pdata;
-		}
 	} else {
 		/* control shouldn't reach here. something is wrong */
 		ret = -EINVAL;
-- 
2.25.0

