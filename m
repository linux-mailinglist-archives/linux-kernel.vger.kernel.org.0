Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217CE14FF76
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBBV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 16:57:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44188 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so15497651wrx.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=AzIFCKPjliPpFkGh+fmHJHVaJmlAB0nzRyLhshxpqjuXCJ5dldnhTBBFiLRKZAzMj9
         s1iGZ1j6GueEzAL3xUWqRz3qh0/ZXQRvdtEjX1JQ+cUbI20/5b8WJv9+Y9oXdw/z01ZE
         ohy1dJ+QJq7+lP7obuazZV/wE9DiwqUZCoPu0Z0W8dII1B4sHZvjihWZpU6NXfm4vz9C
         gihWh7/5XkqC/tQbHXEHB7PDePqPMA85luNxE8qd+LYkn86YyX+IAxVcBtI27C01sdIc
         lk1DqTEsc/ej6k0b5XOwTlvntktdbjtdvd2iBDJOgO1EqUm3CuX53uc+3Lg2fyWRKkiC
         8QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=OC3TMIVVRqSOH3YatKfRV+cmWynpFcMaljgYTgEIhdC4eGf136jnw7jD8PQopZuBFB
         l0rPkTtRNzEzrMj0hVeApZqo8G3hVKbISBuXgrOmaQ9+XI5mRyo+jW5WhmolkJkL77YQ
         OPkelIfEN88UXIfVZ46yP9UYlrM3x6gseJXh+pyBK6GXWVl8bid8UxmLtN1KKQIXWi1v
         eRlUQMoLpQsX2JnptM0hMgaaODFHu8HUOueWTBd2dVBs9MCc5RKtx4KbkLfkXDYbMAA7
         j10McbZZntQ+E2elLu8wodlkf/FPjS8y6gUG41Wljyr/aNMnAQUu+kVjcYPzWXyw0Tsy
         X5ew==
X-Gm-Message-State: APjAAAXO9GmEB9t3nzNICShVFDznYoKNiHhwxs+47zb+WWFl0rMWadZW
        6Np3slEj/Xa444BNtmP2XhU=
X-Google-Smtp-Source: APXvYqyWADPcQWb3wzW2L8wyyXG6TTw2oF3uUCmqwJmL8r3m1gB+F497PdbqJo0ZcNfWm9DNgH6ptA==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr11546492wrv.272.1580680639050;
        Sun, 02 Feb 2020 13:57:19 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:18 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 1/5] mtd: spinand: micron: Generalize the OOB layout structure and function names
Date:   Sun,  2 Feb 2020 22:55:04 +0100
Message-Id: <20200202215508.2928-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202215508.2928-1-sshivamurthy@micron.com>
References: <20200202215508.2928-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

In order to add new Micron SPI NAND devices, we generalized the OOB
layout structure and function names.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..c028d0d7e236 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
+static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
-	region->offset = 64;
-	region->length = 64;
+	region->offset = mtd->oobsize / 2;
+	region->length = mtd->oobsize / 2;
 
 	return 0;
 }
 
-static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
-					 struct mtd_oob_region *region)
+static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
 	/* Reserve 2 bytes for the BBM. */
 	region->offset = 2;
-	region->length = 62;
+	region->length = (mtd->oobsize / 2) - 2;
 
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
-	.ecc = mt29f2g01abagd_ooblayout_ecc,
-	.free = mt29f2g01abagd_ooblayout_free,
+static const struct mtd_ooblayout_ops micron_8_ooblayout = {
+	.ecc = micron_8_ooblayout_ecc,
+	.free = micron_8_ooblayout_free,
 };
 
-static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
-					 u8 status)
+static int micron_8_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
 {
 	switch (status & MICRON_STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

