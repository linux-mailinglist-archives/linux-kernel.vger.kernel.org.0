Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7265512CA6E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfL2Sg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 13:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfL2SgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 13:36:25 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70D2206DB;
        Sun, 29 Dec 2019 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577644584;
        bh=pSG4f8rUYFE6DclwpZXNN72lETzu7ybG9jDiwZbJeJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wPksXbndVe8M28WmimRsuIFr0SfJlJCss8o2cHMbfGzL61HnQSeHg62gQjiWAW6a
         0gcj65IjrfLLM1RCBB/UQHNGTjlW9XvyT3lNta5AP6iVBXckD6STSRV2EvVWbDd/EX
         DgREFWPI8x3I3QW7rnmzCD+xR6Gsp+T7lUga4S/E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] mtd: onenand: samsung: Fix printing format for size_t on 64-bit
Date:   Sun, 29 Dec 2019 19:36:11 +0100
Message-Id: <20191229183612.22133-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229183612.22133-1-krzk@kernel.org>
References: <20191229183612.22133-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print size_t as %zu to fix -Wformat warnings when compiling on 64-bit
platform (e.g. with COMPILE_TEST):

    drivers/mtd/nand/onenand/samsung_mtd.c: In function ‘s5pc110_read_bufferram’:
    drivers/mtd/nand/onenand/samsung_mtd.c:661:16: warning:
        format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
       dev_err(dev, "Couldn't map a %d byte buffer for DMA\n", count);

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/onenand/samsung_mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/samsung_mtd.c b/drivers/mtd/nand/onenand/samsung_mtd.c
index 70501d031db6..4a78c0aed6dd 100644
--- a/drivers/mtd/nand/onenand/samsung_mtd.c
+++ b/drivers/mtd/nand/onenand/samsung_mtd.c
@@ -658,7 +658,7 @@ static int s5pc110_read_bufferram(struct mtd_info *mtd, int area,
 		dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
 	}
 	if (dma_mapping_error(dev, dma_dst)) {
-		dev_err(dev, "Couldn't map a %d byte buffer for DMA\n", count);
+		dev_err(dev, "Couldn't map a %zu byte buffer for DMA\n", count);
 		goto normal;
 	}
 	err = s5pc110_dma_ops(dma_dst, dma_src,
-- 
2.17.1

