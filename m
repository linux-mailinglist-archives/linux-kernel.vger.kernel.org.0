Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB111721D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgB0PHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 10:07:02 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3356 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgB0PHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:07:01 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e57dae999c-6b35d; Thu, 27 Feb 2020 23:06:18 +0800 (CST)
X-RM-TRANSID: 2ee25e57dae999c-6b35d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.163])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e57dae7dd7-0fbc8;
        Thu, 27 Feb 2020 23:06:18 +0800 (CST)
X-RM-TRANSID: 2ee35e57dae7dd7-0fbc8
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     jun.nie@linaro.org
Cc:     shawnguo@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] zte:zx-spdif:remove redundant dev_err message
Date:   Thu, 27 Feb 2020 23:07:01 +0800
Message-Id: <20200227150701.15652-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource has already contains error message, so remove
the redundant dev_err message

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 sound/soc/zte/zx-spdif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index 60382ec23..a3a07c073 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -322,7 +322,6 @@ static int zx_spdif_probe(struct platform_device *pdev)
 	zx_spdif->mapbase = res->start;
 	zx_spdif->reg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(zx_spdif->reg_base)) {
-		dev_err(&pdev->dev, "ioremap failed!\n");
 		return PTR_ERR(zx_spdif->reg_base);
 	}
 
-- 
2.20.1.windows.1



