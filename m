Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6533F8B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfHMMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:40:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:40:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so49208895plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CsNRmWqktBrPnRr/q3CbDiX2bXuIAHPY6s9E7w9Y9xg=;
        b=auouH/vQnwtjs15xaVH8ZfSpfqmNi5JDJ3VH5G8Q+duuBPhyJ32ZW8rWPqFvytOwwh
         pHmgCVtAruwTf+D5JVHSjPBFioWXsUmvBYeayy/2oQbOW++1cgJoIJkYpXhMZsGvQLU7
         GHdC55GpDNQFTNlvW5I9RyVBFcTlPwGPIfag4pPhmPSyKByp7koQobkNX1CymNwAuW/J
         sVUfOBDyq0rgm+KmyaZoG3+VXMPpkkZ23zEq9Qesks31KHiKhifxbDOMYxsjlz5pLsmN
         AxqHvyIHpDboFiUHVSXCXyZFjYritPam77HOK83v0bYXYyqx7ue+J2Y2xkViBq1yksPi
         j/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CsNRmWqktBrPnRr/q3CbDiX2bXuIAHPY6s9E7w9Y9xg=;
        b=VoAMog6xUsU50qZco7pJPb8MI3aFxWP4y/nefSNKKKerPDNyGkhzKRTAMJAbO1Sxvi
         kdfAvGX8sPM3LrRZbrI4yxtjelEpbWHo52tRqFARIFcYhmJr4vYfrQ1fgB1FDCArEPUe
         B6q26nZDApA2GuFINPLGdwcZo9F0X3VpdvtzRs3cfWRAu7N70rzldoEStQ4UGhZFHl7M
         zN8Yd8fHvbXB3O40Nmv7Y08TNUIOtNxHJs9MU8b+aF74YKJe0VWmv/HSzbpwdS+eJle2
         egiIM+iiU6Gv+2cNApMIi8pLQgmq0dFuQsQBOwq9HDPLI1gTfj/gWrb8AoCfECoUm1Ka
         69Ew==
X-Gm-Message-State: APjAAAVe4c2duA7GafW+hoCh4k8Aa3GCLcNqajPY3w/78ptU/yBtI4+V
        csNBfiCoQ3NvzXyERjqxReW+Rw==
X-Google-Smtp-Source: APXvYqz0Y+zyMGNShM06lKxH0wSqqHQAmBdGxgplxHpWBxcjWBiRsJo4Bc51yxUqQlDavYwASSykiw==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr37888498plp.257.1565700037117;
        Tue, 13 Aug 2019 05:40:37 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v145sm14758467pfc.31.2019.08.13.05.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:40:36 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v8 4/4] mtd: spi-nor: add locking support for is25wp256 device
Date:   Tue, 13 Aug 2019 18:08:15 +0530
Message-Id: <1565699895-4770-5-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
References: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a locking scheme for ISSI devices based on the stm_lock scheme.
The is25wp256  device has 4 bits for selecting the range of blocks to
be locked/protected from erase/write operations and function register
gives feasibility to select the top / bottom area for protection.
Added opcode to read and write function registers.

The current implementation enables block protection as per the table
defined in the datasheet for the is25wp256 device having erase size of
0x1000. ISSI and stm devices differ in terms of TBS (top/bottom area
protection) bits. In case of issi this bit is in Function register and
is OTP memory, so once FR bits are programmed cannot be modified.

