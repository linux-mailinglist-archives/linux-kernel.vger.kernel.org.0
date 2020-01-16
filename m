Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9A13D6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgAPJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 04:37:18 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:40369 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgAPJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:37:17 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B507522EEB;
        Thu, 16 Jan 2020 10:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579167435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=41ClHMbo7eeE2kUDsrvdrT8WdN5/UCfeLZ2eNI4ME1Y=;
        b=WCsLjsATACe56J1t6rrCOft4hBlmYsh+7bfh+c4I3xVnBJNYGYnxO/k2DO949Y/ye1iq9d
        FmDHVcU6hj9Td7tL2ZnrVk4dVcVD+FrSnuLWxadFMkWUIUdR5Cq2jAes5KqRvTYewqX5q7
        ypqstJQ2Q9WbaeEN5ajNvNYOtL7Q3Lk=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: Fix quad enable for Spansion like flashes
Date:   Thu, 16 Jan 2020 10:37:00 +0100
Message-Id: <20200116093700.28308-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: web
X-Spam-Status: No, score=4.90
X-Spam-Score: 4.90
X-Rspamd-Queue-Id: B507522EEB
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
         NEURAL_HAM(-0.00)[-0.781];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable
methods") forgot to actually set the QE bit in some cases. Thus this
breaks quad mode accesses to flashes which support readback of the
status register-2. Fix it.

Fixes: 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable methods")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index addb6319fcbb..ea0429448207 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2140,6 +2140,8 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
 		return 0;
 
+	nor->bouncebuf[0] |= SR2_QUAD_EN_BIT1;
+
 	return spi_nor_write_16bit_cr_and_check(nor, nor->bouncebuf[0]);
 }
 
-- 
2.20.1

