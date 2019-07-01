Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7354124170
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfETTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 15:45:09 -0400
Received: from mx.allycomm.com ([138.68.30.55]:63149 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfETTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:45:09 -0400
Received: from allycomm.com (184-23-191-215.vpn.dynamic.sonic.net [184.23.191.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id D94353BCD7;
        Mon, 20 May 2019 12:45:07 -0700 (PDT)
From:   Jeff Kletsky <lede@allycomm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     Jeff Kletsky <git-commits@allycomm.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mtd: spinand: Add support for two-byte device IDs
Date:   Mon, 20 May 2019 12:44:53 -0700
Message-Id: <20190520194454.32175-3-lede@allycomm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194454.32175-1-lede@allycomm.com>
References: <20190520194454.32175-1-lede@allycomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kletsky <git-commits@allycomm.com>

The GigaDevice GD5F1GQ4UFxxG SPI NAND utilizes two-byte device IDs.

http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/

Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 2 +-
 include/linux/mtd/spinand.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fa87ae28cdfe..a13154785dad 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -853,7 +853,7 @@ spinand_select_op_variant(struct spinand_device *spinand,
  */
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u8 devid)
+			   unsigned int table_size, u16 devid)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 05fe98eebe27..8901ba272538 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -290,7 +290,7 @@ struct spinand_ecc_info {
  */
 struct spinand_info {
 	const char *model;
-	u8 devid;
+	u16 devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
 	struct nand_ecc_req eccreq;
@@ -445,7 +445,7 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 
 int spinand_match_and_init(struct spinand_device *dev,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u8 devid);
+			   unsigned int table_size, u16 devid);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
-- 
2.20.1

