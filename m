Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5764413DF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAPPmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 10:42:22 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42683 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:42:21 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BB25522F43;
        Thu, 16 Jan 2020 16:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579189339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6xWghYAZKhcAI7d1RFIR0FqCFeiOMYTF1vtaWqHr7OU=;
        b=Vtzg/RqvODNIxXR+jKfmB1nHKCzSijZDkoDBb38G6I6J6EvJI7HoPnYrgvsblyE55lO8WK
        kfp6ldivNLeo0SNlkfYo6+cxNCkk3TgsNm5+mu6odXDlcV6zs2gTA7dJtyrJHQmd5/aOHZ
        dU6xM0tj2vNfe8ihy9yHZqYpBzDks30=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] mtd: spi-nor: Add support for w25q32jwm
Date:   Thu, 16 Jan 2020 16:42:09 +0100
Message-Id: <20200116154209.32654-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: web
X-Spam-Status: No, score=4.90
X-Spam-Score: 4.90
X-Rspamd-Queue-Id: BB25522F43
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.729];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Winbond W25Q32JW-xM flashes. These have a
programmable QE bit. There is also the W25Q32JW-xQ variant which shares
the ID with the W25Q32DW and W25Q32FW parts. The W25Q32JW-xQ has the QE
bit hard strapped to 1, thus don't support the /HOLD and /WP pins.

This was tested in single, dual and quad mode on a custom board with the
NXP FlexSPI controller. Also the BP bits as well as the TB bit were
tested.

Signed-off-by: Michael Walle <michael@walle.cc>
---
This patch superseeds the following patch:
  https://lore.kernel.org/linux-mtd/20200103223423.14025-1-michael@walle.cc/

changes since v1:
 - renamed flash to w25q32jwm
 - removed untested flashes
 - reworded the commit message

 drivers/mtd/spi-nor/spi-nor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d09a9e38d0bc..8226d6450069 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2651,6 +2651,11 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		"w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
 	{
-- 
2.20.1

