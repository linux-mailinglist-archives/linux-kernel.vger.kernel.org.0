Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351AC118CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLJPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:43:06 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:42808 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfLJPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:43:06 -0500
X-Greylist: delayed 2323 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 10:43:05 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=JYLcJhGa26ePxUhCLaeVt5gG3fUkiaBnY+uXwvTg0qA=;
        b=RLELJyUDmacFSXsa8R7Tt97fV3tJOUdtlPaZ1LeqB1ELIK4D7sgzOZiSTzIm4uEoC4mH3fMh7qGECVW48jpVxK3CZe1XC8vlBkn9M+F2Nm89MRzCrN5JR0XU/7BpDjOQ2YUoXJZyepDJtLXvmYJkjRfQOpzylpxnA9vKR4QfFI8=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1ieh3e-0002ca-76; Tue, 10 Dec 2019 16:04:16 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     jan.pohanka@merz.cz,
        Christophe Kerello <christophe.kerello@st.com>,
        Martin Devera <devik@eaxlabs.cz>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: rawnand: Fix unexpected timeouts in waitrdy
Date:   Tue, 10 Dec 2019 16:03:18 +0100
Message-Id: <20191210150319.3125-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used way to compute jiffies timeout brokes when
jiffie difference is 1. Simply add 1 - it has no other
side effects.
Fixes STM32MP1 FMC2 NAND controller which sometimes failed
exactly in this way.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 drivers/mtd/nand/raw/nand_base.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d527e448ce19..beab3a775cc7 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -721,7 +721,11 @@ int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 	if (ret)
 		return ret;
 
-	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
+	/* +1 below is necessary because if we are now in the last fraction
+	 * of jiffy and msecs_to_jiffies is 1 then we will wait only that
+	 * small jiffy fraction - possibly leading to false timeout
+	 */
+	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		ret = nand_read_data_op(chip, &status, sizeof(status), true);
 		if (ret)
-- 
2.11.0