Some common code from stm_lock/unlock implementation is extracted so that
it can be re-used for issi devices. The locking scheme has been tested on
HiFive Unleashed board Rev A00  having is25wp256 flash memory.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 265 ++++++++++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |   5 +
 2 files changed, 222 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 24c1c11..247454a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -295,6 +295,29 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+/**
+ * spi_nor_read_fr() - read function register
+ * @nor: pointer to a 'struct spi_nor'.
+ *
+ * ISSI devices have top/bottom area protection bits selection into function
+ * reg. The bits in FR are OTP. So once it's written, it cannot be changed.
+ *
+ * Return: Value in function register or negative if error.
+ */
+static int spi_nor_read_fr(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDFR, &val, 1);
+	if (ret < 0) {
+		pr_err("error %d reading FR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -1095,10 +1118,18 @@ static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 				 uint64_t *len)
 {
 	struct mtd_info *mtd = &nor->mtd;
-	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
-	int shift = ffs(mask) - 1;
+	u8 mask = 0;
+	u8 fr = 0;
+	int shift = 0;
 	int pow;
 
+	if (nor->flags & SNOR_F_HAS_BP3)
+		mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
+	else
+		mask = SR_BP2 | SR_BP1 | SR_BP0;
+
+	shift = ffs(mask) - 1;
+
 	if (!(sr & mask)) {
 		/* No protection */
 		*ofs = 0;
@@ -1106,10 +1137,19 @@ static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	} else {
 		pow = ((sr & mask) ^ mask) >> shift;
 		*len = mtd->size >> pow;
-		if (nor->flags & SNOR_F_HAS_SR_TB && sr & SR_TB)
-			*ofs = 0;
-		else
-			*ofs = mtd->size - *len;
+		/* ISSI device's have top/bottom select bit in func reg */
+		if (JEDEC_MFR(nor->info) == SNOR_MFR_ISSI) {
+			fr = spi_nor_read_fr(nor);
+			if (nor->flags & SNOR_F_HAS_SR_TB && fr & FR_TB)
+				*ofs = 0;
+			else
+				*ofs = mtd->size - *len;
+		} else {
+			if (nor->flags & SNOR_F_HAS_SR_TB && sr & SR_TB)
+				*ofs = 0;
+			else
+				*ofs = mtd->size - *len;
+		}
 	}
 }
 
@@ -1136,18 +1176,108 @@ static int stm_check_lock_status_sr(struct spi_nor *nor, loff_t ofs, uint64_t le
 		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
 }
 
-static int stm_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-			    u8 sr)
+/*
+ * check if memory region is locked
+ *
+ * Returns false if region is locked 0 otherwise.
+ */
+static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				u8 sr)
 {
 	return stm_check_lock_status_sr(nor, ofs, len, sr, true);
 }
 
-static int stm_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-			      u8 sr)
+/*
+ * check if memory region is unlocked
+ *
+ * Returns false if region is locked 0 otherwise.
+ */
+static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				  u8 sr)
 {
 	return stm_check_lock_status_sr(nor, ofs, len, sr, false);
 }
 
+/**
+ * spi_nor_select_zone() - Select top area or bottom area to lock/unlock
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ * @sr: status register
+ * @tb: pointer to top/bottom bool used in caller function
+ * @op: zone selection is for lock/unlock operation. 1: lock 0:unlock
+ *
+ * Select the top area / bottom area pattern to protect memory blocks.
+ *
+ * Returns negative on errors, 0 on success.
+ */
+static int spi_nor_select_zone(struct spi_nor *nor, loff_t ofs, uint64_t len,
+			       u8 sr, bool *tb, bool op)
+{
+	int retval;
+	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+
+	if (op) {
+		/* Select for lock zone operation */
+
+		/*
+		 * If nothing in our range is unlocked, we don't need
+		 * to do anything.
+		 */
+		if (spi_nor_is_locked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is unlocked, we can't use 'bottom'
+		 * protection.
+		 */
+		if (!spi_nor_is_locked_sr(nor, 0, ofs, sr))
+			can_be_bottom = false;
+
+		/*
+		 * If anything above us is unlocked, we can't use 'top'
+		 * protection.
+		 */
+		if (!spi_nor_is_locked_sr(nor, ofs + len,
+					  nor->mtd.size - (ofs + len), sr))
+			can_be_top = false;
+	} else {
+		/* Select unlock zone */
+
+		/*
+		 * If nothing in our range is locked, we don't need to
+		 * do anything.
+		 */
+		if (spi_nor_is_unlocked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is locked, we can't use 'top'
+		 * protection
+		 */
+		if (!spi_nor_is_unlocked_sr(nor, 0, ofs, sr))
+			can_be_top = false;
+
+		/*
+		 * If anything above us is locked, we can't use 'bottom'
+		 * protection
+		 */
+		if (!spi_nor_is_unlocked_sr(nor, ofs + len,
+					    nor->mtd.size - (ofs + len), sr))
+			can_be_bottom = false;
+	}
+
+	if (!can_be_bottom && !can_be_top) {
+		retval = -EINVAL;
+	} else {
+		/* Prefer top, if both are valid */
+		*tb = can_be_top;
+		retval = 1;
+	}
+
+	return retval;
+}
+
 /*
  * Lock a region of the flash. Compatible with ST Micro and similar flash.
  * Supports the block protection bits BP{0,1,2} in the status register
@@ -1185,33 +1315,20 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	struct mtd_info *mtd = &nor->mtd;
 	int status_old, status_new;
 	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
-	u8 shift = ffs(mask) - 1, pow, val;
+	u8 shift = ffs(mask) - 1, pow, val, ret;
 	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
 	bool use_top;
 
 	status_old = read_sr(nor);
 	if (status_old < 0)
 		return status_old;
 
-	/* If nothing in our range is unlocked, we don't need to do anything */
-	if (stm_is_locked_sr(nor, ofs, len, status_old))
+	ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
+	if (!ret)
 		return 0;
+	else if (ret < 0)
+		return ret;
 
-	/* If anything below us is unlocked, we can't use 'bottom' protection */
-	if (!stm_is_locked_sr(nor, 0, ofs, status_old))
-		can_be_bottom = false;
-
-	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!stm_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				status_old))
-		can_be_top = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
@@ -1265,33 +1382,19 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	struct mtd_info *mtd = &nor->mtd;
 	int status_old, status_new;
 	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
