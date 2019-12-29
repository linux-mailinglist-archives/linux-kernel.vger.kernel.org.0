Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CBE12CA6B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfL2SgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 13:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfL2SgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 13:36:22 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B14820748;
        Sun, 29 Dec 2019 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577644582;
        bh=czUisFJmY3fA8ZbN0nGTyeSLt61Fc6iQHasHh+W7A9s=;
        h=From:To:Cc:Subject:Date:From;
        b=OjFGQSfOacDRk3KxbOgA5t0fVE9LjnAFKB5NkdlF/9nppBfYnCELFHBJaz+4IHJLO
         RQtOn4nEMbEsM0lH3UgCE50zZDEZLtlyNHAe6t7KBYvC/ZpmJGTVvrrGKrY6HmxqTm
         c1leBBunL0FxfS4RhONrX0bAwo2xFf1DGxWIKnrw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] mtd: onenand: samsung: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
Date:   Sun, 29 Dec 2019 19:36:10 +0100
Message-Id: <20191229183612.22133-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iomem pointers should be casted to unsigned long to avoid
-Wpointer-to-int-cast warnings when compiling on 64-bit platform (e.g.
with COMPILE_TEST):

    drivers/mtd/nand/onenand/samsung_mtd.c: In function ‘s3c_onenand_readw’:
    drivers/mtd/nand/onenand/samsung_mtd.c:251:6: warning:
        cast from pointer to integer of different size [-Wpointer-to-int-cast]
      if ((unsigned int) addr < ONENAND_DATARAM && onenand->bootram_command) {
          ^

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/onenand/samsung_mtd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/onenand/samsung_mtd.c b/drivers/mtd/nand/onenand/samsung_mtd.c
index 55e5536a5850..70501d031db6 100644
--- a/drivers/mtd/nand/onenand/samsung_mtd.c
+++ b/drivers/mtd/nand/onenand/samsung_mtd.c
@@ -248,7 +248,7 @@ static unsigned short s3c_onenand_readw(void __iomem *addr)
 	}
 
 	/* BootRAM access control */
-	if ((unsigned int) addr < ONENAND_DATARAM && onenand->bootram_command) {
+	if ((unsigned long)addr < ONENAND_DATARAM && onenand->bootram_command) {
 		if (word_addr == 0)
 			return s3c_read_reg(MANUFACT_ID_OFFSET);
 		if (word_addr == 1)
@@ -289,7 +289,7 @@ static void s3c_onenand_writew(unsigned short value, void __iomem *addr)
 	}
 
 	/* BootRAM access control */
-	if ((unsigned int)addr < ONENAND_DATARAM) {
+	if ((unsigned long)addr < ONENAND_DATARAM) {
 		if (value == ONENAND_CMD_READID) {
 			onenand->bootram_command = 1;
 			return;
-- 
2.17.1

