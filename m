Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913DF7A309
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfG3IUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:20:38 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40166 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727129AbfG3IUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:20:38 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6U8JLvX014526;
        Tue, 30 Jul 2019 11:19:22 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id A126062A2E; Tue, 30 Jul 2019 11:19:21 +0300 (IDT)
From:   Avi Fishman <avifishman70@gmail.com>
To:     tudor.ambarus@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, joel@jms.id.au,
        linux-mtd@lists.infradead.org
Cc:     avifishman70@gmail.com, linux-kernel@vger.kernel.org,
        tmaimon77@gmail.com, openbmc@lists.ozlabs.org
Subject: [PATCH v2] mtd: spi-nor: Add Winbond w25q256jvm
Date:   Tue, 30 Jul 2019 11:18:32 +0300
Message-Id: <20190730081832.271125-1-avifishman70@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to w25q256 (besides not supporting QPI mode) but with different ID.
The "JVM" suffix is in the datasheet.
The datasheet indicates DUAL and QUAD are supported.
https://www.winbond.com/resource-files/w25q256jv%20spi%20revi%2010232018%20plus.pdf

Signed-off-by: Avi Fishman <avifishman70@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03cc788511d5..74b41ec92414 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2151,6 +2151,8 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 
-- 
2.18.0

