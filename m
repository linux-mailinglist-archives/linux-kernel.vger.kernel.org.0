Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D6133AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 06:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgAHFNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 00:13:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:13:33 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0085DE3h092179;
        Tue, 7 Jan 2020 23:13:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578460394;
        bh=K6TSP0qpy5G2KXs5Ow1U+jMrjR6keI4RxoNRDoq1gQA=;
        h=From:To:CC:Subject:Date;
        b=MOL4lhLXY/7q4XDFp1s3igygnqRm/PO4Lz3I+3A5qqwOb23Pm2imq250/ar/+JUMC
         /c6HjraJsPwPNCNlV2Ok5HEjq1ULsWZnaZNuIbcRhuqqEcbgSMklBj/DmYeakJedtu
         jyXUTBNC++LVvWfuKxzjizGY1OGiJyDTmSEez1HE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0085DEbF101421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 23:13:14 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 23:13:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 23:13:13 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0085DBgd092701;
        Tue, 7 Jan 2020 23:13:12 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: Fix selection of 4-byte addressing opcodes on Spansion
Date:   Wed, 8 Jan 2020 10:43:43 +0530
Message-ID: <20200108051343.1939-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd->size is still unassigned when running spansion_post_sfdp_fixups()
hook, therefore use nor->params.size to determine the size of flash device.

This makes sure that 4-byte addressing opcodes are used on Spansion
flashes that are larger than 16MiB and don't have SFDP 4BAIT table
populated.

Fixes: 92094ebc385e ("mtd: spi-nor: Add spansion_post_sfdp_fixups()")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1082b6bb1393..cd47f07deff3 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4783,9 +4783,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 
 static void spansion_post_sfdp_fixups(struct spi_nor *nor)
 {
-	struct mtd_info *mtd = &nor->mtd;
-
-	if (mtd->size <= SZ_16M)
+	if (nor->params.size <= SZ_16M)
 		return;
 
 	nor->flags |= SNOR_F_4B_OPCODES;
-- 
2.24.1

