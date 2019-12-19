Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25B0125C70
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLSIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 03:12:49 -0500
Received: from mail1.windriver.com ([147.11.146.13]:38401 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfLSIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:12:49 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 03:12:44 EST
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id xBJ8CGdF015226
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 00:12:16 -0800 (PST)
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.112) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.468.0; Thu, 19 Dec 2019 00:12:15 -0800
From:   Jiwei Sun <jiwei.sun@windriver.com>
To:     <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <jiwei.sun.bj@qq.com>, <jiwei.sun@windriver.com>
Subject: [PATCH] mtd: spi-nor: make s25fl129p1 skip SFDP parsing
Date:   Thu, 19 Dec 2019 16:12:12 +0800
Message-ID: <20191219081212.16927-1-jiwei.sun@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jsun4 <jiwei.sun@windriver.com>

The right page size of S25FL129P has been gotten in the function
spi_nor_info_init_params() before invoking spi_nor_parse_bfpt(),
it is 256-bytes, but the size will be changed to 512 bytes in the
following function spi_nor_parse_bfpt(). And there is no explanation of
the SFDP according to the datasheet of S25FL129P. So we can skip
SFDP parsing.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f4afe123e9dc..dcb4471c735c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2504,7 +2504,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
 	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },
 	{ "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR | SPI_NOR_SKIP_SFDP) },
 	{ "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8, 0) },
 	{ "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16, 0) },
 	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32, 0) },
-- 
2.20.1

