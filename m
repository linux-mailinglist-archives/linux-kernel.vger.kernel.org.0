Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9855F159630
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgBKRcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 12:32:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52116 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgBKRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581442322; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=repdNbTnvNyihZR5giRVucEDG3b0naplUOtLwuModh0=;
        b=yRb8+/31bMmrAPPCBKhT/7KIotyo4Yux58c2CBcNkxcaluCL9F4YJy5Ge1EiwRKpF7HpGf
        +gNsrIMrii+X2GYnJ1jDSgfIksGrHRQJ4cM8/hmDg1oJYOuCBsJLMUqA6ej+C8SnR/mWCb
        vZy37oEaIjmi7JkA94PxjWimZx8/6Lc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     od@zcrc.me, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mtd: rawnand: ingenic: Use devm_platform_ioremap_resource()
Date:   Tue, 11 Feb 2020 14:31:51 -0300
Message-Id: <20200211173151.27587-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() instead of platform_get_resource()
+ devm_ioremap_resource().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index c954189606f6..8e22cd6ec71f 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -124,7 +124,6 @@ int ingenic_ecc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ingenic_ecc *ecc;
-	struct resource *res;
 
 	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
 	if (!ecc)
@@ -134,8 +133,7 @@ int ingenic_ecc_probe(struct platform_device *pdev)
 	if (!ecc->ops)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ecc->base = devm_ioremap_resource(dev, res);
+	ecc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ecc->base))
 		return PTR_ERR(ecc->base);
 
-- 
2.25.0

