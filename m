Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88D45D64C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGBSkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 14:40:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37523 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:40:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so6211995pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HLwmzLi1yfKWX7bsvh9XjKbOb6xGSrI3n8VIDgMLyvM=;
        b=DhIW6pr0vFkNlDLyEZAN6uefpAl5PITwPdIKPacB4h2bOS6eUWkq5WYjyfo1gfJZb8
         FNN46uUqM6JBsXb5907IBastGSfKZzbIfgs5CX2EInHtZnLurHEzdreJSz0R4rFRkaHI
         6ZDH/R7PlUPzLjfhcRHmIYEz9EXHa/Pw632YYrZPNL3TB0PVvVI3Wr71FQKG1t+ppWwY
         ulSiEtqANx53KjSAPAoEzBvrSht9UKTzXBJgmJ+P+A6fCx44uYyAKMZbSrIXUNZ6NRRl
         JZQRIYR5WDD1SJSXJibVV1bh3rO3qg8U6wJDChIeVrI1s/BllN1JwYmZbUo9bRbRRp7C
         oDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLwmzLi1yfKWX7bsvh9XjKbOb6xGSrI3n8VIDgMLyvM=;
        b=jFEO8L7xumxxTHdLhTWzW7KkNgNyDFgltLmgDoueRlG8I+eaNd0jlvfFF7bJkX3FnL
         Ys6dtGOLfwABYWkklLnFlyRyNFKbIIHWUUaoEU3QH7/PEm747+4eaXAajBbeonhCwhwE
         8B/KPciSnqfDlfWyy6vF+C2xHzN5XjPFJfd3CtvCCoa9c4RJTuadwIDE016oMcD1x0nr
         TD0LIYZSVvBgViW4VApkf/crJO9FcPB1ME67thLg+qyeYKg4KHimKF1fX5DG8Js5FQZh
         80f3SFWbEbGin6NsOlmsuEr0p7qm7Z1id0DUf49ZrO0bDto3jU5JoKcmO5t8FycMYD1l
         GKmQ==
X-Gm-Message-State: APjAAAVwnBH4bmKaOdA6BzLGLzbEuY7sCslAhPNL9CYoNFH8BGnR/u9n
        AgVdJUWlCrQp29teJGZ39lA1OQ==
X-Google-Smtp-Source: APXvYqw0SDghowWJigY8inIjqR03Te8MELhI4tmCPOYVFG2+hjsLypcXBgsFvLL9Lp0iyasIniV3QQ==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr6978722pjs.109.1562092824249;
        Tue, 02 Jul 2019 11:40:24 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e10sm15065327pfi.173.2019.07.02.11.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 11:40:23 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v7 3/4] mtd: spi-nor: add support to unlock the flash device
Date:   Wed,  3 Jul 2019 00:09:04 +0530
Message-Id: <1562092745-11541-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
have memory blocks guarded by block protection bits BP[0,1,2,3].
Add an identifier within the flash info structure to indicate that a
particular flash device has the fourth block protect bit (SPI_NOR_HAS_BP3).

Increase size of flash_info flags from u16 to u32 to avoid flag overflow
due SPI_NOR_HAS_BP3.
Clear block protection bits unlocks the flash memory regions.

Based on code developed by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>.
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

spell correction: "Configuration" in spansion_quad_enable function
description.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 72 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 315eeec..4ed241d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -250,7 +250,7 @@ struct flash_info {
 	u16		page_size;
 	u16		addr_width;
 
-	u16		flags;
+	u32		flags;
 #define SECT_4K			BIT(0)	/* SPINOR_OP_BE_4K works uniformly */
 #define SPI_NOR_NO_ERASE	BIT(1)	/* No erase command needed */
 #define SST_WRITE		BIT(2)	/* use SST byte programming */
@@ -279,6 +279,13 @@ struct flash_info {
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
 #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
+#define SPI_NOR_HAS_BP3		BIT(16)	/*
+					 * Flash SR has block protect bits
+					 * for lock/unlock purpose, few support
+					 * BP0-BP2 while few support BP0-BP3.
+					 * This flag identifies devices that
+					 * support BP3 bit.
+					 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -1461,7 +1468,55 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * spansion_quad_enable() - set QE bit in Configuraiton Register.
+ * issi_unlock() - clear BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to unlock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret, val;
+	u8 mask;
+
+	if (nor->flags & SNOR_F_HAS_BP3)
+		mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
+	else
+		mask = SR_BP2 | SR_BP1 | SR_BP0;
+
+	val = read_sr(nor);
+	if (val < 0)
+		return val;
+	if (!(val & mask))
+		return 0;
+
+	write_enable(nor);
+
+	write_sr(nor, val & ~mask);
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = read_sr(nor);
+	if (ret > 0 && !(ret & mask)) {
+		dev_info(nor->dev, "ISSI block protect bits cleared SR: 0x%x\n",
+			 ret);
+		ret = 0;
+	} else {
+		dev_err(nor->dev, "ISSI block protect bits not cleared\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/**
+ * spansion_quad_enable() - set QE bit in Configuration Register.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Set the Quad Enable (QE) bit in the Configuration Register.
@@ -1859,8 +1914,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_4B_OPCODES)
-			.fixups = &is25lp256_fixups },
+			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
+			SPI_NOR_HAS_BP3)
+			.fixups = &is25lp256_fixups
+	},
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
@@ -4110,6 +4167,13 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flash_is_locked = stm_is_locked;
 	}
 
+	/* NOR protection support for ISSI chips */
+	if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
+	    info->flags & SPI_NOR_HAS_LOCK &&
+	    info->flags & SPI_NOR_HAS_BP3) {
+		nor->flash_unlock = issi_unlock;
+	}
+
 	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
 		mtd->_lock = spi_nor_lock;
 		mtd->_unlock = spi_nor_unlock;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b0e42b3..f6fa70f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -127,6 +127,7 @@
 #define SR_BP0			BIT(2)	/* Block protect 0 */
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
+#define SR_BP3			BIT(5)	/* Block protect 3 */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 /* Spansion/Cypress specific status bits */
@@ -244,6 +245,7 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_4B_OPCODES	= BIT(7),
 	SNOR_F_HAS_4BAIT	= BIT(8),
+	SNOR_F_HAS_BP3		= BIT(9),
 };
 
 /**
-- 
1.9.1