-	u8 shift = ffs(mask) - 1, pow, val;
 	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+	u8 shift = ffs(mask) - 1, pow, val, ret;
 	bool use_top;
 
 	status_old = read_sr(nor);
 	if (status_old < 0)
 		return status_old;
 
-	/* If nothing in our range is locked, we don't need to do anything */
-	if (stm_is_unlocked_sr(nor, ofs, len, status_old))
+	ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 0);
+	if (!ret)
 		return 0;
-
-	/* If anything below us is locked, we can't use 'top' protection */
-	if (!stm_is_unlocked_sr(nor, 0, ofs, status_old))
-		can_be_top = false;
-
-	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!stm_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				status_old))
-		can_be_bottom = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
+	else if (ret < 0)
+		return ret;
 
 	/* lock_len: length of region that should remain locked */
 	if (use_top)
@@ -1353,7 +1456,7 @@ static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	if (status < 0)
 		return status;
 
-	return stm_is_locked_sr(nor, ofs, len, status);
+	return spi_nor_is_locked_sr(nor, ofs, len, status);
 }
 
 static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
@@ -1468,6 +1571,69 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 
 /**
+ * issi_lock() - set BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2,3} in status register
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int status_old, status_new, blk_prot;
+	u8 mask;
+	u8 shift;
+	u8 pow, ret;
+	bool use_top;
+	loff_t lock_len;
+
+	if (nor->flags & SNOR_F_HAS_BP3)
+		mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
+	else
+		mask = SR_BP2 | SR_BP1 | SR_BP0;
+
+	shift = ffs(mask) - 1;
+
+	status_old = read_sr(nor);
+
+	/* if status reg is Write protected don't update bit protection */
+	if (status_old & SR_SRWD) {
+		dev_err(nor->dev,
+			"SR is write protected, can't update BP bits...\n");
+		return -EINVAL;
+	}
+
+	ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
+	if (!ret)
+		/* Older protected blocks include the new requested block's */
+		return 0;
+	else if (ret < 0)
+		return ret;
+
+	/* lock_len: length of region that should end up locked */
+	if (use_top)
+		lock_len = nor->mtd.size - ofs;
+	else
+		lock_len = ofs + len;
+
+	pow = order_base_2(lock_len);
+	blk_prot = mask & (((pow + 1) & 0xf) << shift);
+	if (lock_len <= 0) {
+		dev_err(nor->dev, "invalid Length to protect");
+		return -EINVAL;
+	}
+
+	status_new = status_old | blk_prot;
+	if (status_old == status_new)
+		return 0;
+
+	return write_sr_and_check(nor, status_new, mask);
+}
+
+/**
  * issi_unlock() - clear BP[0123] write-protection.
  * @nor: pointer to a 'struct spi_nor'.
  * @ofs: offset from which to unlock memory.
@@ -4268,6 +4434,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
 	    info->flags & SPI_NOR_HAS_LOCK &&
 	    info->flags & SPI_NOR_HAS_BP3) {
+		nor->flash_lock = issi_lock;
 		nor->flash_unlock = issi_unlock;
 	}
 
@@ -4291,6 +4458,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 	if (info->flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
+	if (info->flags & SPI_NOR_HAS_BP3)
+		nor->flags |= SNOR_F_HAS_BP3;
 
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4f92dbb..f5d09f7 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -40,6 +40,8 @@
 #define SPINOR_OP_RDSR		0x05	/* Read status register */
 #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
 #define SPINOR_OP_RDSR2		0x3f	/* Read status register 2 */
+#define SPINOR_OP_RDFR		0x48	/* Read Function register */
+#define SPINOR_OP_WRFR		0x42	/* Write Function register 1 byte */
 #define SPINOR_OP_WRSR2		0x3e	/* Write status register 2 */
 #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
@@ -139,6 +141,9 @@
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
 
+/*Function register bit */
+#define FR_TB			BIT(1)	/*ISSI: Top/Bottom protect */
+
 /* Flag Status Register bits */
 #define FSR_READY		BIT(7)	/* Device status, 0 = Busy, 1 = Ready */
 #define FSR_E_ERR		BIT(5)	/* Erase operation status */
-- 
1.9.1

