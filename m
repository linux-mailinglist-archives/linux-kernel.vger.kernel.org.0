Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FF173AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgB1PD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 10:03:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36927 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgB1PD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so3532077wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z66mLROcRb3dfNo7Pup4ya4KCgpDgjiDJSKhfyea8EI=;
        b=MVvNfSkauJWhUbnCvTlwgt+WK0GJuss5eYHpGFQNCEYQz5ebG7+YPjkvKOv1Nu5/NH
         lGKXDjNbisRzcp5kNDR5GDcQnnM/FLF8A1kQWpIrmiBlvD6HndP3zNZ2pdMz/0vWSDN5
         /DJ1OmOYhT1ksNTDXlMLMozRdwUfw70TYCBaz3AWyFW3bBL/qXOKt4q5XOV5rhGN2XFN
         LyA6zjTKtr4ZAXUpGC3LmhDSS7kXY7hOmRlk8B/kZL1VSNwJa1MeuKfavVZ5e/6cerYV
         AtUgBNJUEof+ju1iVUGvirpApsFLJisd3BWA5RAejUhOkKbDVP1XNpGSWyOc6Sb7i0ue
         x+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z66mLROcRb3dfNo7Pup4ya4KCgpDgjiDJSKhfyea8EI=;
        b=AlXMJUR/nB6DmbwbYThdHZ+7kpB1EMf00us1zmt5BgbznNq8V8k886u2loO/wZN9+0
         DzFjf4NtX9jWFvhaw8GJWotN2DDq6WBjkpNzijetBopy70EtM0K1EX6BrAZe3bkfOsQA
         on4NycrvHq7WVLZ2vOzEXKr4tYAAB7rObhQ5Y/JWsRqy604IF4oOOwkY08rNF16S9Le1
         +wZWHHzyIkATBG03l1FBnaqXTZl/i2xUcaWCY6Ca8Z+WcW85sHD4HWH8nXOyZEqkxiOP
         LWkcZaAGdnqYWX6lXNGlsFr1vhrCNT/1cWYcUrE8KpRrR64f80+EKDZKUtg4KS/+5QOQ
         Zhiw==
X-Gm-Message-State: APjAAAUMHNtkMWP6Q3EL61WptVmUC+/vFlcYqhaEOIRVBsy6+BCUZrdL
        VmVelB8P5lbh05ET09goFZYdxWzsxlfq5w==
X-Google-Smtp-Source: APXvYqyo6eUltgC/0VeEQHUVYmSWhqQ042mazC8I7e7+T6HHSQXxNVpp3kEy3nkPR2JYd8pilIYjvA==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr5194931wmj.88.1582902205278;
        Fri, 28 Feb 2020 07:03:25 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:24 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 3/6] mtd: spinand: micron: Add new Micron SPI NAND devices
Date:   Fri, 28 Feb 2020 16:03:08 +0100
Message-Id: <20200228150311.12184-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M79A and M78A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index e4aeafc56f4e..5fd1f921ef12 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -101,6 +101,36 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 2Gb 1.8V */
+	SPINAND_INFO("MT29F2G01ABBGD", 0x25,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 3.3V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x14,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 1.8V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x15,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

